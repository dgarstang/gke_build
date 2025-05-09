#
# Provision network
#
module "network" {
  source  = "../../modules/terraform-google-network"
  subnets = var.subnets
}

#
# Provision bastion host
#
/*module "bastion" {
  source         = "../../modules/terraform-google-service_vm"
  service_name   = "bastion"
  region         = var.region
  zone           = var.zone
  network_name   = var.network_name
  subnet_id      = var.subnet_id
  ssh_public_key = var.ssh_public_key
  depends_on     = [module.network]
} */

#
# Provision vault host
#
module "vault" {
  source         = "../../modules/terraform-google-service_vm"
  service_name   = "vault"
  region         = var.region
  zone           = var.zone
  network_name   = var.network_name
  subnet_id      = var.subnet_id
  ssh_public_key = var.ssh_public_key
  depends_on     = [module.network, google_kms_crypto_key_iam_member.vault_sa]
  service_account = google_service_account.vault.email
  extra_metadata = {
    startup-script = templatefile("${path.module}/vault-startup.sh.tpl", {
      key_ring_name = google_kms_key_ring.vault.name
      crypto_key_name = google_kms_crypto_key.vault.name
    })
  }
}
