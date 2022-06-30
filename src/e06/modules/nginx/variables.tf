variable "name_prefix" {
  type = string
}

variable "server_count" {
  type    = number
  default = 1
}

variable "server_machine_type" {
  type    = string
  default = "e2-small"
}

variable "network" {
  type = string
}

variable "subnet" {
  type = string
}
