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

resource "google_compute_subnetwork" "proxy" {
  name          = "${google_compute_network.primary.name}-${var.google_region}-proxy"
  network       = google_compute_network.primary.name
  region        = "europe-west4"
  ip_cidr_range = "10.21.12.0/24"
  purpose       = "REGIONAL_MANAGED_PROXY"
  role          = "ACTIVE"
}

resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal"
  network = google_compute_network.primary.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = [google_compute_subnetwork.default.ip_cidr_range]
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

resource "google_compute_firewall" "allow-iap" {
  name          = "allow-iap"
  direction     = "INGRESS"
  network       = google_compute_network.primary.name
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16", "35.235.240.0/20"]
  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }
}

resource "google_compute_firewall" "allow-proxy" {
  name    = "allow-proxy"
  network = google_compute_network.primary.name
  allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }
  source_ranges = [google_compute_subnetwork.proxy.ip_cidr_range]
}
