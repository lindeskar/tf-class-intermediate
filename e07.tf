# Exercise 07

resource "google_storage_bucket" "e07" {
  name                        = "${var.google_project}-e07"
  location                    = var.google_region
  force_destroy               = true
  uniform_bucket_level_access = true
} # remove to generate syntax error

resource "google_storage_bucket_object" "e07" {
  bucket  = google_storage_bucket.e07.name # Change to invalid TF resource or a string for non-existent bucket
  name    = "testfile"
  content = "Example content"
}
