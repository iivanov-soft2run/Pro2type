# Github Provider for Crossplane
resource "kubectl_manifest" "gh-provider" {
  yaml_body = <<YAML
apiVersion: pkg.crossplane.io/v1
kind: Provider
metadata:
  name: provider-gh
spec:
  package: "crossplane/provider-github"
YAML
}

resource "kubectl_manifest" "gh-provider-secret" {
  yaml_body = <<YAML
apiVersion: v1
kind: Secret
metadata:
  namespace: crossplane
  name: provider-gh-secret
type: Opaque
data:
  token: "${base64encode(var.gh_token)}"
YAML
}
resource "kubectl_manifest" "gh-provider-config" {
  yaml_body = <<YAML
apiVersion: github.crossplane.io/v1beta1
kind: ProviderConfig
metadata:
  name: gh-crossplane-config
spec:
  credentials:
    source: Secret
    secretRef:
      namespace: crossplane
      name: provider-gh-secret
      key: token
YAML
}