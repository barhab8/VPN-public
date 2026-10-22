variable "region" {
  type        = string
  description = "Azure region for the VPN Gateway"
  default     = "westeurope"
}

variable "zone" {
  type        = string
  description = "Azure Availability Zone for the gateway VM (1, 2, or 3)"
  default     = "1"
}

variable "server_name" {
  type        = string
  description = "Name of the VPN Gateway instance"
  default     = "vpn-gw"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.1.0.0/16"]
}

variable "subnet_address_prefixes" {
  type    = list(string)
  default = ["10.1.1.0/24"]
}

variable "vm_size" {
  type    = string
  default = "Standard_B2ts_v2"
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

variable "control_plane_ip" {
  type        = string
  description = "Public IP of the control plane VM, used to restrict metrics scraping access"
  default     = "<CONTROL_PLANE_IP>"
}

variable "os_type" {
  type        = string
  description = "OS type for the gateway VM (ubuntu or debian)"
  default     = "debian"
  validation {
    condition     = contains(["ubuntu", "debian"], var.os_type)
    error_message = "The os_type must be either 'ubuntu' or 'debian'."
  }
}
