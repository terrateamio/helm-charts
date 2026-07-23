# Migration Guide: Terrateam Helm Chart

- [1.x to 2.0.0](#migrating-from-1x-to-200)
- [0.x to 1.x](#migrating-from-0x-to-1x)

For routine upgrades and PostgreSQL major version upgrades, see [UPGRADING.md](UPGRADING.md).

## Migrating from 1.x to 2.0.0

Most installs upgrade with no values changes. Four things changed behavior.

### 1. Bundled PostgreSQL moved from 14 to 17

**This is the only change that can take Terrateam offline.** PostgreSQL will not start against a
data directory written by an older major version. If you use the bundled database
(`db.enabled=true`) and have not pinned `db.image.tag`, you must either dump and restore, or pin
your current version:

```yaml
db:
  image:
    tag: "14.23-alpine"   # defer the major upgrade
```

The full procedure is in [UPGRADING.md](UPGRADING.md#postgresql-major-version-upgrades). Back up
before you upgrade:

```shell
kubectl exec -n <namespace> deploy/terrateam-db -- \
  pg_dumpall -U terrateam > terrateam-backup.sql
```

Unaffected: anyone using an external database (`db.enabled=false`), or already pinning
`db.image.tag`.

### 2. `terrateam.config.fqdn` is now required

The default was `terrateam.example.com`, which produced an install that could never work. The
chart now refuses to render without a real value:

```yaml
terrateam:
  config:
    fqdn: terrateam.example.org
```

Only installs that were already non-functional are affected.

### 3. The database PersistentVolumeClaim survives `helm uninstall`

The PVC is now annotated `helm.sh/resource-policy: keep`, so uninstalling no longer deletes your
data. The trade-off is that the PVC has to be removed by hand when you do want it gone:

```shell
kubectl delete pvc terrateam-db-data-claim -n <namespace>
```

Set `db.pvc.retain: false` to restore the old delete-on-uninstall behavior.

### 4. Terrateam rolls out with the `Recreate` strategy

The old pod is stopped before the new one starts, so a single version of Terrateam talks to the
database during an upgrade. This adds a short outage while the new pod becomes ready. If you run
multiple replicas and prefer the previous rolling behavior:

```yaml
terrateam:
  strategy:
    type: RollingUpdate
```

### Also new in 2.0.0, no action required

- **Secrets can be supplied inline.** Every credential the chart consumes now has an optional
  plaintext value (`db.config.password`, `terrateam.config.github.appId`, and so on). Set one and
  the chart creates the Secret for you; leave it empty and the chart references a Secret you
  created yourself, exactly as before. Existing values files keep working untouched.
- **`terrateam.config.db.hostname` now defaults to the bundled database's Service** instead of the
  hardcoded string `terrateam-db`, so it stays correct when `applicationName` is overridden. It is
  still required when `db.enabled=false`.
- **A `NOTES.txt`** now prints after install, listing exactly which Secrets are missing and the
  `kubectl create secret` command for each.
- **An init container waits for PostgreSQL** before Terrateam starts, so a fresh install no longer
  appears to hang for five minutes when the database is still initialising. Disable with
  `terrateam.waitForDb.enabled: false`.
- Fixed label and annotation cross-contamination between components, a missing `namespace` on the
  Ingress certificate, and a RoleBinding that pointed at the wrong namespace when
  `namespaceOverride` was set.

## Migrating from 0.x to 1.x

This section will help you migrate from Terrateam Helm Chart version 0.x to 1.x.

## Overview

Version 1.0.0 represents a major refactor of the Helm chart with significant changes to the structure, configuration hierarchy, and default behavior. This migration requires careful planning and potential downtime.

## Breaking Changes

### 1. Ingress Disabled by Default

**0.x behavior:** Ingress was enabled by default
**1.x behavior:** Ingress is disabled by default

**Migration action:**
```yaml
# Add to your values.yaml
ingress:
  enabled: true
```

### 2. Configuration Structure Changes

The configuration hierarchy has been restructured with a new naming convention.

#### Labels and Selectors

**0.x:** Labels were loosely structured
**1.x:** Templated labels with strict selector labels

**Migration action:** Review your label selectors if you have custom monitoring, network policies, or other resources that reference Terrateam pods.

#### Certificate Configuration

**0.x:** `.Values.certificate`
**1.x:** `.Values.ingress.certificate`

**Migration action:**
```yaml
# Change from:
certificate:
  enabled: true
  # ...

# To:
ingress:
  certificate:
    enabled: true
    # ...
```

### 3. Service Port References

The chart now uses proper service port references throughout.

**Migration action:** If you have custom configurations referencing service ports, ensure they use the correct values:
- Terrateam service: `Values.terrateam.service.port`
- Database service: `Values.db.service.port`

### 4. Resource Naming

Resources now include the `application.name` prefix consistently.

**0.x:** Some resources had inconsistent naming
**1.x:** All resources follow the pattern: `{{ template "application.name" }}-<resource-name>`

**Migration action:** Update any external references (e.g., in monitoring dashboards, network policies, or scripts) to use the new resource names.

### 5. Namespace Support

**1.x addition:** You can now override the namespace with `.Values.namespaceOverride`

**Migration action (optional):**
```yaml
namespaceOverride: "my-custom-namespace"
```

## New Features in 1.x

### ServiceAccount and RBAC

Version 1.x includes proper ServiceAccount, Role, and RoleBinding resources.

**Action:** No migration needed - these are created automatically.

### Horizontal Pod Autoscaler (HPA)

The chart now supports HPA for the Terrateam deployment.

**To enable:**
```yaml
terrateam:
  autoscaling:
    enabled: true
    minReplicas: 2
    maxReplicas: 10
    targetCPUUtilizationPercentage: 80
```

### GitLab Support

In addition to GitHub, the chart now supports GitLab.

**To use GitLab:**
```yaml
terrateam:
  config:
    github:
      enabled: false
    gitlab:
      enabled: true
      # ... gitlab config
```

### Enhanced Health Checks

Tuned liveness and readiness probes are now available for both Terrateam and the database.

**To customize:**
```yaml
terrateam:
  livenessProbe:
    httpGet:
      path: /health
      port: 8080
    initialDelaySeconds: 30
    periodSeconds: 10
  readinessProbe:
    httpGet:
      path: /ready
      port: 8080
    initialDelaySeconds: 10
    periodSeconds: 5
```

### Revision History

Control deployment revision history with new configuration options.

**To configure:**
```yaml
terrateam:
  revisionHistoryLimit: 10

db:
  revisionHistoryLimit: 10
```

### New Configuration Options (1.1.0+)

Version 1.1.0 added important configuration options for URL management:

```yaml
terrateam:
  config:
    # Custom API endpoint (if using URL rewrites or non-standard setup)
    apiEndpoint: "https://custom-api.example.com/api"

    # Public-facing web base URL
    webBaseUrl: "https://terrateam.example.com"

    # Public-facing UI base URL (required for UI, must include https://)
    uiBase: "https://terrateam.example.com"
```

## Step-by-Step Migration Process

### Step 1: Backup Current Configuration

```bash
# Export current values
helm get values terrateam -n <namespace> > values-0.x-backup.yaml

# Backup database if using the included PostgreSQL
kubectl exec -n <namespace> <db-pod-name> -- pg_dump -U terrateam terrateam > terrateam-backup.sql
```

### Step 2: Review and Update Values File

1. Copy your existing `values-0.x-backup.yaml`
2. Create a new `values-1.x.yaml` with the updated structure
3. Pay special attention to:
   - Enable ingress if you need it: `ingress.enabled: true`
   - Move certificate config under `ingress:`
   - Verify all custom labels and selectors
   - Add new required fields like `terrateam.config.webBaseUrl` and `terrateam.config.uiBase`

### Step 3: Test in a Staging Environment

Before upgrading production, test the migration in a staging environment:

```bash
# Install with new values
helm upgrade terrateam terrateam/terrateam \
  --version 1.3.0 \
  --namespace terrateam-staging \
  --values values-1.x.yaml \
  --dry-run --debug
```

Review the output carefully to ensure all resources are configured correctly.

### Step 4: Upgrade Production

```bash
# Perform the upgrade
helm upgrade terrateam terrateam/terrateam \
  --version 1.3.0 \
  --namespace <namespace> \
  --values values-1.x.yaml
```

### Step 5: Verify Deployment

```bash
# Check deployment status
kubectl rollout status deployment/terrateam-server -n <namespace>

# Verify pods are running
kubectl get pods -n <namespace>

# Check logs for any errors
kubectl logs -n <namespace> -l app=server --tail=100

# Test application functionality
curl https://<your-terrateam-fqdn>/health
```

## Rollback Plan

If you encounter issues, you can rollback to the previous version:

```bash
# Rollback to previous release
helm rollback terrateam -n <namespace>

# Or rollback to a specific revision
helm rollback terrateam <revision-number> -n <namespace>
```

To find the revision number:
```bash
helm history terrateam -n <namespace>
```

## Common Issues and Solutions

### Issue: Ingress Not Working

**Cause:** Ingress is disabled by default in 1.x

**Solution:**
```yaml
ingress:
  enabled: true
```

### Issue: Pods Can't Find Services

**Cause:** Service names have changed with the new naming convention

**Solution:** Ensure your configuration uses the correct service references. The chart handles this automatically if you use the provided values structure.

### Issue: Database Connection Fails

**Cause:** Database hostname or credentials changed

**Solution:** Verify database configuration:
```yaml
terrateam:
  config:
    db:
      hostname: terrateam-db  # or your external DB hostname
      username: terrateam
      passwordSecretName: terrateam-db-password
      passwordSecretKey: password
```

### Issue: Missing HTTPS Prefix on URLs

**Cause:** `uiBase` and `webBaseUrl` must include the `https://` prefix (introduced in 1.3.0)

**Solution:**
```yaml
terrateam:
  config:
    webBaseUrl: "https://terrateam.example.com"  # Must include https://
    uiBase: "https://terrateam.example.com"      # Must include https://
```

## Post-Migration Checklist

- [ ] All pods are running successfully
- [ ] Ingress is accessible (if enabled)
- [ ] GitHub/GitLab webhooks are functioning
- [ ] Terraform/OpenTofu operations work as expected
- [ ] Database connectivity is confirmed
- [ ] Monitoring and logging are operational
- [ ] HPA is functioning (if enabled)
- [ ] External integrations (if any) are working

## Getting Help

If you encounter issues during migration:

- Join the [Terrateam Slack](https://terrateam.io/slack)
- Open an issue at [GitHub Issues](https://github.com/terrateamio/helm-charts/issues)
- Review the [main Terrateam documentation](https://github.com/terrateamio/terrateam)

## Version-Specific Notes

### Upgrading to 1.2.0+

If you're upgrading to 1.2.0 or later and want to use the cloud-pricing-api:

```yaml
cloudPricingApi:
  enabled: true
  infracostApiKey:
    secretName: infracost-api-key
    secretKey: api-key
```

### Upgrading to 1.3.0+

Version 1.3.0 fixes critical issues with URL configuration:
- `webBaseUrl` now has a proper default value
- `uiBase` correctly includes the `https://` prefix by default
- Both must be prefixed with `https://` for GitHub webhook events to work correctly
