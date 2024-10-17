resource "google_compute_network" "this" {
  project                                     = var.project_id             
  name                                        = var.vpc_name
  delete_default_routes_on_create             = false
  auto_create_subnetworks                     = false
  routing_mode                                = "REGIONAL"
}

  # SUBNETS
resource"google_compute_subnetwork""this" {
      project                                     = var.project_id   
      count = length(var.subnetworks)
      name                                     = var.subnetworks[count.index].name
      ip_cidr_range                            = var.subnetworks[count.index].ip_cidr_range
      region                                   = var.subnetworks[count.index].region
      network                                  = google_compute_network.this.id
      private_ip_google_access                 = true
      dynamic "secondary_ip_range" {
        for_each = (
          contains(keys(var.subnetworks[count.index]), "secondary_ip_ranges") && 
          var.subnetworks[count.index].secondary_ip_ranges != null
        ) ? var.subnetworks[count.index].secondary_ip_ranges : []
        
        content {
          range_name    = secondary_ip_range.value.range_name
          ip_cidr_range = secondary_ip_range.value.ip_cidr_range
        }
      }
}

  # NAT ROUTER
  resource "google_compute_router" "this" {
    project                                     = var.project_id   
    name                                       = "${var.prefix}-${var.env}-router"
    region                                     = google_compute_subnetwork.this[1].region
    network                                    = google_compute_network.this.id
  }

  resource "google_compute_router_nat" "this" {
    project                                     = var.project_id   
    name                               = "${var.prefix}-${var.env}-router-nat"
    router                             = google_compute_router.this.name
    region                             = google_compute_router.this.region
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
    dynamic "subnetwork" {
      for_each = var.subnetworks
      content {
        name                             = subnetwork.value.name
        source_ip_ranges_to_nat         = ["ALL_IP_RANGES"]
      }
    }
  }