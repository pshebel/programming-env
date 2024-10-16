
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

module "programming" {
  source = "github.com/pshebel/progamming-env/terraform/modules/programming"

}