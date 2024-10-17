# provider "google-beta" {
#   version = "~> 2.13"
# }
provider "google" {
  credentials = file("key.json")
  project     = "project-poc-437304"
  region      = "us-central1"
}

# terraform {
#   backend "gcs" {}
# }