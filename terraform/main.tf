terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "ec2_jenkins" {
  source               = "./modules/ec2-jenkins-docker-nginx"
  name_prefix          = var.name_prefix
  key_name             = var.key_name
  instance_type        = var.instance_type
  allowed_ssh_cidr     = var.allowed_ssh_cidr
  allowed_jenkins_cidr = var.allowed_jenkins_cidr
  volume_size_gb       = var.volume_size_gb
}
