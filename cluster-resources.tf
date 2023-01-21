resource "helm_release" "crossplane" {
  name             = "crossplane"
  repository       = "https://charts.crossplane.io/stable"
  chart            = "crossplane"
  version          = "1.10.2"
  namespace        = "crossplane"
  create_namespace = true
}