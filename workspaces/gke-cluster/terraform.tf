terraform {
  backend "gcs" {
    bucket = "doug-gke_build"
    prefix = "terraform/gke-cluster/state"
  }
}
