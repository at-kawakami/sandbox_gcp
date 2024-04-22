variable "project" {

}

variable "bucket" {

}

# ToDo
variable "security_policy" {

}

# ToDo
variable "ip_adderss" {

}

# ToDo
variable "zone" {

}

# ToDo
variable "network" {

}

# ToDo
variable "subnetwork" {

}

# ToDo
variable "instance" {

}
provider "google" {
  project = var.project
  region = "asia-northeast1"
}

terraform{
  backend "gcs" {
    bucket = var.bucket
    prefix  = "hogeo-service.jp"
  }
}

module "ComputeBackendService" {
  source = "../../modules/ComputeBackendService"
  health_check = module.ComputeHealthCheck.health_check
  network_endpoint_group = module.ComputeNetworkEndpointGroup.network_endpoint_group
  security_policy = var.security_policy
}

module "ComputeForwardingRule" {
  source = "../../ComputeForwardingRule"
  target_https_proxy = module.ComputeTargetHTTPSProxy.target_https_proxy
  forwarding_rule_name = "my-service-forwarding-rule"
  ip_address = var.ip_address
}

module "ComputeHealthCheck" {
  source = "../../ComputeHealthCheck"
  health_check_name = "my-service"
  health_path = "healthcheck"
}

module "ComputeNetworkEndpointGroup" {
  source = "../../ComputeNetworkEndpointGroup"
  zone = var.zone
  network = var.network
  subnetwork = var.subnetwork
  ip_address = var.ip_address
  instance =  var.instance
}

module "ComputeTargetHTTPProxy" {
  source = "../../ComputeTargetHTTPProxy"
}

module "ComputeTargetHTTPSProxy" {
  source = "../../ComputeTargetHTTPSProxy"
  url_map_id = module.ComputeURLMap.url_map_id
  target_https_proxy_name = "hogeo-service-jp"
}

module "ComputeURLMap" {
  source = "../../ComputeURLMap"
  url_map_name = "hogeo-service-jp"
  backend_service = module.ComputeBackendService.google_compute_backend_service

}
