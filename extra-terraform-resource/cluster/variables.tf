variable "project_id" {
  description = "The ID of the project in which resources will be managed."
  type        = string
}

variable "region" {
  description = "The region where the cluster will be created."
  type        = string
}

# variable "cluster_name" {
#   description = "The name of the GKE cluster."
#   type        = string
# }
variable "master_ipv4_cidr_block" {
  description = " The IP range in CIDR notation to use for the hosted master network. This range will be used for assigning private IP addresses to the cluster master(s) and the ILB VIP. This range must not overlap with any other ranges in use within the cluster's network, and it must be a /28 subnet."
  type        = any
}
variable "nodepool_name" {
  description = "The name of the node pool."
  type        = string
}

variable "initial_node_count" {
  description = "The initial node count for the pool."
  type        = number
}

variable "node_locations" {
  description = "The zones in which the node pool's nodes should be located."
  type        = list(string)
}

variable "node_labels" {
  description = "The labels to be added to all nodes in the node pool."
  type        = map(string)
}

variable "machine_type" {
  description = "The machine type for the nodes of the node pool."
  type        = string
}

variable "node_metadata" {
  description = "The metadata key/value pairs assigned to nodes in the node pool."
  type        = map(string)
}

variable "network" {
  description = "The network name part of the VPC."
  type        = string
}

variable "subnetwork" {
  description = "The pod's IPv4 CIDR block."
  type        = string
}

variable "cluster_secondary_range_name" {
  description = "The pod's IPv4 CIDR block."
  type        = any
}

variable "services_secondary_range_name" {
  description = "The service's IPv4 CIDR block."
  type        = any
}

variable "min_node_count" {
  description = "The minimum node count for the node pool's autoscaler."
  type        = number
}

variable "max_node_count" {
  description = "The maximum node count for the node pool's autoscaler."
  type        = number
}

variable "max_surge" {
  description = "The maximum number of nodes that can be created beyond the node pool's current size during an upgrade."
  type        = number
}

variable "max_unavailable" {
  description = "The maximum number of nodes that can be unavailable during an upgrade."
  type        = number
}
variable "prefix" {
  type           = string
  description  = "Prefix Name for this infrastructure"
}


variable "env" {
  type           = string
  description  = "Environment Name for this infrastructure"
}