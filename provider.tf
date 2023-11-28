terraform {
    required_providers {
      aws ={
        source = "hashicorp/aws"
      }
    }
}

provider "aws" {
    region = var.REGION
    access_key = var.access_key
    secret_key = var.secret_key
}