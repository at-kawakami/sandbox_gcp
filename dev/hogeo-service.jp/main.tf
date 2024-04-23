locals {
  zone = "asia-northeast1-a"
}

# ToDo
variable "ip_address" {

}

# ToDo
variable "network" {

}

# ToDo
variable "subnetwork" {

}
provider "google" {
  project = "TBA"
  region  = "asia-northeast1"
}

terraform {
  backend "gcs" {
    bucket = "TBA"
    prefix = "hogeo-service.jp"
  }
}

# Todo: 複数バックエンドの時用になってない
module "ComputeBackendService" {
  source                 = "../../modules/ComputeBackendService"
  health_check           = module.ComputeHealthCheck.health_check
  network_endpoint_group = module.ComputeNetworkEndpointGroup.network_endpoint_group
  security_policy        = module.ComputeSecurityPolicy.security_policy
}

module "ComputeInstance" {
  source               = "../../modules/ComputeInstance"
  zone = local.zone
}

module "ComputeForwardingRule" {
  source               = "../../modules/ComputeForwardingRule"
  target_https_proxy   = module.ComputeTargetHTTPSProxy.target_https_proxy
  forwarding_rule_name = "my-service-forwarding-rule"
  ip_address           = var.ip_address
}

module "ComputeHealthCheck" {
  source            = "../../modules/ComputeHealthCheck"
  health_check_name = "my-service"
  health_path       = "healthcheck"
}

module "ComputeNetworkEndpointGroup" {
  source     = "../../modules/ComputeNetworkEndpointGroup"
  zone       = local.zone
  network    = var.network
  subnetwork = var.subnetwork
  ip_address = var.ip_address
  instance   = module.ComputeInstance.compute_instance_default
}

module "ComputeTargetHTTPSProxy" {
  source                  = "../../modules/ComputeTargetHTTPSProxy"
  url_map_id              = module.ComputeURLMap.url_map_id
  target_https_proxy_name = "hogeo-service-jp"
}

module "ComputeURLMap" {
  source          = "../../modules/ComputeURLMap"
  url_map_name    = "hogeo-service-jp"
  backend_service = module.ComputeBackendService.google_compute_backend_service

}
module "ComputeSecurityPolicy" {
  source = "../../modules/ComputeSecurityPolicy"
  security_policy_name = "defaul-allow-from-vpn"
}
