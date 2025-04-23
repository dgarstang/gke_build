data "kubernetes_service" "argocd_server" {
   provider = kubernetes.gke
  metadata {
    name      = "argocd-server"
    namespace = "argocd"
  }
}
