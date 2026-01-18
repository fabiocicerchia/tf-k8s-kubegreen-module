provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

resource "helm_release" "kubegreen" {
  name             = var.release_name
  namespace        = var.namespace
  create_namespace = true
  version          = var.chart_version != "" ? var.chart_version : null

  repository = "https://kube-green.github.io/helm-charts/"
  chart      = "kube-green"

  values = [
    yamlencode(var.values)
  ]
}
