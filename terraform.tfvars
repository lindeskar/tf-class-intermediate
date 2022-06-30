# terraform.tfvars

google_org_id     = "0123456789"
google_billing_id = "012345A-B45678-987654"
google_project    = "my-class-project1234"
google_region     = "europe-west4"
google_zone       = "europe-west4-b"

google_project_apis = [
  "compute.googleapis.com",
  "secretmanager.googleapis.com"
]

google_project_metadata = {
  "disable-legacy-endpoints" = "TRUE",
  "enable-osconfig"          = "TRUE",
  "enable-oslogin"           = "TRUE",
}
