project_id                               = "project-poc-437304"
region                                   = "us-central1"
# cluster_name                             = "poc-gke"
nodepool_name                            = "nodegroup"
initial_node_count                       = 1
node_locations                           = ["us-central1-a", "us-central1-b", "us-central1-c"]
node_labels                              = { pooltype = "default" }
machine_type                             = "e2-standard-2"
node_metadata                            = { disable-legacy-endpoints = "true" }
master_ipv4_cidr_block                   = "192.168.5.0/28"
min_node_count                           = 0
max_node_count                           = 10
max_surge                                = 1
max_unavailable                          = 0
network                                  = "projects/project-poc-437304/global/networks/poc-test-vpc"
subnetwork                               = "projects/project-poc-437304/regions/us-central1/subnetworks/poc-test-subnet-1"
services_secondary_range_name            = "poc-secondary-range-1"
cluster_secondary_range_name             = "poc-secondary-range-2"
prefix                                       = "poc"
env                                          = "test"