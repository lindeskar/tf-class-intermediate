resource "google_storage_bucket_object" "e03" {
  bucket  = google_storage_bucket.e01.name
  name    = "student.alias"
  content = "This bucket is reserved for ${var.student_alias}"
}
