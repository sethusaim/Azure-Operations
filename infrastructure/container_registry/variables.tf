variable "my_acr_name" {
  default = "scaniaACR"
  type    = string
}

variable "my_acr_sku" {
  default = "Standard"
  type    = string
}

variable "my_acr_admin_enabled" {
  default = true
  type    = bool
}
