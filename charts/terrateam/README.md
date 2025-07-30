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

## Values

### Terrateam Required Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| terrateam.config.db.databaseName | string | `"terrateam"` | The PostgreSQL data to log into |
| terrateam.config.db.hostname | string | `"terrateam-db"` | If db.enabled = true, set `terrateam.config.db.hostname` to the same value as `db.name`.<br><br> If your PostgreSQL server is deployed in the same Kubernetes cluster, you can reference it's Service<br>   E.g. `postgres.postgres-namespace.svc.cluster.local:5432`<br> Otherwise, for externally-accessible PostgreSQL servers use the FQDN<br>   E.g. `my-hostname.postgres.database.azure.com` |
| terrateam.config.db.username | string | `"terrateam"` | The PostgreSQL username to log in with |
| terrateam.config.fqdn | string | `"terrateam.example.com"` | The FQDN of your Terrateam API reachable from your GitHub Actions |

### Other Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| applicationName | string | .Chart.name | Optionally override the Helm chart name. We prefix deployed resources with "{{ template "application.name" }}-" |
| db.affinity | object | `{}` | `db.affinity` merges with `global.affinity`<br><br> Overrides `global.affinity` if conflicting |
| db.annotations | object | `{}` | `db.annotations` merges with `global.annotations`<br><br> Overrides `global.annotations` if conflicting |
| db.config.databaseName | string | `"terrateam"` | The name of the database to create inside the PostgreSQL server. Remember to update `terrateam.db.databaseName` with this value |
| db.config.extraEnv | object | `{}` | Optionally pass [extra environment variables](https://www.postgresql.org/docs/14/libpq-envars.html) into the PostgreSQL server container |
| db.config.passwordSecretKey | string | `"password"` | The Kubernetes Secret's key containing the PostgreSQL password |
| db.config.passwordSecretName | string | `"terrateam-db-password"` | The password of the admin user to create is derived from a Kubernetes secret.<br><br> You can manually create the secret with `kubectl`, or Terraform it with `resource.kubernetes_secret_v1`, or use external-secrets to pull the value from a Vault |
| db.config.port | int | `5432` | PostgreSQL uses port `5432` by default |
| db.config.username | string | `"terrateam"` | The name of the admin user to create. Remember to update `terrateam.db.username` with this value |
| db.enabled | bool | `true` | Optionally deploy a self-contained PostgreSQL server. Set to `false` to use an external PostgreSQL server |
| db.image.pullPolicy | string | `"IfNotPresent"` |  |
| db.image.repository | string | `"postgres"` |  |
| db.image.tag | string | `"14.18-alpine"` |  |
| db.imagePullSecrets | list | `[]` |  |
| db.labels | object | `{}`<br> Helm chart automatically adds `app: {{ .Values.db.name }}` | `db.labels` merges with `global.labels`<br><br> Overrides `global.labels` if conflicting |
| db.name | string | `"db"` | The name of the PostgreSQL server pod |
| db.nodeSelector | object | `{}` | `db.nodeSelector` merges with `global.nodeSelector`<br><br> Overrides `global.nodeSelector` if conflicting |
| db.pvc.annotations | object | `{}` | `db.pvc.annotations` merges with `global.annotations` & `global.db.annotations`<br><br> Overrides `global.annotations` & `global.db.annotations` if conflicting |
| db.pvc.labels | object | `{}`<br> Helm chart automatically adds `app: {{ .Values.db.name }}` | `db.pvc.labels` merges with `global.labels` & `db.labels`<br><br> Overrides `global.labels` & `db.labels` if conflicting |
| db.pvc.name | string | `"db-data-claim"` |  |
| db.pvc.storageClassName | string | `""` | The name of the StorageClass that provides the PersistentVolume. Most Kubernetes clusters use a `"default"` StorageClass when undefined |
| db.pvc.storageSize | string | `"1Gi"` | The size of the PV requested by the PVC to ensure data persistence |
| db.resources.limits.cpu | string | `"500m"` |  |
| db.resources.limits.memory | string | `"512Mi"` |  |
| db.resources.requests.cpu | string | `"250m"` |  |
| db.resources.requests.memory | string | `"512Mi"` |  |
| db.revisionHistoryLimit | int | `2` | Maximum number of historical ReplicaSets to keep. This can be useful for troubleshooting previous failed deployments |
| db.securityContext | object | `{}` | `db.securityContext` merges with `global.securityContext`<br><br> Overrides `global.securityContext` if conflicting |
| db.service.annotations | object | `{}` | `db.service.annotations` merges with `global.annotations` & `global.db.annotations`<br><br> Overrides `global.annotations` & `global.db.annotations` if conflicting |
| db.service.labels | object | `{}`<br> Helm chart automatically adds `app: {{ .Values.terrateam.name }}` | `db.service.labels` merges with `global.labels` & `global.db.labels`<br><br> Overrides `global.labels` & `global.db.labels` if conflicting |
| db.service.name | string | `""` | The name of the Service created for the PostgreSQL server. Defaults to `db.name` if undefined |
| db.service.nodePort | int | `nil` | `NodePort` should only be defined if `db.service.type` = `"NodePort"`<br> If undefined, Kubernetes will pick a random port in the `30000`-`32767` range |
| db.service.port | int | `nil` | The port the service will expose Defaults to `db.config.port` if undefined |
| db.service.type | string | `"ClusterIP"` | ClusterIP doesn't expose a port, NodeIP exposes an external port on all nodes to the world |
| db.tolerations | list | `[]` | `db.tolerations` merges with `global.tolerations`<br><br> Overrides `global.tolerations` if conflicting |
| global.affinity | object | `{}` | Affinity rules for all pods |
| global.annotations | object | `{}` | Global annotations applied to all resources |
| global.imagePullSecrets | list | `[]` | Image pull secrets for all pods |
| global.labels | object | `{}` | Global labels applied to all resources |
| global.nodeSelector | object | `{}` | Node selector for all pods |
| global.securityContext | object | `{}` | Security context for all pods |
| global.tolerations | list | `[]` | Tolerations for all pods |
| ingress.annotations | object | `{}` | `ingress.annotations` merges with `global.annotations`<br><br> Overrides `global.annotations` if conflicting |
| ingress.certificate.annotations | object | `{}` | `ingress.certificate.annotations` merges with `global.annotations` & `ingress.annotations`<br><br> Overrides `global.annotations` & `ingress.annotations` if conflicting |
| ingress.certificate.apiVersion | string | `""` |  |
| ingress.certificate.enabled | bool | `false` | Optionally generate a TLS certificate for your ingress |
| ingress.certificate.kind | string | `""` |  |
| ingress.certificate.labels | object | `{}`<br> Helm chart automatically adds `app: {{ .Values.terrateam.name }}` | `ingress.certificate.labels` merges with `global.labels` & `ingress.labels`<br><br> Overrides `global.labels` & `ingress.labels` if conflicting |
| ingress.certificate.name | string | `""` | Defaults to `{ingress.name}-certificate` if undefined |
| ingress.certificate.spec | object | `{}` | The complete spec section for the certificate, allows full flexibility for any certificate provider |
| ingress.className | string | `"nginx"` | The IngressClass to use when creating the Ingress |
| ingress.enabled | bool | `false` | Optionally create an Nginx ingress |
| ingress.labels | object | `{}`<br> Helm chart automatically adds `app: {{ .Values.terrateam.name }}` | `ingress.labels` merges with `global.labels`<br><br> Overrides `global.labels` if conflicting |
| ingress.name | string | `"ingress"` |  |
| ingress.tlsSecretName | string | `"terrateam-tls"` | The name of the Kubernetes Secret containing the private TLS certificate protecting the Ingress |
| namespaceOverride | string | `nil` | Optionally override the destination namespace |
| terrateam.affinity | object | `{}` | `terrateam.affinity` merges with `global.affinity`<br><br> Overrides `global.affinity` if conflicting |
| terrateam.annotations | object | `{}` | `terrateam.annotations` merges with `global.annotations`<br><br> Overrides `global.annotations` if conflicting |
| terrateam.config.apiProtocol | string | `"https"` | Which protocol to use to query the Terrateam API. Must be either `"https"` or `"http"` |
| terrateam.config.db.passwordSecretKey | string | `"password"` | The Kubernetes Secret's key containing the PostgreSQL password |
| terrateam.config.db.passwordSecretName | string | `"terrateam-db-password"` | The PostgreSQL password must be stored in a Kubernetes secret.<br><br> You can manually create the secret with `kubectl`, or Terraform it with `resource.kubernetes_secret_v1`, or use external-secrets to pull the value from a Vault |
| terrateam.config.db.port | int | `5432` | PostgreSQL uses port `5432` by default |
| terrateam.config.extraEnv | object | `{}` | Optionally pass extra environment variables into the Terrateam container https://docs.terrateam.io/self-hosted/instructions#environment-variables-1 |
| terrateam.config.github.appClientIdSecretKey | string | `"id"` | The name of the key in the Kubernetes secret containing the GitHub app's client id |
| terrateam.config.github.appClientIdSecretName | string | `"terrateam-github-app-client-id"` | The name of the Kubernetes secret containing the GitHub app's client id |
| terrateam.config.github.appClientSecretSecretKey | string | `"secret"` | The name of the key in the Kubernetes secret containing the GitHub app's client secret |
| terrateam.config.github.appClientSecretSecretName | string | `"terrateam-github-app-client-secret"` | The name of the Kubernetes secret containing the GitHub app's client secret |
| terrateam.config.github.appIdSecretKey | string | `"id"` | The name of the key in the Kubernetes secret containing the GitHub app's id |
| terrateam.config.github.appIdSecretName | string | `"terrateam-github-app-id"` | The name of the Kubernetes secret containing the GitHub app's id |
| terrateam.config.github.appPrivatePemCertificateSecretKey | string | `"pem"` | The name of the key in the Kubernetes secret containing the GitHub app's private PEM certificate |
| terrateam.config.github.appPrivatePemCertificateSecretName | string | `"terrateam-github-app-pem"` | The name of the Kubernetes secret containing the GitHub app's private PEM certificate |
| terrateam.config.github.enabled | bool | `true` | GitHub is the default provider. Set this to `false` to use GitLab instead |
| terrateam.config.github.webhookSecretKey | string | `"secret"` | The name of the key  in the Kubernetes secret containing the GitHub app's webhook secret |
| terrateam.config.github.webhookSecretName | string | `"terrateam-github-webhook-secret"` | The name of the Kubernetes secret containing the GitHub app's webhook secret |
| terrateam.config.gitlab.accessTokenSecretKey | string | `"token"` | The name of the key in the Kubernetes secret containing the GitLab app's private access token |
| terrateam.config.gitlab.accessTokenSecretName | string | `"terrateam-gitlab-access-token"` | The name of the Kubernetes secret containing the GitLab private access token |
| terrateam.config.gitlab.appIdSecretKey | string | `"id"` | The name of the key in the Kubernetes secret containing the GitLab app's id |
| terrateam.config.gitlab.appIdSecretName | string | `"terrateam-gitlab-app-id"` | The name of the Kubernetes secret containing the GitLab app's id |
| terrateam.config.gitlab.appSecretSecretKey | string | `"secret"` | The name of the key in the Kubernetes secret containing the GitLab app's secret |
| terrateam.config.gitlab.appSecretSecretName | string | `"terrateam-gitlab-app-secret"` | The name of the Kubernetes secret containing the GitLab app's secret |
| terrateam.config.gitlab.enabled | bool | `false` | Optionally use GitLab. Must also set `terrateam.config.github.enabled` to `false` to use GitLab |
| terrateam.config.infracost.pricingApiEndpoint | string | `""` | If self-hosting Infracost, this is the endpoint used to query your self-hosted Infracost API.<br> E.g. `http://infracost-cloud-pricing-api.infracost.svc.cluster.local:80` |
| terrateam.config.infracost.selfHostedApiKey | string | `""` | This is the 32-character API key you created for clients like Terrateam to consume |
| terrateam.config.telemetryLevel | string | `"anonymous"` | Set the level of telemetry data reported back to Terrateam |
| terrateam.image.pullPolicy | string | `"Always"` | Set this to `Always` if `terrateam.image.tag` = `latest` to bust the Kubernetes image cache |
| terrateam.image.repository | string | `"ghcr.io/terrateamio/terrat-oss"` | Repository containing the Terrateam image to deploy |
| terrateam.image.tag | string | `"latest"` | For production use it is recommended that you pin a [specific tag](https://github.com/terrateamio/terrateam/pkgs/container/terrat-oss/versions) |
| terrateam.imagePullSecrets | list | `[]` | `terrateam.imagePullSecrets` merges with `global.imagePullSecrets`<br><br> Overrides `global.imagePullSecrets` if conflicting |
| terrateam.labels | object | `{}`<br> Helm chart automatically adds `app: {{ .Values.terrateam.name }}` | `terrateam.labels` merges with `global.labels`<br><br> Overrides `global.labels` if conflicting |
| terrateam.name | string | `"server"` |  |
| terrateam.nodeSelector | object | `{}` | `terrateam.nodeSelector` merges with `global.nodeSelector`<br><br> Overrides `global.nodeSelector` if conflicting |
| terrateam.replicaCount | int | `1` | Number of Terrateam pods to deploy. Terrateam horizontally scales, you are effectively [limited by your DB's available resources](https://docs.terrateam.io/self-hosted/best-practices/#scaling-considerations) |
| terrateam.resources.limits.cpu | string | `"500m"` |  |
| terrateam.resources.limits.memory | string | `"512Mi"` |  |
| terrateam.resources.requests.cpu | string | `"250m"` |  |
| terrateam.resources.requests.memory | string | `"512Mi"` |  |
| terrateam.revisionHistoryLimit | int | `2` | Maximum number of historical ReplicaSets to keep. This can be useful for troubleshooting previous failed deployments |
| terrateam.securityContext | object | `{}` | `terrateam.securityContext` merges with `global.securityContext`<br><br> Overrides `global.securityContext` if conflicting |
| terrateam.service.annotations | object | `{}` | `terrateam.service.annotations` merges with `global.annotations` & `global.terrateam.annotations`<br><br> Overrides `global.annotations` & `global.terrateam.annotations` if conflicting |
| terrateam.service.enabled | bool | `true` | A Service for Terrateam is deployed by default |
| terrateam.service.labels | object | `{}`<br> Helm chart automatically adds `app: {{ .Values.terrateam.name }}` | `terrateam.service.labels` merges with `global.labels` & `global.terrateam.labels`<br><br> Overrides `global.labels` & `global.terrateam.labels` if conflicting |
| terrateam.service.name | string | `""` | The name of the Service created for Terrateam. Defaults to `terrateam.name` if undefined |
| terrateam.service.nodePort | string | `""` | NodePort should only be defined if `terrateam.service.type` = `"NodePort"`.<br> If undefined, Kubernetes will pick a random port in the `30000`-`32767` range |
| terrateam.service.port | int | `8080` | The port the service will expose |
| terrateam.service.type | string | `"ClusterIP"` | ClusterIP doesn't expose a port, NodeIP exposes an external port on all nodes to the world |
| terrateam.tolerations | list | `[]` | `terrateam.tolerations` merges with `global.tolerations`<br><br> Overrides `global.tolerations` if conflicting |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)
