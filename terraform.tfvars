# terraform.tfvars

google_project_apis = [
  "compute.googleapis.com",
  "secretmanager.googleapis.com"
]

google_project_metadata = {
  "disable-legacy-endpoints" = "TRUE",
  "enable-osconfig"          = "TRUE",
  "enable-oslogin"           = "TRUE",
}
