resource "google_service_account" "nginx" {
  account_id   = "${var.name_prefix}-nginx"
  display_name = "${var.name_prefix}-nginx"
}

resource "google_compute_instance" "nginx" {
  count                     = var.server_count
  name                      = "${var.name_prefix}-nginx-${var.server_count}"
  tags                      = ["nginx"]
  machine_type              = var.server_machine_type
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      type  = "pd-ssd"
      size  = "50"
    }
  }

  network_interface {
    subnetwork = var.subnet
    access_config {}
  }

  service_account {
    email  = google_service_account.nginx.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata_startup_script = templatefile("${path.module}/sh-nginx-setup.tpl", {})
}

resource "google_compute_firewall" "nginx" {
  name    = "${var.name_prefix}-http-to-nginx"
  network = var.network

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["nginx"]
  source_ranges = ["0.0.0.0/0"]
}
