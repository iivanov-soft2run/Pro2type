# Digital Ocean Provider for Crossplane
resource "kubectl_manifest" "do-provider" {
  yaml_body = <<YAML
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-do
spec:
  package: "crossplane/provider-digitalocean:v0.1.0"
YAML
}

resource "kubectl_manifest" "do-provider-secret" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  namespace: crossplane
  name: provider-do-secret
type: Opaque
data:
  token: "${base64encode(var.do_token)}"
YAML
}
resource "kubectl_manifest" "do-provider-config" {
  yaml_body = <<YAML
apiVersion: do.crossplane.io/v1alpha1
kind: ProviderConfig
metadata:
  name: do-crossplane-config
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane
      name: provider-do-secret
      key: token
YAML
}