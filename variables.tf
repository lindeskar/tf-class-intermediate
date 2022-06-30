# variables.tf

variable "google_org_id" {
  type = string
}

variable "google_billing_id" {
  type = string
}

variable "google_project" {
  type = string
}

variable "google_region" {
  type = string
}

variable "google_zone" {
  type = string
}

variable "google_project_apis" {
  description = "APIs to enable in GCP project"
  type        = list(string)
}

variable "google_project_metadata" {
  description = "Metadata items in GCP project"
  type        = map(any)
}
