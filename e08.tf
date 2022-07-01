# Exercise 08

# primitives

variable "e08_my_string" {
  type    = string
  default = "my_string_value"
}

variable "e08_my_number" {
  type    = number
  default = 10
}

variable "e08_my_bool" {
  type    = bool
  default = true
}

output "e08_my_string_interpolated" {
  value = "${var.e08_my_string}_interpolated"
}

output "e08_my_number_plus_two" {
  value = var.e08_my_number + 2
}

output "e08_my_bool_negated" {
  value = !var.e08_my_bool
}

output "e08_my_bool_value" {
  value = var.e08_my_bool == true ? "e08_my_bool is true" : "e08_my_bool is false"
}

# complex

variable "e08_my_list" {
  type    = list(string)
  default = ["1", "2", "3"]
}

variable "e08_my_set" {
  type    = set(number)
  default = [1, 2, 3, 4, 5]
}

variable "e08_my_tuple" {
  type    = tuple([string, number, string])
  default = ["1", 2, "3"]
}

variable "e08_my_map" {
  type = map(any)
  default = {
    names : ["John", "Susy", "Harold"],
    ages : [12, 14, 10]
  }
}

variable "e08_my_object" {
  type = object({
    names : list(string),
    ages : list(number)
  })
  default = {
    names : ["John", "Susy", "Harold"],
    ages : [12, 14, 10]
  }
}

output "e08_my_list_index_2" {
  value = var.e08_my_list[2]
}

output "e08_my_list_values" {
  value = var.e08_my_list
}

output "e08_my_set_values" {
  value = var.e08_my_set
}

output "e08_my_tuple_values" {
  value = var.e08_my_tuple
}

output "e08_my_map_values" {
  value = var.e08_my_map # the ability to do this without quotes is new in 0.12!
}

output "e08_my_object_values" {
  value = var.e08_my_object
}

# other data

data "google_compute_image" "e08_my_image" {
  family  = "centos-7"
  project = "centos-cloud"
}

data "google_compute_zones" "e08_available" {}

output "e08_my_image" {
  value = data.google_compute_image.e08_my_image.name
}

output "e08_current_region_availability_zones" {
  value = data.google_compute_zones.e08_available.names
}
