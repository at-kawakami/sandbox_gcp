resource "google_compute_target_https_proxy" "main" {
  name             = "${var.target_https_proxy_name}"
  quic_override    = "NONE"
  # 証明書をterraform管理するか、決め打ちでmainに配置しておくかどうしよう
  ssl_certificates = ["https://www.googleapis.com/compute/v1/projects/hogeo-project/global/sslCertificates/web-service-jp"]
  url_map          = "${var.url_map_id}"
}
