terraform {
    # Here we configure the providers we need to run our configuration
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.51.0"
    }
  }

# With this backend configuration we are telling Terraform that the
# created state should be saved in some Google Cloud Bucket with some prefix
 backend "gcs" {
   ## INSERT YOUR BUCKET HERE!!
   bucket = "${PROJECT_ID}-tfstate"
   prefix = "terraform/state"
 }
}


# We define the "google" provider with the project and the general region + zone
provider "google" {
  project = "gitops-trial"
  region  = "us-central1"
  zone    = "us-central1-a"
}

#Here we define a very small compute instance
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
}
