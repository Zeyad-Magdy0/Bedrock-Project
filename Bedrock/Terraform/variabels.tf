variable "region" {
  type    = string
}

variable  "az"  {
  type    = string
}

variable "key_name" {
  type        =  string
}

variable "node_name"{
  type = map
  default = {
      "master"  = "control_plane"
      "worker1" = "workers"
      "worker2" = "workers"
  }
}

variable "instance_type" {
  type = string
}
 
variable "vpc_cidr" {
  type    = string
}

variable "public_subnet_cidr" {
  type    = string
}

variable "private_subnet_cidr" {
  type    = string
}
