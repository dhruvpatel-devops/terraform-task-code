# Get project information
# data "google_project" "project" {}

# Use the existing Service Account for Cloud Run
variable "existing_service_account" {
  default = var.existing_service_account_name
}

# Create a Secret Manager secret
resource "google_secret_manager_secret" "secret" {
  project                                     = var.project_id   
  secret_id = var.secret_name
  replication {
    auto {}
  }
}

# Store a secret version in Secret Manager
resource "google_secret_manager_secret_version" "secret-version-data" {
  
  secret      = google_secret_manager_secret.secret.name
  secret_data = "secret-data"
}

# IAM Policy to allow Cloud Run to access the secret
resource "google_secret_manager_secret_iam_member" "secret-access" {
  project                                     = var.project_id   
  secret_id = google_secret_manager_secret.secret.id
  role      = "roles/secretmanager.secretAccessor"
  member    = "serviceAccount:${var.existing_service_account}"
  depends_on = [google_secret_manager_secret.secret]
}

# Cloud SQL Instance for Cloud Run
resource "google_sql_database_instance" "instance" {
  project                                     = var.project_id   
  name             = var.sql_instance_name
  region           = var.region
  database_version = var.Mysql_database_version
  settings {
    tier = var.Sql_instance_type # Small instance
  }
  deletion_protection = false
}

# Create a Cloud Run service
resource "google_cloud_run_v2_service" "default" {
  project                                     = var.project_id   
  name              = var.cloudrun_name
  location          = var.region
  ingress           = var.cloudrun_ingress_traffic

  template {
    # Use the provided existing service account for Cloud Run
    service_account = var.existing_service_account

    # Autoscaling configuration for Cloud Run
    scaling {
      max_instance_count = var.cloudrun_max_instance_count
    }

    # Cloud SQL volume for Cloud Run
    volumes {
      name = var.cloudrun_sql_volume_name
      cloud_sql_instance {
        instances = [google_sql_database_instance.instance.connection_name]
      }
    }

    vpc_access{
      network_interfaces {
        network = var.cloudrun_existing_vpc_access_name
        subnetwork = var.cloudrun_existing_vpc_subnetwork_access_name
      }
    }

    # Container configuration for Cloud Run
    containers {
      image = var.cloudrun_conatiner_image_url  # Use Nginx image

      # Environment variables for the container
      env {
        name  = "FOO"
        value = "bar"
      }

      # Environment variable from Secret Manager
      env {
        name = "SECRET_ENV_VAR"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.secret.secret_id
            version = "1"
          }
        }
      }

      # Volume mount for Cloud SQL
      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }

      # Expose the service on port 80
      ports {
        container_port = var.cloudrun_conatiner_port
      }
    }
  }

  # Traffic allocation for the latest revision
  traffic {
    type    = "TRAFFIC_TARGET_ALLOCATION_TYPE_LATEST"
    percent = 100
  }

  depends_on = [
    google_secret_manager_secret_version.secret-version-data
  ]
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  
  location    = google_cloud_run_v2_service.default.location
  project     = google_cloud_run_v2_service.default.project
  service     = google_cloud_run_v2_service.default.name

  policy_data = <<EOF
{
  "bindings": [
    {
      "role": "roles/run.invoker",
      "members": [
        "allUsers"
      ]
    }
  ]
}
EOF
}

# Backend service for Cloud Run in the Load Balancer
resource "google_compute_backend_service" "cloudrun_backend" {
  project                                     = var.project_id   
  name                  = var.backend_service_cloudrun_for_lb
  load_balancing_scheme = var.lb_load_balancing_schema
  protocol              = var.lb_protocol

  backend {
    group = google_compute_region_network_endpoint_group.cloudrun_neg.id
  }

  # Remove health_checks because Serverless NEG backends do not require health checks
  # health_checks = [google_compute_health_check.cloudrun_healthcheck.id]
}

# Cloud Run NEG for Load Balancer
resource "google_compute_region_network_endpoint_group" "cloudrun_neg" {
  project                                     = var.project_id   
  name                  = var.cloudrun_neg_name
  network_endpoint_type = var.cloudrun_neg_network_type
  region                = var.region

  cloud_run {
    service = google_cloud_run_v2_service.default.name
  }
}

# Create a global URL map for the load balancer
resource "google_compute_url_map" "cloudrun_url_map" {
  project                                     = var.project_id   
  name            = var.cloudrun_url_map_name
  default_service = google_compute_backend_service.cloudrun_backend.id
}

# Create an HTTP proxy for the load balancer
resource "google_compute_target_http_proxy" "cloudrun_http_proxy" {
  project                                     = var.project_id   
  name    = var.cloudrun_http_proxy_name
  url_map = google_compute_url_map.cloudrun_url_map.id
}

# Create a global forwarding rule for the load balancer
resource "google_compute_global_forwarding_rule" "cloudrun_forwarding_rule" {
  project                                     = var.project_id   
  name                 = var.lb_global_forwarding_rule_name
  port_range           = var.lb_forwarding_port
  target               = google_compute_target_http_proxy.cloudrun_http_proxy.id
  load_balancing_scheme = var.lb_load_balancing_schema
}

# Assign a role to the existing Cloud Run service account to allow it to connect to Cloud SQL
resource "google_project_iam_member" "cloudrun_sql_access" {
  
  project                                     = var.project_id   
  role    = "roles/cloudsql.client"
  member  = "serviceAccount:${var.existing_service_account}"
}

