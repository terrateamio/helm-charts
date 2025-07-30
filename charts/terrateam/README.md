# terrateam

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

Terrateam - Automate your Terraform and OpenTofu workflows with GitOps. Learn more at https://terrateam.io

**Homepage:** <https://terrateam.io>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Terrateam | <hello@terrateam.io> | <https://terrateam.io> |

## Source Code

* <https://github.com/terrateamio/helm-charts>

## Deployment instructions
See the [Terrateam docs](https://docs.terrateam.io/self-hosted/overview) for deployment instructions.

## Values

<h3>Terrateam Required Values</h3>
<table>
	<thead>
		<th>Key</th>
		<th>Type</th>
		<th>Default</th>
		<th>Description</th>
	</thead>
	<tbody>
		<tr>
			<td>terrateam.config.db.databaseName</td>
			<td>string</td>
			<td><pre lang="json">
"terrateam"
</pre>
</td>
			<td>The PostgreSQL data to log into</td>
		</tr>
		<tr>
			<td>terrateam.config.db.hostname</td>
			<td>string</td>
			<td><pre lang="json">
"terrateam-db"
</pre>
</td>
			<td>If db.enabled = true, set `terrateam.config.db.hostname` to the same value as `db.name`.<br><br> If your PostgreSQL server is deployed in the same Kubernetes cluster, you can reference it's Service<br>   E.g. `postgres.postgres-namespace.svc.cluster.local:5432`<br> Otherwise, for externally-accessible PostgreSQL servers use the FQDN<br>   E.g. `my-hostname.postgres.database.azure.com`</td>
		</tr>
		<tr>
			<td>terrateam.config.db.username</td>
			<td>string</td>
			<td><pre lang="json">
"terrateam"
</pre>
</td>
			<td>The PostgreSQL username to log in with</td>
		</tr>
		<tr>
			<td>terrateam.config.fqdn</td>
			<td>string</td>
			<td><pre lang="json">
"terrateam.example.com"
</pre>
</td>
			<td>The FQDN of your Terrateam API reachable from your GitHub Actions</td>
		</tr>
	</tbody>
</table>

<h3>Other Values</h3>
<table>
	<thead>
		<th>Key</th>
		<th>Type</th>
		<th>Default</th>
		<th>Description</th>
	</thead>
	<tbody>
	<tr>
		<td>applicationName</td>
		<td>string</td>
		<td><pre lang="">
.Chart.name
</pre>
</td>
		<td>Optionally override the Helm chart name. We prefix deployed resources with "{{ template "application.name" }}-"</td>
	</tr>
	<tr>
		<td>db.affinity</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>`db.affinity` merges with `global.affinity`<br><br> Overrides `global.affinity` if conflicting</td>
	</tr>
	<tr>
		<td>db.annotations</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>`db.annotations` merges with `global.annotations`<br><br> Overrides `global.annotations` if conflicting</td>
	</tr>
	<tr>
		<td>db.config.databaseName</td>
		<td>string</td>
		<td><pre lang="json">
"terrateam"
</pre>
</td>
		<td>The name of the database to create inside the PostgreSQL server. Remember to update `terrateam.db.databaseName` with this value</td>
	</tr>
	<tr>
		<td>db.config.extraEnv</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>Optionally pass [extra environment variables](https://www.postgresql.org/docs/14/libpq-envars.html) into the PostgreSQL server container</td>
	</tr>
	<tr>
		<td>db.config.passwordSecretKey</td>
		<td>string</td>
		<td><pre lang="json">
"password"
</pre>
</td>
		<td>The Kubernetes Secret's key containing the PostgreSQL password</td>
	</tr>
	<tr>
		<td>db.config.passwordSecretName</td>
		<td>string</td>
		<td><pre lang="json">
"terrateam-db-password"
</pre>
</td>
		<td>The password of the admin user to create is derived from a Kubernetes secret.<br><br> You can manually create the secret with `kubectl`, or Terraform it with `resource.kubernetes_secret_v1`, or use external-secrets to pull the value from a Vault</td>
	</tr>
	<tr>
		<td>db.config.port</td>
		<td>int</td>
		<td><pre lang="json">
5432
</pre>
</td>
		<td>PostgreSQL uses port `5432` by default</td>
	</tr>
	<tr>
		<td>db.config.username</td>
		<td>string</td>
		<td><pre lang="json">
"terrateam"
</pre>
</td>
		<td>The name of the admin user to create. Remember to update `terrateam.db.username` with this value</td>
	</tr>
	<tr>
		<td>db.enabled</td>
		<td>bool</td>
		<td><pre lang="json">
true
</pre>
</td>
		<td>Optionally deploy a self-contained PostgreSQL server. Set to `false` to use an external PostgreSQL server</td>
	</tr>
	<tr>
		<td>db.image.pullPolicy</td>
		<td>string</td>
		<td><pre lang="json">
"IfNotPresent"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>db.image.repository</td>
		<td>string</td>
		<td><pre lang="json">
"postgres"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>db.image.tag</td>
		<td>string</td>
		<td><pre lang="json">
"14.18-alpine"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>db.imagePullSecrets</td>
		<td>list</td>
		<td><pre lang="json">
[]
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>db.labels</td>
		<td>object</td>
		<td><pre lang="json">
null
</pre>
</td>
		<td>`db.labels` merges with `global.labels`<br><br> Overrides `global.labels` if conflicting</td>
	</tr>
	<tr>
		<td>db.livenessProbe</td>
		<td>object</td>
		<td><pre lang="">
See below
</pre>
</td>
		<td>Liveness probe.</td>
	</tr>
	<tr>
		<td>db.livenessProbe.enabled</td>
		<td>bool</td>
		<td><pre lang="json">
true
</pre>
</td>
		<td>Enable Liveness probe</td>
	</tr>
	<tr>
		<td>db.livenessProbe.failureThreshold</td>
		<td>int</td>
		<td><pre lang="json">
30
</pre>
</td>
		<td>Number of retries before marking the pod as failed</td>
	</tr>
	<tr>
		<td>db.livenessProbe.initialDelaySeconds</td>
		<td>int</td>
		<td><pre lang="json">
10
</pre>
</td>
		<td>Time before the probe activates</td>
	</tr>
	<tr>
		<td>db.livenessProbe.periodSeconds</td>
		<td>int</td>
		<td><pre lang="json">
10
</pre>
</td>
		<td>Time between retries</td>
	</tr>
	<tr>
		<td>db.livenessProbe.successThreshold</td>
		<td>int</td>
		<td><pre lang="json">
1
</pre>
</td>
		<td>Number of successful probes before marking the pod as ready</td>
	</tr>
	<tr>
		<td>db.livenessProbe.timeoutSeconds</td>
		<td>int</td>
		<td><pre lang="json">
1
</pre>
</td>
		<td>Time before the probe times out</td>
	</tr>
	<tr>
		<td>db.name</td>
		<td>string</td>
		<td><pre lang="json">
"db"
</pre>
</td>
		<td>The name of the PostgreSQL server pod</td>
	</tr>
	<tr>
		<td>db.nodeSelector</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>`db.nodeSelector` merges with `global.nodeSelector`<br><br> Overrides `global.nodeSelector` if conflicting</td>
	</tr>
	<tr>
		<td>db.pvc.annotations</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>`db.pvc.annotations` merges with `global.annotations` & `global.db.annotations`<br><br> Overrides `global.annotations` & `global.db.annotations` if conflicting</td>
	</tr>
	<tr>
		<td>db.pvc.labels</td>
		<td>object</td>
		<td><pre lang="json">
null
</pre>
</td>
		<td>`db.pvc.labels` merges with `global.labels` & `db.labels`<br><br> Overrides `global.labels` & `db.labels` if conflicting</td>
	</tr>
	<tr>
		<td>db.pvc.name</td>
		<td>string</td>
		<td><pre lang="json">
"db-data-claim"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>db.pvc.storageClassName</td>
		<td>string</td>
		<td><pre lang="json">
""
</pre>
</td>
		<td>The name of the StorageClass that provides the PersistentVolume. Most Kubernetes clusters use a `"default"` StorageClass when undefined</td>
	</tr>
	<tr>
		<td>db.pvc.storageSize</td>
		<td>string</td>
		<td><pre lang="json">
"1Gi"
</pre>
</td>
		<td>The size of the PV requested by the PVC to ensure data persistence</td>
	</tr>
	<tr>
		<td>db.readinessProbe</td>
		<td>object</td>
		<td><pre lang="">
See below
</pre>
</td>
		<td>Readiness probe.</td>
	</tr>
	<tr>
		<td>db.readinessProbe.enabled</td>
		<td>bool</td>
		<td><pre lang="json">
true
</pre>
</td>
		<td>Enable Readiness probe</td>
	</tr>
	<tr>
		<td>db.readinessProbe.failureThreshold</td>
		<td>int</td>
		<td><pre lang="json">
30
</pre>
</td>
		<td>Number of retries before marking the pod as failed</td>
	</tr>
	<tr>
		<td>db.readinessProbe.initialDelaySeconds</td>
		<td>int</td>
		<td><pre lang="json">
10
</pre>
</td>
		<td>Time before the probe activates</td>
	</tr>
	<tr>
		<td>db.readinessProbe.periodSeconds</td>
		<td>int</td>
		<td><pre lang="json">
10
</pre>
</td>
		<td>Time between retries</td>
	</tr>
	<tr>
		<td>db.readinessProbe.successThreshold</td>
		<td>int</td>
		<td><pre lang="json">
1
</pre>
</td>
		<td>Number of successful probes before marking the pod as ready</td>
	</tr>
	<tr>
		<td>db.readinessProbe.timeoutSeconds</td>
		<td>int</td>
		<td><pre lang="json">
1
</pre>
</td>
		<td>Time before the probe times out</td>
	</tr>
	<tr>
		<td>db.resources.limits.cpu</td>
		<td>string</td>
		<td><pre lang="json">
"500m"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>db.resources.limits.memory</td>
		<td>string</td>
		<td><pre lang="json">
"512Mi"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>db.resources.requests.cpu</td>
		<td>string</td>
		<td><pre lang="json">
"250m"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>db.resources.requests.memory</td>
		<td>string</td>
		<td><pre lang="json">
"512Mi"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>db.revisionHistoryLimit</td>
		<td>int</td>
		<td><pre lang="json">
2
</pre>
</td>
		<td>Maximum number of historical ReplicaSets to keep. This can be useful for troubleshooting previous failed deployments</td>
	</tr>
	<tr>
		<td>db.securityContext</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>`db.securityContext` merges with `global.securityContext`<br><br> Overrides `global.securityContext` if conflicting</td>
	</tr>
	<tr>
		<td>db.service.annotations</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>`db.service.annotations` merges with `global.annotations` & `global.db.annotations`<br><br> Overrides `global.annotations` & `global.db.annotations` if conflicting</td>
	</tr>
	<tr>
		<td>db.service.labels</td>
		<td>object</td>
		<td><pre lang="json">
null
</pre>
</td>
		<td>`db.service.labels` merges with `global.labels` & `global.db.labels`<br><br> Overrides `global.labels` & `global.db.labels` if conflicting</td>
	</tr>
	<tr>
		<td>db.service.name</td>
		<td>string</td>
		<td><pre lang="json">
""
</pre>
</td>
		<td>The name of the Service created for the PostgreSQL server. Defaults to `db.name` if undefined</td>
	</tr>
	<tr>
		<td>db.service.nodePort</td>
		<td>int</td>
		<td><pre lang="json">
null
</pre>
</td>
		<td>`NodePort` should only be defined if `db.service.type` = `"NodePort"`<br> If undefined, Kubernetes will pick a random port in the `30000`-`32767` range</td>
	</tr>
	<tr>
		<td>db.service.port</td>
		<td>int</td>
		<td><pre lang="json">
null
</pre>
</td>
		<td>The port the service will expose Defaults to `db.config.port` if undefined</td>
	</tr>
	<tr>
		<td>db.service.type</td>
		<td>string</td>
		<td><pre lang="json">
"ClusterIP"
</pre>
</td>
		<td>ClusterIP doesn't expose a port, NodeIP exposes an external port on all nodes to the world</td>
	</tr>
	<tr>
		<td>db.tolerations</td>
		<td>list</td>
		<td><pre lang="json">
[]
</pre>
</td>
		<td>`db.tolerations` merges with `global.tolerations`<br><br> Overrides `global.tolerations` if conflicting</td>
	</tr>
	<tr>
		<td>global.affinity</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>Affinity rules for all pods</td>
	</tr>
	<tr>
		<td>global.annotations</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>Global annotations applied to all resources</td>
	</tr>
	<tr>
		<td>global.imagePullSecrets</td>
		<td>list</td>
		<td><pre lang="json">
[]
</pre>
</td>
		<td>Image pull secrets for all pods</td>
	</tr>
	<tr>
		<td>global.labels</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>Global labels applied to all resources</td>
	</tr>
	<tr>
		<td>global.nodeSelector</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>Node selector for all pods</td>
	</tr>
	<tr>
		<td>global.securityContext</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>Security context for all pods</td>
	</tr>
	<tr>
		<td>global.tolerations</td>
		<td>list</td>
		<td><pre lang="json">
[]
</pre>
</td>
		<td>Tolerations for all pods</td>
	</tr>
	<tr>
		<td>ingress.annotations</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>`ingress.annotations` merges with `global.annotations`<br><br> Overrides `global.annotations` if conflicting</td>
	</tr>
	<tr>
		<td>ingress.certificate.annotations</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>`ingress.certificate.annotations` merges with `global.annotations` & `ingress.annotations`<br><br> Overrides `global.annotations` & `ingress.annotations` if conflicting</td>
	</tr>
	<tr>
		<td>ingress.certificate.apiVersion</td>
		<td>string</td>
		<td><pre lang="json">
""
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>ingress.certificate.enabled</td>
		<td>bool</td>
		<td><pre lang="json">
false
</pre>
</td>
		<td>Optionally generate a TLS certificate for your ingress</td>
	</tr>
	<tr>
		<td>ingress.certificate.kind</td>
		<td>string</td>
		<td><pre lang="json">
""
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>ingress.certificate.labels</td>
		<td>object</td>
		<td><pre lang="json">
null
</pre>
</td>
		<td>`ingress.certificate.labels` merges with `global.labels` & `ingress.labels`<br><br> Overrides `global.labels` & `ingress.labels` if conflicting</td>
	</tr>
	<tr>
		<td>ingress.certificate.name</td>
		<td>string</td>
		<td><pre lang="json">
""
</pre>
</td>
		<td>Defaults to `{ingress.name}-certificate` if undefined</td>
	</tr>
	<tr>
		<td>ingress.certificate.spec</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>The complete spec section for the certificate, allows full flexibility for any certificate provider</td>
	</tr>
	<tr>
		<td>ingress.className</td>
		<td>string</td>
		<td><pre lang="json">
"nginx"
</pre>
</td>
		<td>The IngressClass to use when creating the Ingress</td>
	</tr>
	<tr>
		<td>ingress.enabled</td>
		<td>bool</td>
		<td><pre lang="json">
false
</pre>
</td>
		<td>Optionally create an Nginx ingress</td>
	</tr>
	<tr>
		<td>ingress.labels</td>
		<td>object</td>
		<td><pre lang="json">
null
</pre>
</td>
		<td>`ingress.labels` merges with `global.labels`<br><br> Overrides `global.labels` if conflicting</td>
	</tr>
	<tr>
		<td>ingress.name</td>
		<td>string</td>
		<td><pre lang="json">
"ingress"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>ingress.tlsSecretName</td>
		<td>string</td>
		<td><pre lang="json">
"terrateam-tls"
</pre>
</td>
		<td>The name of the Kubernetes Secret containing the private TLS certificate protecting the Ingress</td>
	</tr>
	<tr>
		<td>namespaceOverride</td>
		<td>string</td>
		<td><pre lang="json">
null
</pre>
</td>
		<td>Optionally override the destination namespace</td>
	</tr>
	<tr>
		<td>terrateam.affinity</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>`terrateam.affinity` merges with `global.affinity`<br><br> Overrides `global.affinity` if conflicting</td>
	</tr>
	<tr>
		<td>terrateam.annotations</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>`terrateam.annotations` merges with `global.annotations`<br><br> Overrides `global.annotations` if conflicting</td>
	</tr>
	<tr>
		<td>terrateam.autoscaler.behavior</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>The operations to apply after calculating scaling metrics</td>
	</tr>
	<tr>
		<td>terrateam.autoscaler.enabled</td>
		<td>bool</td>
		<td><pre lang="json">
false
</pre>
</td>
		<td>Optionally deploy a HorizontalPodAutoscaler. Supersedes `.Values.terrateam.replicaCount`</td>
	</tr>
	<tr>
		<td>terrateam.autoscaler.maxReplicas</td>
		<td>int</td>
		<td><pre lang="json">
1
</pre>
</td>
		<td>The maximum number of replicas to deploy.<br><br> During initial install, we recommend deploying a single pod for DB migrations to succeed. You can increase the replicas after the initial DB migration successfully completes.<br><br> Note: setting maxReplicas = minReplicas can trigger Alertmanager HPA maxed alerts</td>
	</tr>
	<tr>
		<td>terrateam.autoscaler.metrics</td>
		<td>list</td>
		<td><pre lang="json">
[
  {
    "resource": {
      "name": "cpu",
      "target": {
        "averageUtilization": 60,
        "type": "Utilization"
      }
    },
    "type": "Resource"
  },
  {
    "resource": {
      "name": "memory",
      "target": {
        "averageUtilization": 60,
        "type": "Utilization"
      }
    },
    "type": "Resource"
  }
]
</pre>
</td>
		<td>The metrics to use to calculate scaling operations</td>
	</tr>
	<tr>
		<td>terrateam.autoscaler.minReplicas</td>
		<td>int</td>
		<td><pre lang="json">
1
</pre>
</td>
		<td>The minimum number of replicas to deploy.<br><br> During initial install, we recommend deploying a single pod for DB migrations to succeed. You can increase the replicas after the initial DB migration successfully completes.</td>
	</tr>
	<tr>
		<td>terrateam.autoscaler.name</td>
		<td>string</td>
		<td><pre lang="json">
"hpa"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>terrateam.config.apiEndpoint</td>
		<td>string</td>
		<td><pre lang="json">
null
</pre>
</td>
		<td>If the Terrateam API is configured to listen on a custom endpoint, perhaps with URL rewrites or over HTTP instead of HTTPS, you can override the API's URL</td>
	</tr>
	<tr>
		<td>terrateam.config.db.passwordSecretKey</td>
		<td>string</td>
		<td><pre lang="json">
"password"
</pre>
</td>
		<td>The Kubernetes Secret's key containing the PostgreSQL password</td>
	</tr>
	<tr>
		<td>terrateam.config.db.passwordSecretName</td>
		<td>string</td>
		<td><pre lang="json">
"terrateam-db-password"
</pre>
</td>
		<td>The PostgreSQL password must be stored in a Kubernetes secret.<br><br> You can manually create the secret with `kubectl`, or Terraform it with `resource.kubernetes_secret_v1`, or use external-secrets to pull the value from a Vault</td>
	</tr>
	<tr>
		<td>terrateam.config.db.port</td>
		<td>int</td>
		<td><pre lang="json">
5432
</pre>
</td>
		<td>PostgreSQL uses port `5432` by default</td>
	</tr>
	<tr>
		<td>terrateam.config.extraEnv</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>Optionally pass extra environment variables into the Terrateam container https://docs.terrateam.io/self-hosted/instructions#environment-variables-1</td>
	</tr>
	<tr>
		<td>terrateam.config.github.appClientIdSecretKey</td>
		<td>string</td>
		<td><pre lang="json">
"id"
</pre>
</td>
		<td>The name of the key in the Kubernetes secret containing the GitHub app's client id</td>
	</tr>
	<tr>
		<td>terrateam.config.github.appClientIdSecretName</td>
		<td>string</td>
		<td><pre lang="json">
"terrateam-github-app-client-id"
</pre>
</td>
		<td>The name of the Kubernetes secret containing the GitHub app's client id</td>
	</tr>
	<tr>
		<td>terrateam.config.github.appClientSecretSecretKey</td>
		<td>string</td>
		<td><pre lang="json">
"secret"
</pre>
</td>
		<td>The name of the key in the Kubernetes secret containing the GitHub app's client secret</td>
	</tr>
	<tr>
		<td>terrateam.config.github.appClientSecretSecretName</td>
		<td>string</td>
		<td><pre lang="json">
"terrateam-github-app-client-secret"
</pre>
</td>
		<td>The name of the Kubernetes secret containing the GitHub app's client secret</td>
	</tr>
	<tr>
		<td>terrateam.config.github.appIdSecretKey</td>
		<td>string</td>
		<td><pre lang="json">
"id"
</pre>
</td>
		<td>The name of the key in the Kubernetes secret containing the GitHub app's id</td>
	</tr>
	<tr>
		<td>terrateam.config.github.appIdSecretName</td>
		<td>string</td>
		<td><pre lang="json">
"terrateam-github-app-id"
</pre>
</td>
		<td>The name of the Kubernetes secret containing the GitHub app's id</td>
	</tr>
	<tr>
		<td>terrateam.config.github.appPrivatePemCertificateSecretKey</td>
		<td>string</td>
		<td><pre lang="json">
"pem"
</pre>
</td>
		<td>The name of the key in the Kubernetes secret containing the GitHub app's private PEM certificate</td>
	</tr>
	<tr>
		<td>terrateam.config.github.appPrivatePemCertificateSecretName</td>
		<td>string</td>
		<td><pre lang="json">
"terrateam-github-app-pem"
</pre>
</td>
		<td>The name of the Kubernetes secret containing the GitHub app's private PEM certificate</td>
	</tr>
	<tr>
		<td>terrateam.config.github.enabled</td>
		<td>bool</td>
		<td><pre lang="json">
true
</pre>
</td>
		<td>GitHub is the default provider. Set this to `false` to use GitLab instead</td>
	</tr>
	<tr>
		<td>terrateam.config.github.webhookSecretKey</td>
		<td>string</td>
		<td><pre lang="json">
"secret"
</pre>
</td>
		<td>The name of the key  in the Kubernetes secret containing the GitHub app's webhook secret</td>
	</tr>
	<tr>
		<td>terrateam.config.github.webhookSecretName</td>
		<td>string</td>
		<td><pre lang="json">
"terrateam-github-webhook-secret"
</pre>
</td>
		<td>The name of the Kubernetes secret containing the GitHub app's webhook secret</td>
	</tr>
	<tr>
		<td>terrateam.config.gitlab.accessTokenSecretKey</td>
		<td>string</td>
		<td><pre lang="json">
"token"
</pre>
</td>
		<td>The name of the key in the Kubernetes secret containing the GitLab app's private access token</td>
	</tr>
	<tr>
		<td>terrateam.config.gitlab.accessTokenSecretName</td>
		<td>string</td>
		<td><pre lang="json">
"terrateam-gitlab-access-token"
</pre>
</td>
		<td>The name of the Kubernetes secret containing the GitLab private access token</td>
	</tr>
	<tr>
		<td>terrateam.config.gitlab.appIdSecretKey</td>
		<td>string</td>
		<td><pre lang="json">
"id"
</pre>
</td>
		<td>The name of the key in the Kubernetes secret containing the GitLab app's id</td>
	</tr>
	<tr>
		<td>terrateam.config.gitlab.appIdSecretName</td>
		<td>string</td>
		<td><pre lang="json">
"terrateam-gitlab-app-id"
</pre>
</td>
		<td>The name of the Kubernetes secret containing the GitLab app's id</td>
	</tr>
	<tr>
		<td>terrateam.config.gitlab.appSecretSecretKey</td>
		<td>string</td>
		<td><pre lang="json">
"secret"
</pre>
</td>
		<td>The name of the key in the Kubernetes secret containing the GitLab app's secret</td>
	</tr>
	<tr>
		<td>terrateam.config.gitlab.appSecretSecretName</td>
		<td>string</td>
		<td><pre lang="json">
"terrateam-gitlab-app-secret"
</pre>
</td>
		<td>The name of the Kubernetes secret containing the GitLab app's secret</td>
	</tr>
	<tr>
		<td>terrateam.config.gitlab.enabled</td>
		<td>bool</td>
		<td><pre lang="json">
false
</pre>
</td>
		<td>Optionally use GitLab. Must also set `terrateam.config.github.enabled` to `false` to use GitLab</td>
	</tr>
	<tr>
		<td>terrateam.config.infracost.pricingApiEndpoint</td>
		<td>string</td>
		<td><pre lang="json">
""
</pre>
</td>
		<td>If self-hosting Infracost, this is the endpoint used to query your self-hosted Infracost API.<br> E.g. `http://infracost-cloud-pricing-api.infracost.svc.cluster.local:80`</td>
	</tr>
	<tr>
		<td>terrateam.config.infracost.selfHostedApiKey</td>
		<td>string</td>
		<td><pre lang="json">
""
</pre>
</td>
		<td>This is the 32-character API key you created for clients like Terrateam to consume</td>
	</tr>
	<tr>
		<td>terrateam.config.telemetryLevel</td>
		<td>string</td>
		<td><pre lang="json">
"anonymous"
</pre>
</td>
		<td>Set the level of telemetry data reported back to Terrateam</td>
	</tr>
	<tr>
		<td>terrateam.image.pullPolicy</td>
		<td>string</td>
		<td><pre lang="json">
"Always"
</pre>
</td>
		<td>Set this to `Always` if `terrateam.image.tag` = `latest` to bust the Kubernetes image cache</td>
	</tr>
	<tr>
		<td>terrateam.image.repository</td>
		<td>string</td>
		<td><pre lang="json">
"ghcr.io/terrateamio/terrat-oss"
</pre>
</td>
		<td>Repository containing the Terrateam image to deploy</td>
	</tr>
	<tr>
		<td>terrateam.image.tag</td>
		<td>string</td>
		<td><pre lang="json">
"latest"
</pre>
</td>
		<td>For production use it is recommended that you pin a [specific tag](https://github.com/terrateamio/terrateam/pkgs/container/terrat-oss/versions)</td>
	</tr>
	<tr>
		<td>terrateam.imagePullSecrets</td>
		<td>list</td>
		<td><pre lang="json">
[]
</pre>
</td>
		<td>`terrateam.imagePullSecrets` merges with `global.imagePullSecrets`<br><br> Overrides `global.imagePullSecrets` if conflicting</td>
	</tr>
	<tr>
		<td>terrateam.labels</td>
		<td>object</td>
		<td><pre lang="json">
null
</pre>
</td>
		<td>`terrateam.labels` merges with `global.labels`<br><br> Overrides `global.labels` if conflicting</td>
	</tr>
	<tr>
		<td>terrateam.livenessProbe</td>
		<td>object</td>
		<td><pre lang="">
See below
</pre>
</td>
		<td>Liveness probe.</td>
	</tr>
	<tr>
		<td>terrateam.livenessProbe.enabled</td>
		<td>bool</td>
		<td><pre lang="json">
true
</pre>
</td>
		<td>Enable Liveness probe</td>
	</tr>
	<tr>
		<td>terrateam.livenessProbe.failureThreshold</td>
		<td>int</td>
		<td><pre lang="json">
30
</pre>
</td>
		<td>Number of retries before marking the pod as failed</td>
	</tr>
	<tr>
		<td>terrateam.livenessProbe.initialDelaySeconds</td>
		<td>int</td>
		<td><pre lang="json">
10
</pre>
</td>
		<td>Time before the probe activates</td>
	</tr>
	<tr>
		<td>terrateam.livenessProbe.periodSeconds</td>
		<td>int</td>
		<td><pre lang="json">
10
</pre>
</td>
		<td>Time between retries</td>
	</tr>
	<tr>
		<td>terrateam.livenessProbe.successThreshold</td>
		<td>int</td>
		<td><pre lang="json">
1
</pre>
</td>
		<td>Number of successful probes before marking the pod as ready</td>
	</tr>
	<tr>
		<td>terrateam.livenessProbe.timeoutSeconds</td>
		<td>int</td>
		<td><pre lang="json">
1
</pre>
</td>
		<td>Time before the probe times out</td>
	</tr>
	<tr>
		<td>terrateam.name</td>
		<td>string</td>
		<td><pre lang="json">
"server"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>terrateam.nodeSelector</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>`terrateam.nodeSelector` merges with `global.nodeSelector`<br><br> Overrides `global.nodeSelector` if conflicting</td>
	</tr>
	<tr>
		<td>terrateam.readinessProbe</td>
		<td>object</td>
		<td><pre lang="">
See below
</pre>
</td>
		<td>Readiness probe.</td>
	</tr>
	<tr>
		<td>terrateam.readinessProbe.enabled</td>
		<td>bool</td>
		<td><pre lang="json">
true
</pre>
</td>
		<td>Enable Readiness probe</td>
	</tr>
	<tr>
		<td>terrateam.readinessProbe.failureThreshold</td>
		<td>int</td>
		<td><pre lang="json">
30
</pre>
</td>
		<td>Number of retries before marking the pod as failed</td>
	</tr>
	<tr>
		<td>terrateam.readinessProbe.initialDelaySeconds</td>
		<td>int</td>
		<td><pre lang="json">
10
</pre>
</td>
		<td>Time before the probe activates</td>
	</tr>
	<tr>
		<td>terrateam.readinessProbe.periodSeconds</td>
		<td>int</td>
		<td><pre lang="json">
10
</pre>
</td>
		<td>Time between retries</td>
	</tr>
	<tr>
		<td>terrateam.readinessProbe.successThreshold</td>
		<td>int</td>
		<td><pre lang="json">
1
</pre>
</td>
		<td>Number of successful probes before marking the pod as ready</td>
	</tr>
	<tr>
		<td>terrateam.readinessProbe.timeoutSeconds</td>
		<td>int</td>
		<td><pre lang="json">
1
</pre>
</td>
		<td>Time before the probe times out</td>
	</tr>
	<tr>
		<td>terrateam.replicaCount</td>
		<td>int</td>
		<td><pre lang="json">
1
</pre>
</td>
		<td>Number of Terrateam pods to deploy.<br><br> Terrateam horizontally scales, you are effectively [limited by your DB's available resources](https://docs.terrateam.io/self-hosted/best-practices/#scaling-considerations)<br><br> This field is ignored if `.Values.terrateam.autoscaling` = `true`</td>
	</tr>
	<tr>
		<td>terrateam.resources.limits.cpu</td>
		<td>string</td>
		<td><pre lang="json">
"500m"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>terrateam.resources.limits.memory</td>
		<td>string</td>
		<td><pre lang="json">
"512Mi"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>terrateam.resources.requests.cpu</td>
		<td>string</td>
		<td><pre lang="json">
"250m"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>terrateam.resources.requests.memory</td>
		<td>string</td>
		<td><pre lang="json">
"512Mi"
</pre>
</td>
		<td></td>
	</tr>
	<tr>
		<td>terrateam.revisionHistoryLimit</td>
		<td>int</td>
		<td><pre lang="json">
2
</pre>
</td>
		<td>Maximum number of historical ReplicaSets to keep. This can be useful for troubleshooting previous failed deployments</td>
	</tr>
	<tr>
		<td>terrateam.securityContext</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>`terrateam.securityContext` merges with `global.securityContext`<br><br> Overrides `global.securityContext` if conflicting</td>
	</tr>
	<tr>
		<td>terrateam.service.annotations</td>
		<td>object</td>
		<td><pre lang="json">
{}
</pre>
</td>
		<td>`terrateam.service.annotations` merges with `global.annotations` & `global.terrateam.annotations`<br><br> Overrides `global.annotations` & `global.terrateam.annotations` if conflicting</td>
	</tr>
	<tr>
		<td>terrateam.service.enabled</td>
		<td>bool</td>
		<td><pre lang="json">
true
</pre>
</td>
		<td>A Service for Terrateam is deployed by default</td>
	</tr>
	<tr>
		<td>terrateam.service.labels</td>
		<td>object</td>
		<td><pre lang="json">
null
</pre>
</td>
		<td>`terrateam.service.labels` merges with `global.labels` & `global.terrateam.labels`<br><br> Overrides `global.labels` & `global.terrateam.labels` if conflicting</td>
	</tr>
	<tr>
		<td>terrateam.service.name</td>
		<td>string</td>
		<td><pre lang="json">
""
</pre>
</td>
		<td>The name of the Service created for Terrateam. Defaults to `terrateam.name` if undefined</td>
	</tr>
	<tr>
		<td>terrateam.service.nodePort</td>
		<td>string</td>
		<td><pre lang="json">
""
</pre>
</td>
		<td>NodePort should only be defined if `terrateam.service.type` = `"NodePort"`.<br> If undefined, Kubernetes will pick a random port in the `30000`-`32767` range</td>
	</tr>
	<tr>
		<td>terrateam.service.port</td>
		<td>int</td>
		<td><pre lang="json">
8080
</pre>
</td>
		<td>The port the service will expose</td>
	</tr>
	<tr>
		<td>terrateam.service.type</td>
		<td>string</td>
		<td><pre lang="json">
"ClusterIP"
</pre>
</td>
		<td>ClusterIP doesn't expose a port, NodeIP exposes an external port on all nodes to the world</td>
	</tr>
	<tr>
		<td>terrateam.tolerations</td>
		<td>list</td>
		<td><pre lang="json">
[]
</pre>
</td>
		<td>`terrateam.tolerations` merges with `global.tolerations`<br><br> Overrides `global.tolerations` if conflicting</td>
	</tr>
	</tbody>
</table>

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
