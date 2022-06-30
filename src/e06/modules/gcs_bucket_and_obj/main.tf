resource "google_storage_bucket" "e06" {
  name                        = var.bucket_name
  location                    = var.bucket_location
  force_destroy               = true
  uniform_bucket_level_access = true
}

resource "google_storage_bucket_object" "e06" {
  bucket  = google_storage_bucket.e06.name
  name    = var.object_name
  content = var.object_content
}
