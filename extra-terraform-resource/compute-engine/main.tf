resource "google_compute_firewall" "default" {
  name    = "${var.prefix}-${var.env}-firewall"
  network = var.network
  project              = var.project_id
  source_ranges = var.source_ranges # ["0.0.0.0/0"]
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = var.tcp_ports #
  }
  allow {
    protocol = "udp"
    ports    = var.udp_ports #["80", "8080", "1000-2000","22"]

  }

  source_tags = ["${var.prefix}-${var.env}-firewall"]
}

resource "google_compute_instance" "this" {
  provider = google
  name = "${var.prefix}-${var.env}-vm"
  project = var.project_id 
  machine_type = var.machine_type # "e2-micro"
  zone = var.zone
  tags = ["${var.prefix}-${var.env}-firewall"]

#   // Local SSD disk
#   scratch_disk {
#     interface = "NVME"
#   }
  network_interface {
    network = var.network
    subnetwork = "projects/${var.project_id}/regions/${var.region}/subnetworks/${var.subnetworks}"
  }

  boot_disk {
    initialize_params {
      image =  var.image #
      type =  var.type # 10GB
      size = var.size #pd-ssd
    }
  }
}