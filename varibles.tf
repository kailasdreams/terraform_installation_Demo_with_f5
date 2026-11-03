
variable "f5_address" {
  description = "F5 management IP address"
  type        = string
}

variable "f5_username" {
  type      = string
  sensitive = true
}

variable "f5_password" {
  type      = string
  sensitive = true
}

variable "vip_address" {
  default = "10.10.10.100"
}

variable "vip_name" {
  default = "terraform_https_vip"
}

