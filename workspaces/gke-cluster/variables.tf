variable "gke_cluster_name" {
  type        = string
  description = "Name of the GKE cluster"
  validation {
    condition     = length(var.gke_cluster_name) < 32
    error_message = "The GKE cluster name must be less than 32 characters."
  }
}

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

variable "subnet_id" {
  type        = string
  description = "ID of the subnet to use"
  validation {
    condition     = can(regex("^[a-z]([-a-z0-9]{0,61}[a-z0-9])?$", var.subnet_id))
    error_message = "The subnet name must be 1–63 characters long, start with a lowercase letter, and contain only lowercase letters, numbers, or hyphens. It cannot end with a hyphen."
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

#variable "argocd_admin_password" {
#}
