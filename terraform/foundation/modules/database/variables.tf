variable "prefix" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "admin_username" {
  type    = string
  default = "vpnadmin"
}

variable "tags" {
  type = map(string)
}
