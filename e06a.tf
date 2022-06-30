# Exercise 06a

module "e06" {
  source          = "./src/e06/modules/gcs_bucket_and_obj"
  bucket_name     = "${var.google_project}-e06"
  bucket_location = var.google_region
  object_name     = "e06-object-via-module"
  object_content  = "Test file contents"
}
