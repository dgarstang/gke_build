resource "google_compute_instance" "service" {
  name         = var.service_name
  machine_type = var.machine_type
  zone         = var.zone
  can_ip_forward = true
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  service_account {
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
    email = var.service_account != "" ? var.service_account : null
  }
  network_interface {
    subnetwork = var.subnet_id
    dynamic "access_config" {
      for_each = var.assign_public_ip ? [1] : []
      content {}
    }
  }
  tags = ["allow-ssh", "wireguard"]
  metadata = merge(
  {
    ssh-keys       = var.ssh_public_key
    startup-script = local.startup_script
  },
  { for k, v in var.extra_metadata : k => v if k != "startup-script" }
  )
}
