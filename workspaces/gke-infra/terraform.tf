terraform {
  backend "gcs" {
    bucket = "doug-gke_build"
    prefix = "terraform/gke-infra/state"
  }
}
