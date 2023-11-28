# Create EC2 instances for swarm multi node setup
# It depends on how many subnets you setup
resource "aws_instance" "worker" {

  count = 2
  ami             = data.aws_ami.ubuntu.id
  instance_type   = var.ec2_instance_type
  subnet_id       = local.subnets_dev[count.index]
  security_groups = [aws_security_group.swarm-sg.id]
  user_data = file("${path.module}/user-data.sh")
  tags = {
    Name = "${var.app}-worker-${count.index + 1}-${terraform.workspace}"
    env  = local.env
  }

}