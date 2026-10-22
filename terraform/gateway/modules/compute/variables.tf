variable "prefix" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B2s"
}

variable "admin_username" {
  type    = string
  default = "ubuntu"
}

variable "admin_ssh_public_key_path" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "zone" {
  type        = string
  description = "Azure Availability Zone (1, 2, or 3)"
  default     = "1"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "os_type" {
  type        = string
  description = "OS type for the gateway VM (ubuntu or debian)"
}
