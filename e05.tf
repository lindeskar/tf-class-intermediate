# Exercise 05

resource "google_project" "e05" {
  name                = "${var.google_project}-e05"
  project_id          = "${var.google_project}-e05"
  org_id              = var.google_org_id
  billing_account     = var.google_billing_id
  auto_create_network = false
}

provider "google" {
  alias   = "alternate"
  project = google_project.e05.name
  region  = var.google_region
  zone    = var.google_zone
}

resource "google_storage_bucket" "e05" {
  name                        = "${google_project.e05.name}-alt"
  provider                    = google.alternate
  location                    = var.google_region
  force_destroy               = true
  uniform_bucket_level_access = true
}
