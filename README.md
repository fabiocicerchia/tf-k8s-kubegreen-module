# KubeGreen Pod Hibernation Module

Terraform module to deploy KubeGreen (automated resource cleanup and pod hibernation) on Kubernetes using Helm.

## Overview

KubeGreen provides automated resource cleanup and pod hibernation for cost optimization. It automatically sleeps and wakes workloads on schedules, reducing costs during off-hours.

- **Pod Hibernation**: Automatically sleep and wake pods on schedule
- **Cost Reduction**: Reduce costs by turning off non-production workloads
- **Scheduled Operations**: Define sleep schedules per namespace or workload
- **SleepInfo Resources**: Manage hibernation via Kubernetes custom resources
- **Multi-environment Support**: Configure different schedules for dev, test, prod

## Quick Start

```hcl
module "kubegreen" {
  source = "git::https://github.com/fabiocicerchia/tf-k8s-kubegreen-module.git?ref=main"

  kubeconfig_path = "~/.kube/config"
  release_name    = "kube-green"
  namespace       = "kube-green"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `kubeconfig_path` | Path to the kubeconfig file | `string` | `"~/.kube/config"` | no |
| `release_name` | Helm release name for KubeGreen | `string` | `"kube-green"` | no |
| `namespace` | Kubernetes namespace for KubeGreen | `string` | `"kube-green"` | no |
| `chart_version` | Helm chart version (empty string for latest) | `string` | `""` | no |
| `values` | Helm values for KubeGreen deployment | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| `namespace` | Kubernetes namespace where KubeGreen is deployed |
| `release_name` | Helm release name of KubeGreen |
| `chart_version` | Chart version of KubeGreen deployment |

## Requirements

- Terraform >= 1.0
- Helm >= 2.0
- Kubernetes v1.24+
- kubectl configured to access your cluster

## Usage

### Basic Deployment

```hcl
module "kubegreen" {
  source = "git::https://github.com/fabiocicerchia/tf-k8s-kubegreen-module.git?ref=main"

  kubeconfig_path = "~/.kube/config"
}
```

### With Custom Configuration

```hcl
module "kubegreen" {
  source = "git::https://github.com/fabiocicerchia/tf-k8s-kubegreen-module.git?ref=main"

  kubeconfig_path = "~/.kube/config"
  
  values = {
    kubeGreen = {
      timezone = "UTC"
    }
  }
}
```

### Pin Chart Version

```hcl
module "kubegreen" {
  source = "git::https://github.com/fabiocicerchia/tf-k8s-kubegreen-module.git?ref=main"

  kubeconfig_path = "~/.kube/config"
  chart_version   = "0.8.0"
}
```

## Configure Hibernation

Create SleepInfo resources to define hibernation schedules:

```bash
kubectl apply -f - <<EOF
apiVersion: kube-green.com/v1alpha1
kind: SleepInfo
metadata:
  name: dev-sleep
  namespace: development
spec:
  schedule: "0 22 * * *"  # 10 PM daily
  wakeup: "0 8 * * *"     # 8 AM daily
  weekdays:
    - MON
    - TUE
    - WED
    - THU
    - FRI
EOF
```

## Verify Deployment

```bash
# Check KubeGreen pod
kubectl get pods -n kube-green

# View SleepInfos
kubectl get sleepinfos -A

# Check KubeGreen logs
kubectl logs -n kube-green -l app.kubernetes.io/name=kube-green
```

## Resources

- [KubeGreen GitHub](https://github.com/kube-green/kube-green)
- [KubeGreen Documentation](https://kube-green.github.io/)
- [KubeGreen CRD Reference](https://kube-green.github.io/getting-started/sleep-info-crd/)
