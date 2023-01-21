# Digital Ocean Provider for Crossplane
resource "kubernetes_manifest" "do-provider" {
  manifest = {
    apiVersion = "pkg.crossplane.io/v1"
    kind       = "Provider"
    metadata = {
      name = "provider-do"
    }
    spec = {
      package = "crossplane/provider-digitalocean:v0.1.0"
    }
  }
}

resource "kubernetes_manifest" "do-provider-secret" {
  manifest = {
    apiVersion = "v1"
    kind       = "Secret"
    metadata = {
      namespace = "crossplane"
      name      = "provider-do-secret"
    }
    type = "Opaque"
    data = {
      token = base64encode(var.do_token)
    }
  }
}
resource "kubernetes_manifest" "do-provider-config" {
  manifest = {
    apiVersion = "do.crossplane.io/v1alpha1"
    kind       = "ProviderConfig"
    metadata = {
      name = "do-provider-config"
    }
    spec = {
      credentials = {
        source = "Secret"
        secretRef = {
          namespace = "crossplane"
          name      = "provider-do-secret"
          key       = "token"
        }
      }
    }
  }
}