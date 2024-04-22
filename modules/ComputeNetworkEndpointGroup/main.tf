resource "google_compute_network_endpoint_group" "main" {
  default_port          = 80
  name                  = "web-service"
  network               = "${var.network}"
  network_endpoint_type = "GCE_VM_IP_PORT"
  subnetwork            = "${var.subnetwork}"
  zone                  = "${var.zone}"
}

resource "google_compute_network_endpoint" "main" {
  network_endpoint_group = google_compute_network_endpoint_group.main.name
  port = 80
  instance = "${var.instance}"
  ip_address = "${var.ip_address}"
  zone       = "${var.zone}"
}
