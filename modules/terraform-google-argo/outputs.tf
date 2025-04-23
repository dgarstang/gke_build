output "argocd_server_ip" {
  value = data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].ip
}
