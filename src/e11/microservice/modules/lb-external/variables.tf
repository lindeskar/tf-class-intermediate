variable "name" {
  description = "The name for the microservice and all resources in this module"
}

variable "port" {
  type        = number
  description = "The port the instances should listen on for HTTP requests"
  default     = 8080
}

variable "lb_port" {
  type        = number
  description = "The port the LB should listen on for HTTP requests"
  default     = 80
}

variable "network" {
  type = string
}

variable "instance_group" {
  type = string
}
