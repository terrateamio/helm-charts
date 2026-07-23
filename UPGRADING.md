# Upgrading the Terrateam Helm Chart

This guide covers routine chart upgrades and the one operation that genuinely needs
planning: moving the bundled PostgreSQL to a new major version.

For the 0.x to 1.x restructure, see [MIGRATION.md](MIGRATION.md).

## Before every upgrade

Back up the database. If you use the bundled PostgreSQL:

```shell
kubectl exec -n <namespace> deploy/terrateam-db -- \
  pg_dumpall -U terrateam > terrateam-backup-$(date +%Y%m%d).sql
```

If you use an external or managed PostgreSQL, take a snapshot with your provider's tooling.

Then review what will change:

```shell
helm diff upgrade terrateam terrateamio/terrateam -f your-values.yaml   # requires the helm-diff plugin
```

## Routine upgrades

```shell
helm repo update
helm upgrade terrateam terrateamio/terrateam -f your-values.yaml
kubectl rollout status deploy/terrateam-server -n <namespace>
```

The Terrateam Deployment defaults to the `Recreate` strategy, so the old pod stops before the
new one starts and only one version of Terrateam talks to the database at a time. Expect a short
outage while the new pod becomes ready. If you run multiple replicas and prefer no downtime:

```yaml
terrateam:
  strategy:
    type: RollingUpdate
```

If an upgrade goes wrong:

```shell
helm rollback terrateam
```

Note that `helm rollback` restores the Kubernetes manifests, not your data, and it cannot undo a
PostgreSQL major-version change. It also cannot roll the application back if
`terrateam.image.tag` is a floating tag such as `latest` — pin a specific tag if you want
reproducible rollbacks:

```yaml
terrateam:
  image:
    tag: "20260101"
```

## PostgreSQL major version upgrades

**This is the one upgrade that is not in place.** PostgreSQL refuses to start against a data
directory written by a different major version, and fails with:

```
FATAL: database files are incompatible with server
DETAIL: The data directory was initialized by PostgreSQL version 14, which is not compatible
        with this version 17.10.
```

Your data is not damaged when this happens — PostgreSQL declines to touch it — but Terrateam is
down until you complete the migration below or pin the old tag again. The database pod enters
`CrashLoopBackOff` and the Terrateam pod waits in `Init:0/1`, so nothing runs against a
half-migrated database.

You can recover from this state at any point: the procedure below works whether you read it
before upgrading or after the upgrade has already failed.

This affects you only if you use the bundled database (`db.enabled=true`, the default) and have
not pinned `db.image.tag` to your current major version. Chart 2.0.0 moves the bundled PostgreSQL
from 14 to 17.

### Option 1: defer the upgrade

Stay on your current major version and upgrade the chart normally:

```yaml
db:
  image:
    tag: "14.23-alpine"
```

PostgreSQL 14 reaches end of life in November 2026, so treat this as a way to decouple the chart
upgrade from the database upgrade, not as a permanent answer.

### Option 2: dump and restore

1. **Back up**, with the old chart version still running:

   ```shell
   kubectl exec -n <namespace> deploy/terrateam-db -- \
     pg_dumpall -U terrateam > terrateam-backup.sql
   ```

   Check the dump is not empty and ends with `PostgreSQL database cluster dump complete`:

   ```shell
   tail -3 terrateam-backup.sql
   ```

   You can still take this backup after an upgrade has already failed, by pinning the old tag
   again with `--set db.image.tag=14.23-alpine` and waiting for the database to come back.

2. **Scale both deployments down.** The database must be stopped before its PersistentVolumeClaim
   can be deleted, otherwise the delete blocks on the `pvc-protection` finalizer:

   ```shell
   kubectl scale deploy/terrateam-server -n <namespace> --replicas=0
   kubectl scale deploy/terrateam-db -n <namespace> --replicas=0
   kubectl wait --for=delete pod -n <namespace> -l app.kubernetes.io/name=terrateam-db --timeout=90s
   ```

3. **Delete the old PersistentVolumeClaim.** From chart 2.0.0 the PVC carries
   `helm.sh/resource-policy: keep`, so Helm will not remove it for you:

   ```shell
   kubectl delete pvc terrateam-db-data-claim -n <namespace>
   ```

   Only do this once you have verified the dump in step 1.

4. **Upgrade the chart, keeping Terrateam itself down.** Helm recreates the missing PVC and the new
   PostgreSQL initialises it. `terrateam.replicaCount=0` matters: without it the server starts
   against the empty database and runs its migrations, which then collide with your restore.

   ```shell
   helm upgrade terrateam terrateamio/terrateam -f your-values.yaml \
     --set terrateam.replicaCount=0
   kubectl rollout status deploy/terrateam-db -n <namespace>
   ```

   If you use the autoscaler, `terrateam.replicaCount` is ignored, so scale the deployment down by
   hand instead once the upgrade completes.

5. **Restore:**

   ```shell
   kubectl exec -i -n <namespace> deploy/terrateam-db -- \
     psql -U terrateam -d terrateam < terrateam-backup.sql
   ```

6. **Bring Terrateam back** by upgrading again without the replica override:

   ```shell
   helm upgrade terrateam terrateamio/terrateam -f your-values.yaml
   kubectl rollout status deploy/terrateam-server -n <namespace>
   ```

### Option 3: move to a managed PostgreSQL

Restoring the dump into a managed service and setting `db.enabled=false` avoids ever doing this
again, and is what we recommend for anything beyond an evaluation install:

```yaml
db:
  enabled: false
terrateam:
  config:
    db:
      hostname: my-instance.postgres.database.azure.com
      username: terrateam
      databaseName: terrateam
      passwordSecretName: terrateam-db-password
```

## Uninstalling

From chart 2.0.0 the bundled database's PersistentVolumeClaim is retained on uninstall, so
`helm uninstall` no longer destroys your data. Remove it deliberately when you want it gone:

```shell
helm uninstall terrateam -n <namespace>
kubectl delete pvc terrateam-db-data-claim -n <namespace>
```

Set `db.pvc.retain=false` for throwaway installs you want cleaned up entirely.
