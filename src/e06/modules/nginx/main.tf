resource "google_service_account" "nginx" {
  account_id   = "${var.server_name_prefix}-nginx"
  display_name = "${var.server_name_prefix}-nginx"
}

resource "google_compute_instance" "nginx" {
  count                     = var.server_count
  name                      = "${var.server_name_prefix}-nginx-${var.server_count}"
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
    network = "default"
    access_config {}
  }

  service_account {
    email  = google_service_account.nginx.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata_startup_script = templatefile("${path.module}/sh-nginx-setup.tpl", {})
}

resource "google_compute_firewall" "nginx" {
  name    = "${var.server_name_prefix}-http-to-nginx"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["nginx"]
  source_ranges = ["0.0.0.0/0"]
}
