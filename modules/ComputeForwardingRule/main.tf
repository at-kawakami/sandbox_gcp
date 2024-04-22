resource "google_compute_global_forwarding_rule" "main" {
  ip_address            = "${var.ip_address}"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  name                  = "${var.forwarding_rule_name}"
  port_range            = "443-443"
  target                = "${var.target_https_proxy}"
}
