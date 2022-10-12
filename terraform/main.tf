terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.27"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = local.region
}

locals {
  name   = "newvpc"
  region = "us-east-1"

}