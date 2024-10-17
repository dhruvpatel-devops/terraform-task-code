resource "google_spanner_instance" "example" {
  config       = var.region
  display_name = "${var.prefix}-${var.env}-cloudspanner"
  num_nodes    = var.number_of_nodes
  project      = var.project_id

}