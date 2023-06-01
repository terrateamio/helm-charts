# Terrateam
![Version: 0.1.1](https://img.shields.io/badge/Version-0.1.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0
](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart for running [Terrateam](https://github.com/terrateamio/terrateam).

## Deployment instructions
See the [Terrateam docs](https://terrateam.io/docs/self-hosted/kubernetes) for deployment instructions.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| terrateam | <hello@terrateam.io> |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| certificate.enabled | bool | `false` |  |
| db.db_name | string | `"terrateam"` |  |
| db.enabled | bool | `true` |  |
| db.image.pullPolicy | string | `"IfNotPresent"` |  |
| db.image.repository | string | `"postgres"` |  |
| db.image.tag | string | `"14.5-alpine"` |  |
| db.name | string | `"terrateam-db"` |  |
| db.resources.limits.cpu | string | `"500m"` |  |
| db.resources.limits.memory | string | `"512Mi"` |  |
| db.resources.requests.cpu | string | `"250m"` |  |
| db.resources.requests.memory | string | `"512Mi"` |  |
| db.storage | string | `"1Gi"` |  |
| db.storageClassName | string | `"standard-rwo"` |  |
| db.user | string | `"terrateam"` |  |
| ingress.annotations | object | `{}` |  |
| ingress.enabled | bool | `false` |  |
| ingress.name | string | `"terrateam"` |  |
| server.db_host | string | `"terrateam-db"` |  |
| server.db_name | string | `"terrateam"` |  |
| server.db_port | int | `5432` |  |
| server.db_user | string | `"terrateam"` |  |
| server.dns_name | string | `""` |  |
| server.github_webhook_url_update | string | `"true"` |  |
| server.image.pullPolicy | string | `"Always"` |  |
| server.image.repository | string | `"ghcr.io/terrateamio/terrateam"` |  |
| server.image.tag | string | `"v1"` |  |
| server.infracost_pricing_api_endpoint | string | `""` |  |
| server.name | string | `"terrateam-server"` |  |
| server.replicaCount | int | `1` |  |
| server.resources.limits.cpu | string | `"500m"` |  |
| server.resources.limits.memory | string | `"512Mi"` |  |
| server.resources.requests.cpu | string | `"250m"` |  |
| server.resources.requests.memory | string | `"512Mi"` |  |
| server.self_hosted_infracost_api_key | string | `""` |  |
| server.telemetry_level | string | `"anonymous"` |  |
