resource "helm_release" "kubegreen" {
  name       = var.release_name
  repository = "https://kube-green.github.io/helm-charts/"
  chart      = "kube-green"
  version    = var.chart_version != "" ? var.chart_version : null

  dependency_update = true
  create_namespace  = true
  namespace         = var.namespace
  replace           = true

  values = [yamlencode(var.values)]
}
