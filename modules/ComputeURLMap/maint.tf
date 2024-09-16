resource "google_compute_url_map" "main" {
  default_service = "${var.backend_service}"
  name            = "${var.url_map_name}"

  #host_rule {
  #  hosts        = ["my-service.jp"]
  #  path_matcher = "path-matcher-1"
  #}

  #path_matcher {
  #  default_service = "${var.backend_service}"
  #  name            = "path-matcher-1"
  #}

  dynamic "host_rule" {
    for_each = var.host_rules
    content {
      description  = "Host rule for ${host_rule.value.hosts}"
      hosts         = [host_rule.value.hosts]
      path_matcher = host_rule.value.path_matcher
    }
  }

}
