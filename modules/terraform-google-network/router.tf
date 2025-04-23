#
# Create a nat router in each region.
#
resource "google_compute_router" "nat_router" {
  for_each   = var.subnets
  name       = "nat-router-region-${each.key}"
  network    = var.network_name
  region     = each.value.region
  depends_on = [google_compute_network.custom_vpc]
}

#
# Create a nat router config in each region.
#
resource "google_compute_router_nat" "nat_config" {
  for_each                           = var.subnets
  name                               = "nat-config-${each.key}"
  router                             = google_compute_router.nat_router[each.key].name
  region                             = google_compute_router.nat_router[each.key].region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  log_config {
    enable = true
    filter = "ALL"
  }
}

