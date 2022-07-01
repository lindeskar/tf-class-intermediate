# Exercise 09

variable "e09_object_count" {
  type = number
  default = 3
}

variable "include_optional_file" {
  type = bool
  default = true
}

resource "google_storage_bucket" "e09" {
  name                        = "${var.google_project}-e09"
  location                    = var.google_region
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "e09_dynamic_file" {
  count   = var.e09_object_count
  bucket  = google_storage_bucket.e09.name
  name    = "dynamic-file-${count.index}"
  content = "dynamic-file at index ${count.index}"
}

resource "google_storage_bucket_object" "e09_optional_file" {
  count   = var.include_optional_file ? 1 : 0
  bucket  = google_storage_bucket.e09.name
  name    = "optional-file"
  content = "optional-file"
}
