
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  region                   = "us-east-1"
  #  profile                  = "default"
}

module "key_pair" {
  #source = "github.com/pshebel/programming-env/terraform/modules/key_pair"
  source = "/Users/phil/Projects/temple/programming-env/terraform/modules/key_pair"
  public_key = var.public_key
}

module "volume" {
  #source = "github.com/pshebel/programming-env/terraform/modules/volume"
  source = "/Users/phil/Projects/temple/programming-env/terraform/modules/volume"
}
