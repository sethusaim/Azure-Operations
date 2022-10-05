resource "tls_private_key" "my_private_key" {
  algorithm = var.my_tls_private_key_algorithm
  rsa_bits  = var.my_tls_private_key_rsa_bits
}

resource "local_file" "linux_key" {
  filename = var.my_private_key_file_name
  content  = tls_private_key.my_private_key.private_key_pem
}