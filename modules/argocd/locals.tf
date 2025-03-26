locals {
  argo_values = templatefile("${path.module}/templates/argo.yaml", 
    {
        argo_hostname = "argo.${var.hostname}"
    }
  )
}
