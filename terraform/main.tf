terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-2"
}

# Create a VPC
resource "aws_vpc" "cloud_challenge_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create S3 bucket
resource "aws_s3_bucket" "cloud_challenge_s3_bucket" {
  bucket = "chrissayon-cloud-resume"
  acl    = "private"

  tags = {
        Name = "Cloud Resume"
  }
}

# Create DynamoDB Table
resource "aws_dynamodb_table" "cloud_challenge_table" {
  name           = "CloudChallengeTable"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "UserId"

  attribute {
    name = "UserId"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = false
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}