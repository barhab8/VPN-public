variable "prefix" {
  type        = string
  description = "Prefix for resources"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_address_prefixes" {
  type    = list(string)
  default = ["10.0.1.0/24"]
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "control_plane_ip" {
  type        = string
  description = "Public IP of the control plane VM, used to restrict metrics scraping access"
  default     = "<CONTROL_PLANE_IP>"
}
