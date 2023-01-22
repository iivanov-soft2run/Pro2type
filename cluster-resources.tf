resource "helm_release" "crossplane" {
  name             = "crossplane"
  repository       = "https://charts.crossplane.io/stable"
  chart            = "crossplane"
  version          = "1.10.2"
  namespace        = "crossplane"
  create_namespace = true
}

data "kubectl_file_documents" "argocd" {
  content = file("./argocd/argocd.yaml")
}

data "kubectl_file_documents" "app-dispatcher" {
  content = file("./argocd/app-dispatcher.yaml")
}

resource "kubectl_manifest" "argocd-namespace" {
  yaml_body = <<YAML
apiVersion: v1
kind: Namespace
metadata:
  name: argocd
  YAML
}

resource "kubectl_manifest" "argocd" {
  depends_on = [
    kubectl_manifest.argocd-namespace,
  ]
  count              = length(data.kubectl_file_documents.argocd.documents)
  yaml_body          = element(data.kubectl_file_documents.argocd.documents, count.index)
  override_namespace = "argocd"
}

resource "kubectl_manifest" "app-dispatcher" {
  depends_on = [
    kubectl_manifest.argocd,
  ]
  count              = length(data.kubectl_file_documents.app-dispatcher.documents)
  yaml_body          = element(data.kubectl_file_documents.app-dispatcher.documents, count.index)
  override_namespace = "argocd"
}