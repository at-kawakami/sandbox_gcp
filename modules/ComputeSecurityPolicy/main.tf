resource "google_compute_security_policy" "main" {
  name    = "${var.security_policy_name}"

  rule {
    action      = "allow"
    description = "VPN"

    match {
      config {
        src_ip_ranges = ["34.111.238.169/32"]
      }

      versioned_expr = "SRC_IPS_V1"
    }

    preview  = "false"
    priority = "100"
  }

  rule {
    action      = "deny(403)"
    description = "デフォルトのルール。優先度が高いとオーバーライドされます"

    match {
      config {
        src_ip_ranges = ["*"]
      }

      versioned_expr = "SRC_IPS_V1"
    }

    preview  = "false"
    priority = "2147483647"
  }
}
