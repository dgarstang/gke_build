variable "network_name" {
  type        = string
  description = "Name of the VPC network"
  validation {
    condition     = can(regex("^[a-z]([-a-z0-9]{0,61}[a-z0-9])?$", var.network_name))
    error_message = "Network name must be 1–63 characters long, start with a lowercase letter, and contain only lowercase letters, digits, and hyphens (but cannot end with a hyphen)."
  }
}

variable "project_id" {
  type        = string
  description = "Google Cloud project ID"
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{5,29}$", var.project_id))
    error_message = "Project ID must be 6 to 30 characters long, start with a lowercase letter, and contain only lowercase letters, digits, or hyphens."
  }
}

variable "region" {
  type        = string
  description = "Region where resources will be deployed"
  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]$", var.region))
    error_message = "Region must match the format 'xx-xxxx#', e.g., 'us-central1'."
  }
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for instance access"
  validation {
    condition     = can(regex("^[A-Za-z0-9_+.-]+:(ssh-(rsa|ed25519)|ecdsa-sha2-nistp(256|384|521)) [A-Za-z0-9+/=]+( .*)?$", var.ssh_public_key))
    error_message = "The ssh_public_key must be a valid SSH key starting with 'ssh-rsa', 'ssh-ed25519', or 'ecdsa-...'."
  }
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to use"
  validation {
    condition     = can(regex("^[a-z]([-a-z0-9]{0,61}[a-z0-9])?$", var.subnet_id))
    error_message = "The subnet name must be 1–63 characters long, start with a lowercase letter, and contain only lowercase letters, numbers, or hyphens. It cannot end with a hyphen."
  }
}

variable "subnets" {
  type        = map(any)
  description = "Map of subnets to create, keyed by name"
  validation {
    condition = alltrue([
      for subnet_name, subnet in var.subnets : (
        contains(keys(subnet), "ip_cidr_range") &&
        contains(keys(subnet), "region") &&
        can(regex("^(?:(?:[0-9]{1,3}\\.){3}[0-9]{1,3})/[0-9]{1,2}$", subnet["ip_cidr_range"])) &&
        can(regex("^[a-z]+-[a-z]+[0-9]$", subnet["region"]))
      )
    ])
    error_message = "Each subnet must be a map with exactly two keys: 'ip_cidr_range' and 'region'. The 'ip_cidr_range' must be a valid CIDR block (e.g. 10.138.0.0/20) and 'region' must match the format (e.g. us-west1)."
  }
}

variable "zone" {
  type        = string
  description = "Zone where resources will be deployed"
  validation {
    condition     = can(regex("^[a-z]+-[a-z]+[0-9]+-[a-z]$", var.zone))
    error_message = "Zone must follow the GCP zone format, e.g., us-central1-a, europe-west1-b."
  }
}

variable "tailscale_auth_key" {
  type = string
}
