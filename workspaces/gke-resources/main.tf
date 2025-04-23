#
# Deploy argocd.
#
module "argocd" {
  source = "../../modules/terraform-google-argo"
  argocd_admin_password = var.argocd_admin_password
}
