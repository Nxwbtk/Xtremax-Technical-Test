variable "image_id" {
  description = "The AMI ID to use for the instance"
  type        = string
  default     = "ami-022710250568671dc"
}

variable "instance_type" {
  description = "The type of instance to create"
  type        = string
  default     = "t2.micro"
}

variable "iam_instantce_profile" {
  description = "The IAM instance profile to attach to the instance"
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for ASG"
}


variable "vpc_id" {
  type        = string
  description = "The ID of the VPC"
}
variable "sg_alb_id" {
  type = string
}

variable "target_group_arn" {
  type        = string
  description = "The ARN of the target group"
}
