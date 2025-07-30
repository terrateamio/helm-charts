
{{/*
Validate terrateam.config.apiProtocol
*/}}
{{- define "terrateam.validateProtocol" -}}
{{- $protocol := .Values.terrateam.config.apiProtocol -}}
{{- if not (or (eq $protocol "http") (eq $protocol "https")) -}}
{{- fail (printf "terrateam.config.apiProtocol must be 'http' or 'https', got: %s" $protocol) -}}
{{- end -}}
{{- end -}}
