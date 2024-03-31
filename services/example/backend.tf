terraform {
  required_version = ">= 1.3.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.63.0"
    }
    template = "~> 2.0"
  }
}

provider "aws" {
  region = "ap-northeast-1"
  #profile = "default"
  default_tags {
    tags = {
      System      = var.resource_prefix
      Name        = "Provider Tag"
    }
  }
}
