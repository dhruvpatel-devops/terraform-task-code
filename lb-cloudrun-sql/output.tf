# Output the Cloud SQL instance connection name
output "cloud_sql_connection_name" {
  value = google_sql_database_instance.instance.connection_name
}

# Output the Cloud Run service URL
output "cloud_run_url" {
  value       = google_cloud_run_v2_service.default.uri
  description = "The URL of the Cloud Run service"
}

# Output the Global Forwarding Rule IP Address
output "load_balancer_ip" {
  value       = google_compute_global_forwarding_rule.cloudrun_forwarding_rule.ip_address
  description = "The IP address of the HTTP Load Balancer"
}
