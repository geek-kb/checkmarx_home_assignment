variable "cluster_name" {
  type = string
  default = "checkmarx_home_assignment"
}

variable "subnet_ids" {
  type = list
  default = [ "subnet-c61f12be", "subnet-ad3ddfc4" ]
}
