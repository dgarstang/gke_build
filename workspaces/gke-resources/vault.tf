resource "argocd_application" "vault_app" {
  metadata {
    name      = "vault"
    namespace = "argocd" # Ensure this is the Argo CD namespace
  }
  spec {
    project = "default" # Or your Argo CD project

    source {
      repo_url        = "https://helm.releases.hashicorp.com"
      chart          = "vault"
      target_revision = "0.26.0" # Match the version you deployed
      helm {
        values = <<-EOT
          server:
            standalone:
              enabled: true
          injector:
            enabled: false
          server:
            persistence:
              enabled: true
              size: 10Gi
              storageClass: "standard-rwo" # Ensure this matches your setup
          ui:
            enabled: true
            service:
              type: LoadBalancer
        EOT
      }
    }

    destination {
      server    = "https://kubernetes.default.svc" # Your GKE cluster API server
      namespace = "vault"                         # The namespace where Vault is deployed
    }

    sync_policy {
      automated {
        prune     = true # Optional: Prune resources no longer in the desired state
        self_heal = true # Optional: Automatically revert changes
      }
      sync_options = [
        "CreateNamespace=true" # Ensure the namespace exists
      ]
    }
  }
}
