output "cluster_ca_certificate" {
  value = google_container_cluster.minimal.master_auth[0].cluster_ca_certificate
}

output "private_endpoint" {
  value = google_container_cluster.minimal.private_cluster_config[0].private_endpoint
}

output "kubeconfig_raw" {
  value = google_container_cluster.minimal #.kubeconfig.raw_config
  sensitive = true
}

output "client_key" {
  value = google_container_cluster.minimal.master_auth[0].client_key
}

output "client_certificate" {
  value = google_container_cluster.minimal.master_auth[0].client_certificate
}
