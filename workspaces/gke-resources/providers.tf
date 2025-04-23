provider "kubernetes" {
  config_path            = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

/*provider "argocd" {
  server_addr = "https://${module.argocd_server_ip}"
  username    = "admin"
  password    = var.argocd_admin_password
} */
