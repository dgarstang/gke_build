data "terraform_remote_state" "argocd_setup" {
  backend = "gcs"
  config = {
    bucket = "doug-gke_build"
    prefix = "terraform/gke-argocd/state"
  }
}

/*data "kubernetes_secret" "argocd_admin" {
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
} */
