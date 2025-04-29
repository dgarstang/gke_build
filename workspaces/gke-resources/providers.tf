provider "helm" {
  kubernetes {
    config_path = "~/.kube/config" # Must match the kubernetes provider config
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "argocd" {
  server_addr = "${local.argocd_ip_addr}:80"
  #server_addr = "34.168.92.172:80" #${module.argocd_server_ip}"
  username    = "admin"
  password    = "Ograysion0#"
  insecure    = true
}
