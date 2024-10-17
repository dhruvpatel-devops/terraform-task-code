variable "project_id" {
  description = "The project to deploy to, if not set the default provider project is used."
  default     = ""
}

variable "region" {
  description = "Region for cloud resources"
  default     = ""
}
variable "cloudsql_name" {
  description = "Name of the cloud sql name"
  default     = ""
}
variable "database_version" {
  description = "The version of of the database. For example, `MYSQL_5_6` or `POSTGRES_9_6`."
  default     = ""
}
variable "network" {
  description = "The VPC of the Project"
  default     = ""
}
variable "subnetwork" {
  description = "The subnetwork of the VPC in the  Project"
  default     = ""
}

variable "tier" {
  description = "The machine tier (First Generation) or type (Second Generation). See this page for supported tiers and pricing: https://cloud.google.com/sql/pricing"
  default     = ""
}

variable "db_name" {
  description = "Name of the default database to create"
  default     = ""
}

variable "prefix" {
  description = "Prefix to be used"
  default     = ""
}

variable "env" {
  description = "Environment name"
  default     = ""
}

variable "user_name" {
  description = "The name of the default user"
  default     = ""
}

# variable "user_host" {
#   description = "The host for the default user"
#   default     = "%"
# }

variable "user_password" {
  description = "The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable."
  default     = ""
}


variable "edition" {
  description = " The edition of the instance, can be ENTERPRISE or ENTERPRISE_PLUS."
  default     = "ENTERPRISE"
}
variable "disk_autoresize" {
  description = "Second Generation only. Configuration to increase storage size automatically."
  default     = true
}

variable "disk_size" {
  description = "Second generation only. The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased."
  default     = 10
}

variable "disk_type" {
  description = "Second generation only. The type of data disk: `PD_SSD` or `PD_HDD`."
  default     = "PD_SSD"
}

