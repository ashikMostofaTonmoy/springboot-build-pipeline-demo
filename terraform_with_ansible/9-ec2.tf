data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical's AWS account ID

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd*/ubuntu-resolute-26.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Debug output to see available AMIs
output "ubuntu_ami_id" {
  value = data.aws_ami.ubuntu.id
}

output "ubuntu_ami_name" {
  value = data.aws_ami.ubuntu.name
}

resource "aws_instance" "web" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.vm_family
  key_name               = aws_key_pair.generated_key.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  subnet_id              = aws_subnet.public_zone1.id

  root_block_device {
    volume_size = var.disk_size
    volume_type = "gp3"
    encrypted   = true
  }

  tags = local.common_tags
}

# Create inventory file for Ansible
resource "local_file" "ansible_inventory" {
  content  = <<-EOF
    [ubuntu_servers]
    ubuntu_server ansible_host=${aws_instance.web.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/my-key-pair.pem
  EOF
  filename = "${path.module}/ansible/inventory.ini"
}

# Run Ansible playbook after instance is created
resource "null_resource" "ansible_provision" {
  depends_on = [
    aws_instance.web,
    local_file.private_key
  ]

  triggers = {
    instance_id = aws_instance.web.id
    public_ip   = aws_instance.web.public_ip
    timestamp   = timestamp()
  }

  # Wait for SSH to be available
  provisioner "local-exec" {
    working_dir = "${path.module}/ansible"
    command     = "ssh -o StrictHostKeyChecking=no -i ${local_file.private_key.filename} ubuntu@${aws_instance.web.public_ip} 'echo SSH is ready'"
  }

  # Run Ansible playbook
  provisioner "local-exec" {
    working_dir = "${path.module}/ansible"
    command     = "ansible-playbook -v --inventory ${aws_instance.web.public_ip}, --private-key ${local_file.private_key.filename} --user ubuntu install_docker.yml --force-handlers"
  }
}

output "public_ip" {
  value = aws_instance.web.public_ip
}

