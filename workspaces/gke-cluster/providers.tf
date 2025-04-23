provider "google" {
  project = var.project_id
  region  = var.region
}

/*provider "kubernetes" {
  alias                  = "gke"
  host                   = "https://${module.gke[0].endpoint}"
  cluster_ca_certificate = base64decode(module.gke[0].ca_certificate)
  token                  = data.google_client_config.default.access_token
}

provider "helm" {
  alias = "gke"
  kubernetes {
    host                   = "https://${module.gke[0].endpoint}"
    cluster_ca_certificate = base64decode(module.gke[0].ca_certificate)
    token                  = data.google_client_config.default.access_token
  }
}

provider "argocd" {
  server_addr = "https://${module.argocd.argocd_server_ip}"
  username    = "admin"
  password    = var.argocd_admin_password
  insecure    = true
}
*/
