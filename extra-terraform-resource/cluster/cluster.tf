resource "google_container_cluster" "project_gke" {
  project             = var.project_id
  location            = var.region
  name                = "${var.prefix}-${var.env}-cluster"
  deletion_protection = false

  addons_config {
    dns_cache_config {
      enabled = false
    }
    gce_persistent_disk_csi_driver_config {
      enabled = false
    }
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
    network_policy_config {
      disabled = true
    }
  }

  binary_authorization {
    evaluation_mode = "DISABLED"
  }

  database_encryption {
    state = "DECRYPTED"
  }

  datapath_provider         = "LEGACY_DATAPATH" #uses the IPTables-based kube-proxy implementation. Set to ADVANCED_DATAPATH to enable Dataplane v2
  default_max_pods_per_node = 32
  default_snat_status {
    disabled = false
  }

  enable_shielded_nodes = true

  ip_allocation_policy {
    cluster_secondary_range_name = var.cluster_secondary_range_name 
    services_secondary_range_name = var.services_secondary_range_name

  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"] # The GKE components exposing logs. Supported values include: SYSTEM_COMPONENTS, APISERVER, CONTROLLER_MANAGER, SCHEDULER, and WORKLOADS.
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }
#The GKE components exposing metrics. Supported values include: SYSTEM_COMPONENTS, APISERVER, SCHEDULER, CONTROLLER_MANAGER, STORAGE, HPA, POD, DAEMONSET, DEPLOYMENT, STATEFULSET, KUBELET, CADVISOR and DCGM
  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]
    managed_prometheus {
      enabled = false
    }
  }
  network = var.network
  network_policy {
    enabled  = false
    provider = "PROVIDER_UNSPECIFIED"
  }

  networking_mode = "VPC_NATIVE"

  node_config {
    disk_size_gb = 30
    disk_type    = "pd-balanced"
    image_type   = "COS_CONTAINERD"
    spot         = true
    labels = {
      pooltype = "default"
    }
    machine_type = "e2-medium"
    metadata = {
      disable-legacy-endpoints = "true"
    }
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
    service_account = "default"
    shielded_instance_config {
      enable_integrity_monitoring = true
    }
  }

  min_master_version       = "1.30.3-gke.1969001"
  initial_node_count       = 1
  remove_default_node_pool = true

  node_locations = ["${var.region}-a"]
  notification_config {
    pubsub {
      enabled = false
    }
  }
  private_cluster_config {
    enable_private_endpoint = true
    enable_private_nodes   = true 
    master_ipv4_cidr_block = var.master_ipv4_cidr_block
    master_global_access_config {
      enabled = false
    }
  }

  release_channel {
    channel = "UNSPECIFIED"
  }

  subnetwork = var.subnetwork
  vertical_pod_autoscaling {
    enabled = true
  }
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.0/16"
      display_name = "net1"
    }

  }
}

########################################################################################################################

resource "google_container_node_pool" "project-gke-ng" {
  project            = var.project_id
  location           = var.region
  cluster            = google_container_cluster.project_gke.name
  name               = var.nodepool_name
  initial_node_count = var.initial_node_count
  node_locations     = var.node_locations

  node_config {
    disk_size_gb    = 10
    spot            = true
    disk_type       = "pd-balanced"
    image_type      = "COS_CONTAINERD"
    labels          = var.node_labels
    machine_type    = var.machine_type
    metadata        = var.node_metadata
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
    service_account = "default"

    shielded_instance_config {
      enable_integrity_monitoring = true
    }
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  # max_pods_per_node = 60

  upgrade_settings {
    max_surge       = var.max_surge
    max_unavailable = var.max_unavailable
  }

  version = "1.30.3-gke.1969001"

  depends_on = [
    google_container_cluster.project_gke
  ]
}
