# Security groups for bastion host, swarm manager and worker nodes

resource "aws_security_group" "bastion-sg" {
  name   = "${var.app}-bastion-host-sg-${terraform.workspace}"
  vpc_id = module.module-vpc-3tier.vpc_id

  ingress {
    description = "SSH from everyone"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app}-bastion-host-sg-${terraform.workspace}"
  }
}

resource "aws_security_group" "swarm-sg" {
  vpc_id = module.module-vpc-3tier.vpc_id
  name   = "${var.app}-swarm-sg-${terraform.workspace}"
  dynamic "ingress" {
    for_each = local.swarm_nw_ports

    content {
      description = "allow swarm ports within n/w"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      self        = true
    }
  }

  ingress {
    description     = "allow ssh from bastion host"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion-sg.name]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app}-swarm-sg-${terraform.workspace}"
  }

}
