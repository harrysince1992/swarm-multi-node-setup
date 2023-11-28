# Create EC2 instances for swarm multi node setup Manager and bastion host

# resource "aws_instance" "ec2" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.ec2_instance_type

#   tags = {
#     Name = "${var.app}-swarm-manager-${terraform.workspace}"
#     env  = local.env
#   }

# }


# # Bastion host EC2 instance

# resource "aws_instance" "bastion-host" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.ec2_instance_type


#   tags = {
#     Name = "${var.app}-bastion-host-${terraform.workspace}"
#     env  = local.env
#   }

# }