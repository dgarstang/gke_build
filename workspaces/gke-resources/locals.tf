locals {
  argocd_ip_addr = data.terraform_remote_state.argocd_setup.outputs.argocd_server_ip
}
