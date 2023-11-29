# Create EC2 instances for swarm multi node setup Manager and bastion host

# Swarm manager
resource "aws_instance" "swarm-manager" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.ec2_instance_type
  count           = 1
  subnet_id       = module.module-vpc-3tier.private_subnet_ids[0]
  security_groups = [aws_security_group.swarm-sg.id]
  key_name = aws_key_pair.keypair.key_name
  user_data = file("${path.module}/user-data.sh")

  tags = {
    Name = "${var.app}-manager-${terraform.workspace}"
    env  = local.env
  }
}

# Bastion host EC2 instance; Also acts as ansible controller
resource "aws_instance" "bastion-host" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type
  subnet_id     = module.module-vpc-3tier.public_subnet_ids[0]
  user_data = file("${path.module}/user-data-ansible.sh")
  security_groups = [aws_security_group.bastion-sg.id]
  key_name = aws_key_pair.keypair.key_name

  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = var.private_key
    host     = self.public_ip
  }

  provisioner "file" {
    source = "${path.module}/${local_file.inventory.filename}"
    destination = "/home/ubuntu/${local_file.inventory.filename}"
  }

  provisioner "file" {
    content = var.private_key
    destination = "/home/ubuntu/swarm-key.pem"
  }

  provisioner "file" {
    content = file("${path.module}/${local_file.swarm-playbook.filename}")
    destination = "/home/ubuntu/${local_file.swarm-playbook.filename}"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/swarm-key.pem",
      "export ANSIBLE_HOST_KEY_CHECKING=False",
      # "ansible-playbook -i /home/ubuntu/${local_file.inventory.filename} --private-key /home/ubuntu/swarm-key.pem /home/ubuntu/${local_file.swarm-playbook.filename}"
    ]
  }

  tags = {
    Name = "${var.app}-bastion-host-${terraform.workspace}"
    env  = local.env
  }

}