/*output "argocd_initial_admin_password" {
  #value     = base64decode(data.kubernetes_secret.argocd_admin.data["password"])
  value     = data.kubernetes_secret.argocd_admin.data
  sensitive = false #true
} */

output "argocd_server_ip" {
  value = data.kubernetes_service.argocd_server.status[0].load_balancer[0].ingress[0].ip
}
