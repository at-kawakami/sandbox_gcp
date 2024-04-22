resource "google_compute_backend_service" "web_service" {
  connection_draining_timeout_sec = 300
  health_checks                   = ["${var.health_check}"]
  load_balancing_scheme           = "EXTERNAL"

  log_config {
    enable      = true
    sample_rate = 1
  }

  name             = "web-service"
  port_name        = "http"
  protocol         = "HTTP"
  security_policy  = "${var.security_policy}"
  session_affinity = "NONE"
  timeout_sec      = 30

  backend {
      balancing_mode               = "RATE"
      capacity_scaler              = 1
      group                        = "${var.network_endpoint_group}"
      max_rate_per_endpoint        = 100
   }
}
