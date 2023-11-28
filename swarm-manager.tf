# Create EC2 instances for swarm multi node setup Manager and bastion host

# Swarm manager
resource "aws_instance" "swarm-manager" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.ec2_instance_type
  count           = 1
  subnet_id       = module.module-vpc-3tier.private_subnet_ids[0]
  security_groups = [aws_security_group.swarm-sg.id]
  user_data = file("${path.module}/user-data.sh")

  tags = {
    Name = "${var.app}-manager-${terraform.workspace}"
    env  = local.env
  }
}


# Bastion host EC2 instance
resource "aws_instance" "bastion-host" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type
  subnet_id     = module.module-vpc-3tier.public_subnet_ids[0]

  security_groups = [aws_security_group.bastion-sg.id]
  key_name = aws_key_pair.keypair.key_name

  tags = {
    Name = "${var.app}-bastion-host-${terraform.workspace}"
    env  = local.env
  }

}