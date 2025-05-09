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