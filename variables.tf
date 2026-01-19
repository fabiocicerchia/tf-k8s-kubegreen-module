variable "release_name" {
  description = "Helm release name for KubeGreen"
  type        = string
  default     = "kube-green"
}

variable "namespace" {
  description = "Kubernetes namespace for KubeGreen"
  type        = string
  default     = "kube-green"
}

variable "chart_version" {
  description = "KubeGreen Helm chart version (empty string for latest)"
  type        = string
  default     = ""
}

variable "values" {
  description = "Helm values for KubeGreen deployment"
  type        = any
  default     = {}
}
