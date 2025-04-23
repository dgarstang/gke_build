terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11.0"
      configuration_aliases = [helm.gke]
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24.0"
      configuration_aliases = [kubernetes.gke]
    }
    argocd = {
      source  = "argoproj-labs/argocd"
      version = "~> 7.0"
    }
  }
}
