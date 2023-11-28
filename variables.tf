variable "access_key" {
}

variable "secret_key" {
}

variable "app" {
}

variable "number_of_subnets_required" {
}

variable "REGION" {
}

variable "ec2_instance_type" {
  default = "t3.micro"
  validation {
    condition     = var.ec2_instance_type == "t3.micro" || var.ec2_instance_type == "t2.micro"
    error_message = "instance type can only be t3.micro or t2.micro"
  }
}

variable "public_key_content" {
  description = "public key that will be used to create keypair in AWS."
}

variable "private_key" {
  description = "private key required to connect to hosts through ansible"
}


 