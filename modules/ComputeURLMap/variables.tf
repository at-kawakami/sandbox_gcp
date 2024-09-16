variable "url_map_name" {
    type = string
}
variable "backend_service" {
    type = string
}
variable "host_rules" {
  type = list(object({
    hosts        = string
    path_matcher = string
  }))
}
