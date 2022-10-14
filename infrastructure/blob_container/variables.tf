variable "my_storage_account_name" {
  type    = string
  default = "mysa"
}

variable "my_account_tier" {
  type    = string
  default = "Standard"
}

variable "my_account_replication_type" {
  type    = string
  default = "LRS"
}

variable "my_storage_container_name" {
  type    = string
  default = "my-io-files"
}

variable "my_container_access_type" {
  type    = string
  default = "private"
}