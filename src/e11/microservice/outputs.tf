output "lb_ip" {
  value = var.is_internal_lb == true ? module.lb_internal[0].lb_ip : module.lb_external[0].lb_ip
}
