resource "kubernetes_namespace" "argocd" {
  provider = kubernetes.gke
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  provider    = helm.gke
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.51.6"
  #  depends_on = [kubernetes_namespace.argocd]
  values = [file("${path.module}/values.yaml")]
}

data "kubernetes_secret" "argocd_admin" {
  provider = kubernetes.gke
  metadata {
    name      = "argocd-initial-admin-secret"
    namespace = "argocd"
  }
}
