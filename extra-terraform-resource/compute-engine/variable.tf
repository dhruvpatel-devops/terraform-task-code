variable "project_id" {
  type           = string
  description  = "Project ID"
  default        = ""
}

variable "region" {
  type           = string
  description  = "Region for this infrastructure"
  default        = ""
}
variable "zone" {
  type           = string
  description  = "zone for this infrastructure"
  default        = ""
}
variable "prefix" {
  type           = string
  description  = "Prefix Name for this infrastructure"
}


variable "env" {
  type           = string
  description  = "Environment Name for this infrastructure"
}

variable "subnetworks" {
  description = "Name of subnetworks in which server needs to be create"
  type = any
}
variable "network" {
  description = "Name of VPC  in which server needs to be create"
  type = any
}
variable "machine_type" {
  description = "Machine Type of the server"
  type = any
}
variable "image" {
  description = "Image of the server"
  type = any
}

variable "type" {
  description = " Type  of the storage"
  type = any
}
variable "size" {
  description = "size of disk"
  type = any
}
variable "tcp_ports" {
  description = "TCP Ports for Firewall"
  type = any
}
variable "udp_ports" {
  description = "UDP Ports for Firewall"
  type = any
}
variable "source_ranges" {
  description = "Source Range for Firewall"
  type = any
}