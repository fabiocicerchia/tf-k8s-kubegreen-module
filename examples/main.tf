terraform {
  required_version = ">= 1.0"
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

module "kubegreen" {
  source = "../"

  release_name  = "kubegreen"
  namespace     = "kubegreen-system"
  chart_version = ""

  values = yamlencode({})
}
