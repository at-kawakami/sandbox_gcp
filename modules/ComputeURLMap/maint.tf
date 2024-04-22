resource "google_compute_url_map" "main" {
  default_service = "${var.backend_service}"
  name            = "${var.url_map_name}"

  host_rule {
    hosts        = ["my-service.jp"]
    path_matcher = "path-matcher-1"
  }

  path_matcher {
    default_service = "${var.backend_service}"
    name            = "path-matcher-1"
  }
}
