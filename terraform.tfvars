# terraform.tfvars

google_project = "tf-class-intermediate"
google_region  = "europe-west4"
google_zone    = "europe-west4-b"

google_project_apis = [
  "compute.googleapis.com",
  "secretmanager.googleapis.com"
]

google_project_metadata = {
  "disable-legacy-endpoints" = "TRUE",
  "enable-osconfig"          = "TRUE",
  "enable-oslogin"           = "TRUE",
}
