resource "google_compute_health_check" "main" {
  check_interval_sec = 5
  healthy_threshold  = 2
  name               = "${var.health_check_name}"

  tcp_health_check {
    port_specification = "USE_SERVING_PORT"
    proxy_header       = "NONE"
    request            = "${var.health_path}"
  }

  timeout_sec         = 5
  unhealthy_threshold = 2
}
