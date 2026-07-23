{{/*
Define the name of the chart/application.
*/}}
{{- define "application.name" -}}
{{- default .Chart.Name .Values.applicationName | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Allow the release namespace to be overridden
*/}}
{{- define "application.namespace" -}}
{{- default .Release.Namespace .Values.namespaceOverride -}}
{{- end -}}


{{/*
Define the version of the chart/application.
*/}}
{{- define "application.version" -}}
  {{- $version := default "" .Values.terrateam.image.tag -}}
  {{- regexReplaceAll "[^a-zA-Z0-9_\\.\\-]" $version "-" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "application.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Common labels
*/}}
{{- define "application.labels" -}}
helm.sh/chart: {{ include "application.chart" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/part-of: {{ include "application.name" . }}
{{- with include "application.version" . }}
app.kubernetes.io/version: {{ quote . }}
{{- end }}
{{- end }}

{{- define "terrateam.labels" -}}
{{- include "application.labels" . }}
app.kubernetes.io/name: {{ include "application.name" . }}-{{ .Values.terrateam.name }}
{{- end }}

{{- define "db.labels" -}}
{{- include "application.labels" . }}
app.kubernetes.io/name: {{ include "application.name" . }}-{{ .Values.db.name }}
{{- end }}

{{- define "cloudPricingApi.labels" -}}
{{- include "application.labels" . }}
app.kubernetes.io/name: {{ include "application.name" . }}-{{ .Values.cloudPricingApi.name }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "terrateam.selectorLabels" -}}
app.kubernetes.io/name: {{ include "application.name" . }}-{{ .Values.terrateam.name }}
{{- end }}

{{- define "db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "application.name" . }}-{{ .Values.db.name }}
{{- end }}

{{- define "cloudPricingApi.selectorLabels" -}}
app.kubernetes.io/name: {{ include "application.name" . }}-{{ .Values.cloudPricingApi.name }}
{{- end }}


{{/*
Validate only one of terrateam.config.github or terrateam.config.gitlab is used
*/}}
{{- define "terrateam.validateGitProvider" -}}
{{- if and .Values.terrateam.config.github.enabled .Values.terrateam.config.gitlab.enabled -}}
{{- fail "Only one of terrateam.config.github.enabled or terrateam.config.gitlab.enabled can be true, not both" -}}
{{- end -}}
{{- if not (or .Values.terrateam.config.github.enabled .Values.terrateam.config.gitlab.enabled) -}}
{{- fail "Either terrateam.config.github.enabled or terrateam.config.gitlab.enabled must be true" -}}
{{- end -}}
{{- end -}}


{{/*
The hostname the Terrateam server uses to reach PostgreSQL.
Defaults to the Service created by this chart when the bundled database is enabled.
*/}}
{{- define "terrateam.dbHost" -}}
{{- if .Values.terrateam.config.db.hostname -}}
{{- .Values.terrateam.config.db.hostname -}}
{{- else if .Values.db.enabled -}}
{{- printf "%s-%s" (include "application.name" .) (default .Values.db.name .Values.db.service.name) -}}
{{- else -}}
{{- fail "\n\nterrateam.config.db.hostname must be set when db.enabled=false.\nPoint it at your external PostgreSQL server, e.g.\n\n  --set terrateam.config.db.hostname=my-db.postgres.database.azure.com\n" -}}
{{- end -}}
{{- end -}}


{{/*
Validate the values a deployment cannot work without, so that a misconfigured
install fails immediately with an actionable message instead of at pod runtime.
*/}}
{{- define "terrateam.validateConfig" -}}
{{- include "terrateam.validateGitProvider" . -}}
{{- if not .Values.terrateam.config.fqdn -}}
{{- fail "\n\nterrateam.config.fqdn is required.\nSet it to the fully-qualified domain name your GitHub/GitLab instance uses to reach Terrateam, e.g.\n\n  --set terrateam.config.fqdn=terrateam.example.com\n" -}}
{{- end -}}
{{- if eq .Values.terrateam.config.fqdn "terrateam.example.com" -}}
{{- fail "\n\nterrateam.config.fqdn is still the example value \"terrateam.example.com\".\nSet it to your own fully-qualified domain name, e.g.\n\n  --set terrateam.config.fqdn=terrateam.example.org\n" -}}
{{- end -}}
{{- $_ := include "terrateam.dbHost" . -}}
{{- end -}}


{{/*
Secrets this chart creates on the user's behalf, keyed by Secret name, from any
inline values that are set. Values left empty fall back to a pre-existing Secret.
*/}}
{{- define "terrateam.managedSecrets" -}}
{{- $secrets := dict -}}
{{- $entries := list -}}
{{- $tt := .Values.terrateam.config -}}
{{- if .Values.db.enabled -}}
{{- $entries = append $entries (dict "value" .Values.db.config.password "name" .Values.db.config.passwordSecretName "key" .Values.db.config.passwordSecretKey) -}}
{{- end -}}
{{- $entries = append $entries (dict "value" $tt.db.password "name" $tt.db.passwordSecretName "key" $tt.db.passwordSecretKey) -}}
{{- if $tt.github.enabled -}}
{{- $entries = append $entries (dict "value" $tt.github.appId "name" $tt.github.appIdSecretName "key" $tt.github.appIdSecretKey) -}}
{{- $entries = append $entries (dict "value" $tt.github.appClientId "name" $tt.github.appClientIdSecretName "key" $tt.github.appClientIdSecretKey) -}}
{{- $entries = append $entries (dict "value" $tt.github.appClientSecret "name" $tt.github.appClientSecretSecretName "key" $tt.github.appClientSecretSecretKey) -}}
{{- $entries = append $entries (dict "value" $tt.github.appPrivatePemCertificate "name" $tt.github.appPrivatePemCertificateSecretName "key" $tt.github.appPrivatePemCertificateSecretKey) -}}
{{- $entries = append $entries (dict "value" $tt.github.webhookSecret "name" $tt.github.webhookSecretName "key" $tt.github.webhookSecretKey) -}}
{{- end -}}
{{- if $tt.gitlab.enabled -}}
{{- $entries = append $entries (dict "value" $tt.gitlab.appId "name" $tt.gitlab.appIdSecretName "key" $tt.gitlab.appIdSecretKey) -}}
{{- $entries = append $entries (dict "value" $tt.gitlab.appSecret "name" $tt.gitlab.appSecretSecretName "key" $tt.gitlab.appSecretSecretKey) -}}
{{- $entries = append $entries (dict "value" $tt.gitlab.accessToken "name" $tt.gitlab.accessTokenSecretName "key" $tt.gitlab.accessTokenSecretKey) -}}
{{- end -}}
{{- range $entries -}}
{{- if and .value .name .key -}}
{{- $data := default dict (get $secrets .name) -}}
{{- $_ := set $data .key (toString .value | b64enc) -}}
{{- $_ := set $secrets .name $data -}}
{{- end -}}
{{- end -}}
{{- toYaml $secrets -}}
{{- end -}}
