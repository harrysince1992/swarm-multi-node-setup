# Create EC2 instances for swarm multi node setup
# It depends on how many subnets you setup
resource "aws_instance" "worker" {

  for_each      = local.subnets_dev
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.ec2_instance_type
  subnet_id     = each.value

  tags = {
    Name = "${var.app}-swarm-worker-${each.key}-${terraform.workspace}"
    env  = local.env
  }

}