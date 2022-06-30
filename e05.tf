# Exercise 05

variable "google_region_alt" {
  type    = string
  default = "europe-west1"
}

provider "google" {
  alias   = "alternate"
  project = var.google_project
  region  = var.google_region_alt
  zone    = var.google_zone
}

resource "google_storage_bucket" "e05" {
  name                        = "${var.google_project}-e05"
  provider                    = google.alternate # Does not make sense because `location` must be set
  location                    = var.google_region_alt
  force_destroy               = true
  uniform_bucket_level_access = true
}
