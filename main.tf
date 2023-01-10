terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

# With this backend configuration we are telling Terraform that the
# created state should be saved in some Google Cloud Bucket with some prefix
backend "gcs" {
  ## INSERT YOUR BUCKET HERE!!
  bucket = "tf-state1212"
  prefix = "terraform/state"
  credentials = "terraform-sa.json"
  }
}

provider "google" {
  version = "3.5.0"
  project = "gitops-trial"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_instance" "default" {
  name = "terraform-test-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }
