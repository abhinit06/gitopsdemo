terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}
provider "google" {
  version = "3.5.0"
  project = "gitops-trial"
  region  = "us-central1"
  zone    = "us-central1-a"
}

#resource "google_compute_network" "vpc_network" {
#  name = "terraform-network"
#}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "3.3.0"

  project_id   = "${var.project}"
  network_name = "${var.env}"
}

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance1"
  machine_type = "f1-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}
