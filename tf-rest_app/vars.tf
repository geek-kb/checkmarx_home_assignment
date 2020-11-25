variable "rest_app" {
  type = string
  default = "checkmarx-home-assignment-euc1-flask-app"
}

variable "namespace" {
  type = string
  default = "checkmarx-home-assignment-euc1"
}

variable "replicas" {
  type = number
  default = 1
}

variable "container_image" {
  type = string
  default = "329054710135.dkr.ecr.eu-central-1.amazonaws.com/checkmarx_assignment:latest"
}

variable "resources_requests" {
  type = list
  default = ["0.1", "80Mi"]
}

variable "resources_limits" {
  type = list
  default = ["0.3", "160Mi" ]
}

variable "liveness_probe_string" {
  type = string
  default = "/tracks"
}

variable "liveness_probe_port" {
  type = number
  default = 80
}

variable "service_port" {
  type = number
  default = 80
}

variable "service_name" {
  type = string
  default = "http"
}
