/*
output "bastion_public_ip_address" {
  value = module.bastion[0].bastion_public_ip
}

output "bastion_private_ip_address" {
  value = module.bastion[0].bastion_private_ip
}

output "vpn_public_key" {
  value = module.bastion[0].wg_public_key
}

output "gke_cluster_private_endpoint" {
  value = module.gke[0].private_endpoint
} */

output "gke_endpoint_ip" {
  value = module.gke.endpoint_ip
}
