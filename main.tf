provider "aws" {
  region     = "us-east-1"
  
}

variable "subnet-cidr-block" {
   description = "subnet-cidr-block"
  
}

variable "vpc-cidr-block" {
  description = "vpc-cidr-block"
  
}

variable "environment" {
  description = "environment"
  
}
resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc-cidr-block
  tags = {
        Name = var.environment
       
    }

}

resource "aws_subnet" "dev-subnet" {
    cidr_block = var.subnet-cidr-block
    vpc_id = aws_vpc.development-vpc.id
    availability_zone = "us-east-1a"
    tags = {
        Name = "subnet-1-dev"
    }

}

output "dev_vpc_id" {
  value = aws_vpc.development-vpc.id
}

data "aws_vpc" "existing" {
  default = true
}

resource "aws_subnet" "dev-subnet2" {
    cidr_block = "172.31.96.0/20"
    vpc_id = data.aws_vpc.existing.id
    availability_zone = "us-east-1a"
    tags = {
        Name = "subnet-2-default"
    }



  
}