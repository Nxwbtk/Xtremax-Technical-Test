variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for ASG"

}

variable "ec2_sg_id" {
  type        = string
  description = "The ID of the EC2 security group"

}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"

}

variable "acm_certificate_arn" {
  description = "ACM certificate ARN for HTTPS listener"
  type        = string
}

