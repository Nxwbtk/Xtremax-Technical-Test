variable "aws_region" {
  description = "The AWS region to deploy the resources"
  type        = string
}

variable "vpc_cidr_pool" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "image_id" {
  description = "The AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
}

variable "instance_profile_name" {
  description = "The name of the instance profile"
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for ASG"
}

variable "public_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "private_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = string

}
