
terraform {
  required_providers {
    bigip = {
      source  = "F5Networks/bigip"
      version = "~> 1.22"
    }
  }
}

provider "bigip" {
  address  = var.f5_address
  username = var.f5_username
  password = var.f5_password
}

