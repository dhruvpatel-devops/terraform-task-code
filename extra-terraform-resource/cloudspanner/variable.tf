variable "project_id" {
  description = "The ID of the project in which resources will be managed."
  type        = string
}

variable "region" {
  description = "The region where the cluster will be created."
  type        = string
}


variable "prefix" {
  type           = string
  description  = "Prefix Name for this infrastructure"
}


variable "env" {
  type           = string
  description  = "Environment Name for this infrastructure"
}

variable "number_of_nodes" {
  type           = string
  description  = "Number of Nodes  for this CloudSpanner"
}