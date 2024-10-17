variable "existing_service_account_name" {
  description = "Insert Service account to use service."
  default     = ""
}

variable "secret_name" {
  description = "Give secret name"
  default     = ""
}

variable "sql_instance_name" {
  description = "Give Sql instance name"
  default     = ""
}

variable "region" {
  description = "Enter region to deploy resources"
  default     = ""
}

variable "Mysql_database_version" {
  description = "MySql database version"
  default     = ""
}

variable "Sql_instance_type" {
  description = "Sql database instance type"
  default     = ""
}

variable "cloudrun_name" {
  description = "Cloudrun name"
  default     = ""
}

variable "cloudrun_ingress_traffic" {
  description = "Cloudrun ingress traffic"
  default     = ""
}

variable "cloudrun_max_instance_count" {
  description = "Cloudrun max instance count"
  default     = ""
}

variable "cloudrun_sql_volume_name" {
  description = "Cloudrun Sql volume name"
  default     = ""
}

variable "cloudrun_existing_vpc_access_name" {
  description = "Give VPC network name to Cloudrun"
  default     = ""
}

variable "cloudrun_existing_vpc_subnetwork_access_name" {
  description = "Give VPC network subnetwork name to Cloudrun"
  default     = ""
}

variable "cloudrun_conatiner_image_url" {
  description = "Give Cloudrun container image url"
  default     = ""
}

variable "cloudrun_conatiner_port" {
  description = "Give Cloudrun container port"
  default     = ""
}

variable "backend_service_cloudrun_for_lb" {
  description = "Give backend service name of cloudrun to lb"
  default     = ""
}

variable "lb_load_balancing_schema" {
  description = "Give load balancing schemma for lb"
  default     = ""
}

variable "lb_protocol" {
  description = "Give load balancer protocol to use"
  default     = ""
}

variable "cloudrun_neg_name" {
  description = "Give name of cloudrun neg"
  default     = ""
}

variable "cloudrun_neg_network_type" {
  description = "Give network type of cloudrun neg"
  default     = ""
}

variable "cloudrun_url_map_name" {
  description = "Give url map name for lb"
  default     = ""
}

variable "cloudrun_http_proxy_name" {
  description = "Give cloudrun http proxy name"
  default     = ""
}

variable "lb_global_forwarding_rule_name" {
  description = "Give name for lb global forwarding rule"
  default     = ""
}

variable "lb_forwarding_port" {
  description = "Give port to which need to forward request"
  default     = ""
}

variable "project_id" {
  description = "project_id of the project"
  default     = ""
}

