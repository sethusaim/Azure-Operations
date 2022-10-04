resource "tls_private_key" "example_ssh" {
  algorithm = var.scania_tls_private_key_algorithm
  rsa_bits  = var.scania_tls_private_key_rsa_bits
}

resource "local_file" "linux_key" {
  filename = var.scania_private_key_file_name
  content  = tls_private_key.example_ssh.private_key_pem
}