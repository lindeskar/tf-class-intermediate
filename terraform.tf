# terraform.tf

terraform {
  required_version = ">= 1.2"

  backend "gcs" {
    bucket = "tf-class-intermediate-state"
    prefix = "terraform/tfstate"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.27"
    }
  }
}

provider "google" {
  project = var.google_project
  region  = var.google_region
  zone    = var.google_zone
}
