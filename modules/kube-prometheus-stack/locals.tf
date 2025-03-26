locals {
  prometheus = templatefile("${path.module}/templates/prometheus.yaml",
    {
      prometheus_enabled = true
      prometheus_ingress_enabled = true
      prometheus_host = "prometheus.${var.hostname}"
    }
  )

  grafana = templatefile("${path.module}/templates/grafana.yaml", 
    {
      grafana_enabled = true
      grafana_admin_password = var.grafana_admin_password
      grafana_ingress_enabled = true
      grafana_host = "grafana.${var.hostname}"
    }
  )

  alertmanager = templatefile("${path.module}/templates/alertmanager.yaml", 
    {
      enable_alertmanager = true
      alertmanager_hostname = "alertmanager.${var.hostname}"
      enable_alertmanager_ingress = true
    }
  )

  loki_stack = templatefile("${path.module}/templates/loki-stack.yaml", 
    {
      loki_enable = true
      promtail_enable = true
    }
  )
}
