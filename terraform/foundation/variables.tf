variable "prefix" {
  type        = string
  description = "Prefix for foundation resources"
  default     = "cloudvpn"
}

variable "location" {
  type        = string
  description = "Azure region for foundation resources"
  default     = "westeurope"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "control_plane_vm_size" {
  type    = string
  default = "Standard_B1s"
}

variable "admin_username" {
  type    = string
  default = "ubuntu"
}

variable "admin_ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "tags" {
  type = map(string)
  default = {
    Environment = "Dev"
    Project     = "CloudVPN"
  }
}

variable "db_admin_username" {
  type    = string
  default = "vpnadmin"
}
