variable "student_alias" {
  description = "Your student alias"
}

variable "name" {
  description = "The name for the microservice and all resources in this module"
}

variable "min_size" {
  type        = number
  description = "The min number of servers to run in the instance group for this microservice"
}

variable "max_size" {
  type        = number
  description = "The max number of servers to run in the instance group for this microservice"
}

variable "is_internal_lb" {
  type        = bool
  description = "If set to true, the LB will be internal, and therefore only accessible from within the VPC"
}

variable "server_http_port" {
  type        = number
  description = "The port the instances should listen on for HTTP requests"
  default     = 8080
}

variable "lb_http_port" {
  type        = number
  description = "The port the LB should listen on for HTTP requests"
  default     = 80
}

variable "server_text" {
  description = "The text the server should return for HTTP requests"
  default     = "Hello, World"
}

variable "backend_url" {
  description = "The URL the frontend can use to reach the backend. Leave blank if this is not a frontend."
  default     = ""
}

variable "server_machine_type" {
  type    = string
  default = "e2-micro"
}

variable "server_machine_image" {
  type    = string
  default = "ubuntu-2004-focal-v20220615"
}

variable "network" {
  type = string
}

variable "subnet" {
  type = string
}
