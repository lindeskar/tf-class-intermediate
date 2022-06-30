# Exercise 01

resource "google_storage_bucket" "e01" {
  name                        = "${var.google_project}-e01"
  location                    = var.google_region
  force_destroy               = true
  uniform_bucket_level_access = true
}
