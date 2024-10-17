provider "google" {
  project = var.project_id
  region  = var.region
}

provider "kubernetes" {
  config_context_cluster = google_container_cluster.project_gke.name
  # load_config_file       = false
  # in_cluster_config      = true
}

terraform {
  backend "gcs" {}
}
