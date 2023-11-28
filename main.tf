# This is used to create a multi-node swarm setup in AWS environment

locals {
  env            = "${var.app}-${terraform.workspace}"
  swarm_nw_ports = [2377, 7946, 4789]

  # For prod, we have to create a dynamic map that can deploy managers and workers in different subnets or AZs
  # For dev, only 1 manager node and 2 worker nodes 
  # if list with 3 subnet IDs come, slice it get first 2 subnetIDs to deploy our worker nodes to, else keep it same
  subnets_dev = slice(module.module-vpc-3tier.private_subnet_ids, 0, 2)
}

# first we will create vpc setup with the help of our custom module

module "module-vpc-3tier" {
  source  = "app.terraform.io/harry-workspace/module-vpc-3tier/aws"
  version = "1.5.1"
  # insert required variables here
  access_key                 = var.access_key
  secret_key                 = var.secret_key
  app                        = var.app
  number_of_subnets_required = var.number_of_subnets_required
  REGION                     = var.REGION
}

# Public key imported from user
# Import public key in AWS as a keypair
resource "aws_key_pair" "keypair" {
  public_key = var.public_key_content
}

