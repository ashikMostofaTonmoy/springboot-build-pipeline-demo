resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "my-key-pair"
  public_key = tls_private_key.ssh_key.public_key_openssh
  tags       = local.common_tags
}

resource "local_file" "private_key" {
  content  = tls_private_key.ssh_key.private_key_pem
  filename = pathexpand("~/.ssh/my-key-pair.pem")
  # filename        = "my-key-pair.pem"
  file_permission = "0400"
  # file_permission = "0644"
}

output "private_key_path" {
  value       = local_file.private_key.filename
  description = "Path to the private key file"
}
