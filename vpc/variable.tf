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

variable "prefix" {
  type           = string
  description  = "Prefix Name for this infrastructure"
}


variable "env" {
  type           = string
  description  = "Environment Name for this infrastructure"
}

variable "subnetworks" {
  description = "List of subnetworks to create"
  type = list(object({
    name          = string
    ip_cidr_range = string
    region        = string
    secondary_ip_ranges = optional(list(object({
      range_name    = string
      ip_cidr_range = string
    })))
  }))
}

variable "vpc_name" {
  type           = string
  description  = "Name of the VPC"
}
