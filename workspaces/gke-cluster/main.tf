#
# Provision GKE cluster
#
module "gke" {
  source             = "../../modules/terraform-google-gke"
  project_id         = var.project_id
  gke_cluster_name   = var.gke_cluster_name
  zone               = var.zone
  region             = var.region
  allowed_cidr_block = "" # module.bastion[0].bastion_private_ip
  network            = var.network_name
  subnet             = var.subnet_id
}
