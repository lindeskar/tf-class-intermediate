# Exercise 00

## APIs
resource "google_project_service" "default" {
  for_each           = toset(var.google_project_apis)
  project            = var.google_project
  service            = each.key
  disable_on_destroy = false
}

## Metadata
resource "google_compute_project_metadata_item" "default" {
  for_each   = var.google_project_metadata
  depends_on = [google_project_service.default]
  project    = var.google_project
  key        = each.key
  value      = each.value
}

## VPC
resource "google_compute_network" "primary" {
  name                    = "${var.google_project}-primary"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "default" {
  name          = "${google_compute_network.primary.name}-${var.google_region}"
  network       = google_compute_network.primary.name
  region        = var.google_region
  ip_cidr_range = "10.11.12.0/24"
}

resource "google_compute_firewall" "iap_ssh" {
  name    = "ssh-from-iap"
  network = google_compute_network.primary.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20"]
}
