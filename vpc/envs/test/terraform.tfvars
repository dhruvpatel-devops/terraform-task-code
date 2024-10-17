vpc_name                                     = "poc-test-vpc"
prefix                                       = "poc"
env                                          = "test"
project_id                                   = "project-poc-437304"
region                                       = "us-central1"
subnetworks                                  = [
  {
    name          = "poc-test-subnet-1"
    ip_cidr_range = "192.168.0.0/24"
    region        = "us-central1"
    secondary_ip_ranges = [
      {
        range_name    = "poc-secondary-range-1"
        ip_cidr_range = "192.168.2.0/24"
      },
      {
        range_name    = "poc-secondary-range-2"
        ip_cidr_range = "192.168.3.0/24"
      }
    ]

  },
  {
    name          = "poc-test-subnet-2"
    ip_cidr_range = "192.168.1.0/24"
    region        = "us-central1"
  },
  // Add more subnetwork configurations as needed
]
