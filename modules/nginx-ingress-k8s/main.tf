resource "kubernetes_namespace" "ingress" {
  metadata {
    annotations = {
      name = "ingress"
    }
    name = "ingress"
  }
}

resource "helm_release" "nginx_ingress" {
  name = "external"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  version = "4.10.1"
  namespace = kubernetes_namespace.ingress.metadata[0].name

  values = [
    file("${path.module}/values/nginx-ingress.yaml")
  ]
}
