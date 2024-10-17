# provider "google" {
#   project = var.project_id
#   region  = var.region
# }


terraform {
  backend "gcs" {}
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 6.5.0"
    }
  }
}
