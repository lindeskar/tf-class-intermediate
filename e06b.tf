# Exercise 06b

module "e06_nginx" {
  source       = "./src/e06/modules/nginx"
  name_prefix  = "e06"
  network      = google_compute_network.primary.name
  subnet       = google_compute_subnetwork.default.name
  server_count = 0
}

output "e06_nginx_public_ips" {
  value = module.e06_nginx.public_ips
}
