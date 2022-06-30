output "public_ips" {
  value = var.server_count > 0 ? ["${google_compute_instance.nginx.*.network_interface.0.access_config.0.nat_ip}"] : null
}
