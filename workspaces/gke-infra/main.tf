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
module "bastion" {
  source                = "../../modules/terraform-google-bastion"
  count                 = var.create_bastion ? 1 : 0
  region                = var.region
  zone                  = var.zone
  network_name          = var.network_name
  subnet_id             = var.subnet_id
  ssh_public_key        = var.ssh_public_key
  vpn_client_public_key = var.vpn_client_public_key
  depends_on            = [module.network]
}
