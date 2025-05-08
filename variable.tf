variable "aws_region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "ap-southeast-1" 
}

variable "vpc_cidr_block" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "vpc_cidr_pool" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "172.0.0.0/16"
}