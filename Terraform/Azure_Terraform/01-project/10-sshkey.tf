# Create (and display) an SSH key
resource "tls_private_key" "my-SSH-key" {
  algorithm = "RSA"
  rsa_bits = 4096
}

output "tls_private_key" {
  value = tls_private_key.my-SSH-key
  sensitive = true
}