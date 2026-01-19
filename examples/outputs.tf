output "kubegreen_namespace" {
  description = "The namespace where KubeGreen is deployed"
  value       = module.kubegreen.namespace
}

output "kubegreen_release_name" {
  description = "The Helm release name of KubeGreen"
  value       = module.kubegreen.release_name
}

output "kubegreen_chart_version" {
  description = "The chart version of the deployed KubeGreen"
  value       = module.kubegreen.chart_version
}
