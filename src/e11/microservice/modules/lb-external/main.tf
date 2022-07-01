# External LB
resource "google_compute_region_health_check" "default" {
  name = "microsvc-${var.name}"
  http_health_check {
    port_specification = "USE_SERVING_PORT"
  }
}

resource "google_compute_region_backend_service" "default" {
  name                  = "microsvc-${var.name}"
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  timeout_sec           = 10
  health_checks         = [google_compute_region_health_check.default.id]
  backend {
    group           = var.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_region_url_map" "default" {
  name            = "microsvc-${var.name}"
  default_service = google_compute_region_backend_service.default.id
}

resource "google_compute_region_target_http_proxy" "default" {
  name    = "microsvc-${var.name}"
  url_map = google_compute_region_url_map.default.id
}

resource "google_compute_address" "default" {
  name         = "microsvc-${var.name}-lb"
  address_type = "EXTERNAL"
  subnetwork   = null
  network_tier = "STANDARD"
}

resource "google_compute_forwarding_rule" "default" {
  name                  = "microsvc-${var.name}"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = var.lb_port
  target                = google_compute_region_target_http_proxy.default.id
  network               = var.network
  subnetwork            = null
  ip_address            = google_compute_address.default.id
  network_tier          = "STANDARD"
}
