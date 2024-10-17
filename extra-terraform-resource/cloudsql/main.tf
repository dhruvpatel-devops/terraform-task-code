# Reference existing VPC and Subnet
data "google_compute_network" "existing_vpc" {
  project              = var.project_id
  name = var.network
}

data "google_compute_subnetwork" "existing_subnet" {
  project              = var.project_id
  name   = var.subnetwork
  region = var.region  # Change this to your subnet's region
}



resource "google_sql_database_instance" "master" {
  name                 = "${var.prefix}-${var.env}-cloudsql" 
  project              = var.project_id
  region               = var.region
  database_version     = var.database_version
  deletion_protection=false
  settings {
    tier                        = var.tier
    disk_autoresize             = var.disk_autoresize
    edition               = var.edition
    disk_size        = var.disk_size
    disk_type        = var.disk_type
    ip_configuration {
      psc_config {
        psc_enabled = true
        allowed_consumer_projects = [var.project_id]
      }
      ipv4_enabled                                  = false
      # private_network                               = data.google_compute_network.existing_vpc.self_link  # Use the VPC's self_link here
      # enable_private_path_for_google_cloud_services = true
    }
  }


}

resource "google_sql_database" "default" {
  name      = var.db_name
  project   = var.project_id
  instance  = google_sql_database_instance.master.name
}


resource "google_sql_user" "default" {
  name     = var.user_name
  project  = var.project_id
  instance = google_sql_database_instance.master.name
#   host     = var.user_host
  password = var.user_password
}
resource "google_compute_address" "prj_b_psc_address" {
  project      = var.project_id
  name         = "${var.prefix}-${var.env}-cloudsql-psc-address"
  subnetwork   = data.google_compute_subnetwork.existing_subnet.id
  address_type = "INTERNAL"
  region       = var.region
}

resource "google_compute_forwarding_rule" "prj_b_psc_endpoint" {
  project                 = var.project_id
  name                    = "${var.prefix}-${var.env}-cloudsql-psc-endpoint"
  region                  = var.region
  load_balancing_scheme   = ""
  target                  = google_sql_database_instance.master.psc_service_attachment_link
  network                 = data.google_compute_network.existing_vpc.id
  ip_address              = google_compute_address.prj_b_psc_address.id
  allow_psc_global_access = true
}


