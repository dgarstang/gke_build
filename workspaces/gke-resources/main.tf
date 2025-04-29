#
# Deploy argocd.
#
#module "argocd" {
#  source = "../../modules/terraform-google-argo"
#  argocd_admin_password = var.argocd_admin_password
#}

#resource "kubernetes_manifest" "guestbook_ui_patch" {
#  manifest = yamldecode(file("service-patch.yaml"))
#}

