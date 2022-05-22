{{- define "base.ingress.tpl" -}}
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: {{ .Values.name }}
  annotations:
    kubernetes.io/ingress.class: nginx
spec:
  rules:
  - host: {{ .Values.ingress.hostname }}  
    http:
      paths:
      - backend:
          serviceName: {{ .Values.name }}
          servicePort: http
        path: /
      - backend:
          serviceName: {{ .Values.name }}
          servicePort: https
        path: /
  {{- if hasKey .Values.ingress "hostname_production" }}
  - host: {{ .Values.ingress.hostname_production }}  
    http:
      paths:
      - backend:
          serviceName: {{ .Values.name }}
          servicePort: http
        path: /
      - backend:
          serviceName: {{ .Values.name }}
          servicePort: https
        path: /
  {{- end }}
{{- end }}
{{- define "base.ingress" -}}
{{- include "base.util.merge" (append . "base.ingress.tpl") -}}
{{- end -}}