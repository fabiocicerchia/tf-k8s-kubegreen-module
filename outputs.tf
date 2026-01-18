output "namespace" {
  description = "The namespace where KubeGreen is deployed"
  value       = module.kubegreen.namespace
}

output "release_name" {
  description = "The Helm release name of KubeGreen"
  value       = module.kubegreen.release_name
}

output "version" {
  description = "The version of KubeGreen deployed"
  value       = module.kubegreen.version
}
