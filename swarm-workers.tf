# Create EC2 instances for swarm multi node setup

# resource "aws_instance" "ec2" {

#   for_each      = local.env_nodes_map
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = var.ec2_instance_type

#   tags = {
#     Name = "${var.app}-swarm-worker-${terraform.workspace}"
#     env  = local.env
#   }

# }