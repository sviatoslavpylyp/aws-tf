resource "kubernetes_namespace" "monitoring" {
  metadata {
    annotations = {
      name = "monitoring"
    }
    name = "monitoring"
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name = "monitoring"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart = "kube-prometheus-stack"
  version = "67.3.0"
  namespace = kubernetes_namespace.monitoring.metadata[0].name
  values = [ 
    local.prometheus,
    local.alertmanager,
    local.grafana
  ]
}

resource "helm_release" "loki" {
  name = "loki"
  repository = "https://grafana.github.io/helm-charts"
  chart = "loki-stack"
  namespace = kubernetes_namespace.monitoring.metadata[0].name
  values = [ 
    local.loki_stack
  ]

  depends_on = [ helm_release.kube_prometheus_stack ]
}
