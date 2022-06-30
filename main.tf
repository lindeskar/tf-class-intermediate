# main.tf

## APIs
resource "google_project_service" "default" {
  for_each = toset(var.google_project_apis)
  project  = var.google_project
  service  = each.key
}

## Metadata
resource "google_compute_project_metadata_item" "default" {
  for_each   = var.google_project_metadata
  depends_on = [google_project_service.default]
  project    = var.google_project
  key        = each.key
  value      = each.value
}
