resource "google_service_account" "default" {
  account_id   = "hogeo-compute"
  display_name = "Custom SA for VM Instance"
}

resource "google_compute_instance" "default" {
  name         = "hogeo-web"
  machine_type = "f1-micro2"
  zone         = "${var.zone}"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      #labels = {
      #  my_label = "value"
      #}
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    #access_config {
    #  // Ephemeral public IP
    #}
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
