resource "google_bigtable_instance" "instance" {
  name = var.bigtable_instance_name

  cluster {
    cluster_id   = var.cluster_id
    zone         = var.region
    num_nodes    = var.num_nodes
    storage_type = var.storage_type
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_bigtable_table" "table" {
  name          = var.table_name
  instance_name = google_bigtable_instance.instance.name
  split_keys    = ["a", "b", "c"]

  lifecycle {
    prevent_destroy = true
  }

  column_family {
    family = "family-first"
  }

  column_family {
    family = "family-second"
    type   = "intsum"
  }

  column_family {
    family = "family-third"
    type   = <<EOF
        {
                    "aggregateType": {
                        "max": {},
                        "inputType": {
                            "int64Type": {
                                "encoding": {
                                    "bigEndianBytes": {}
                                }
                            }
                        }
                    }
                }
        EOF
  }

  change_stream_retention = "24h0m0s"

  automated_backup_policy {
    retention_period = var.backup_retention_period
    frequency = var.table_backup_frequency
  }
}