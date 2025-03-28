resource "kubernetes_namespace" "cert_manager" {
  metadata {
    annotations = {
      name = "cert-manager"
    }
    name = "cert-manager"
  }
}

resource "helm_release" "cert_manager" {
  name = "cert-manager"

  repository = "https://charts.jetstack.io"
  chart = "cert-manager"
  namespace = kubernetes_namespace.cert_manager.metadata[0].name
  version = "v1.14.5"

  set {
    name = "installCRDs"
    value = "true"
  }
}
