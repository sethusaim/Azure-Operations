variable "scania_resource_group_name" {
  type    = string
  default = "scania"
}

variable "scania_storage_container_name" {
  type    = string
  default = "scania-io-files"
}

variable "scania_container_access_type" {
  type    = string
  default = "private"
}

variable "scania_location" {
  type    = string
  default = "westus"
}

variable "scania_storage_account_name" {
  type    = string
  default = "scaniaaccount"
}

variable "scania_account_tier" {
  type    = string
  default = "Standard"
}

variable "scania_account_replication_type" {
  type    = string
  default = "LRS"
}
