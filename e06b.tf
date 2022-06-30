# Exercise 06b

module "e06_nginx" {
  source             = "./src/e06/modules/nginx"
  server_name_prefix = "e06"
}

output "e06_nginx_public_ips" {
  value = module.e06_nginx.public_ips
}
