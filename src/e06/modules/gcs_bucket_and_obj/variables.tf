variable "bucket_name" {
  type = string
}

variable "bucket_location" {
  type = string
}

variable "object_name" {
  type    = string
  default = "default-object"
}

variable "object_content" {
  type    = string
  default = "Default object content"
}
