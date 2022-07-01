resource "google_service_account" "microsvc" {
  account_id   = "microsvc-${var.name}"
  display_name = "microsvc-${var.name}"
}

# data "google_compute_image" "microsvc" {
#   family  = "ubuntu-2004-lts"
#   project = "ubuntu-os-cloud"
# }

resource "google_compute_instance_template" "microsvc" {
  name         = "${var.name}-microsvc"
  machine_type = var.server_machine_type
  tags         = ["microsvc", var.name]

  disk {
    source_image = var.server_machine_image
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = var.subnet
    access_config {}
  }

  scheduling {
    preemptible       = false
    automatic_restart = true
  }

  metadata_startup_script = templatefile("${path.module}/user-data-${var.name}.tpl", {
    server_text      = var.server_text
    server_http_port = var.server_http_port
    backend_url      = var.backend_url
  })

  service_account {
    email  = google_service_account.microsvc.email
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_compute_instance_group_manager" "microsvc" {
  name               = "microsvc-${var.name}"
  base_instance_name = "microsvc-${var.name}"
  target_size        = 1
  lifecycle {
    ignore_changes = [
      target_size,
    ]
  }
  version {
    instance_template = google_compute_instance_template.microsvc.id
  }
  named_port {
    name = "http"
    port = var.server_http_port
  }
}

resource "google_compute_autoscaler" "microsvc" {
  name   = "microsvc-${var.name}"
  target = google_compute_instance_group_manager.microsvc.id

  autoscaling_policy {
    max_replicas    = var.max_size
    min_replicas    = var.min_size
    cooldown_period = 30
    cpu_utilization {
      target = 0.8
    }
  }
}

module "lb_internal" {
  count          = var.is_internal_lb == true ? 1 : 0
  source         = "./modules/lb-internal"
  name           = var.name
  network        = var.network
  subnet         = var.subnet
  port           = var.server_http_port
  lb_port        = var.lb_http_port
  instance_group = google_compute_instance_group_manager.microsvc.instance_group
}

module "lb_external" {
  count          = var.is_internal_lb == false ? 1 : 0
  source         = "./modules/lb-external"
  name           = var.name
  network        = var.network
  port           = var.server_http_port
  lb_port        = var.lb_http_port
  instance_group = google_compute_instance_group_manager.microsvc.instance_group
}
