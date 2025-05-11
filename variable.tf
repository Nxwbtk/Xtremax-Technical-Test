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

variable "db_name" {
  type        = string
  description = "The name of the database to create"

}

variable "db_username" {
  type        = string
  description = "The username for the database"

}

variable "db_password" {
  type        = string
  description = "The password for the database"
  sensitive   = true
}

variable "db_port" {
  type        = number
  description = "The port for the database"
  default     = 3306
}

variable "db_instance_class" {
  type        = string
  description = "The instance class for the RDS instance"
  default     = "db.t3.micro"

}

variable "db_identifier" {
  type        = string
  description = "The identifier for the RDS instance"
  default     = "mysql-school"
}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for HTTPS listener"
  type        = string
}
