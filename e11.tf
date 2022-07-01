# Exercise 11

module "backend" {
  source         = "./src/e11/microservice"
  name           = "backend"
  is_internal_lb = true
  min_size       = 1
  max_size       = 2
  server_text    = "Hello from backend"
  student_alias  = "student11"
  network        = google_compute_network.primary.name
  subnet         = google_compute_subnetwork.default.name
}

output "e11_backend_lb_ip" {
  value = module.backend.lb_ip
}

module "frontend" {
  source         = "./src/e11/microservice"
  name           = "frontend"
  is_internal_lb = false
  min_size       = 1
  max_size       = 2
  server_text    = "Hello from frontend"
  student_alias  = "student11"
  backend_url    = "http://${module.backend.lb_ip}:80"
  network        = google_compute_network.primary.name
  subnet         = google_compute_subnetwork.default.name
}

output "e11_frontend_lb_ip" {
  value = module.frontend.lb_ip
}
