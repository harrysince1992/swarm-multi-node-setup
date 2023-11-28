# This is used to create a multi-node swarm setup in AWS environment

locals {
  env = "${var.app}-${terraform.workspace}"
  env_nodes_map = {
    dev : { num_of_workers : 3, num_of_managers : 1 },
    prod : { num_of_workers : 4, num_of_managers : 3 }
  }
}

# first we will create vpc setup with the help of our custom module

module "module-vpc-3tier" {
  source  = "app.terraform.io/harry-workspace/module-vpc-3tier/aws"
  version = "1.4.0"
  # insert required variables here
  access_key                 = var.access_key
  secret_key                 = var.secret_key
  app                        = var.app
  number_of_subnets_required = var.number_of_subnets_required
  REGION                     = var.REGION
}

