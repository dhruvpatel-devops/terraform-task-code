variable "bigtable_instance_name" {
  description = "Insert name of bigtable name."
  default     = ""
}

variable "cluster_id" {
  description = "Cluster id of bigtable"
  default     = ""
}

variable "region" {
  description = "region to deply instance"
  default     = ""
}

variable "num_nodes" {
  description = "enter number of nodes to allocate"
  default     = ""
}

variable "storage_type" {
  description = "give storage type to use"
  default     = ""
}

variable "table_name" {
  description = "table name"
  default     = ""
}

variable "backup_retention_period" {
  description = "Table backup retention period"
  default     = ""
}

variable "table_backup_frequency" {
  description = "backup frequency"
  default     = ""
}