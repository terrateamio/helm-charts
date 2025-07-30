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

{{/*
Selector labels
*/}}
{{- define "terrateam.selectorLabels" -}}
app.kubernetes.io/name: {{ include "application.name" . }}-{{ .Values.terrateam.name }}
{{- end }}

{{- define "db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "application.name" . }}-{{ .Values.db.name }}
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
Validate terrateam.config.apiProtocol
*/}}
{{- define "terrateam.validateProtocol" -}}
{{- $protocol := .Values.terrateam.config.apiProtocol -}}
{{- if not (or (eq $protocol "http") (eq $protocol "https")) -}}
{{- fail (printf "terrateam.config.apiProtocol must be 'http' or 'https', got: %s" $protocol) -}}
{{- end -}}
{{- end -}}
