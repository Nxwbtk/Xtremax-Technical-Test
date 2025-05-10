variable "vpc_cidr_pool" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string

}

variable "private_cidr_block" {
  description = "The CIDR block for the private subnet"
  type        = string

}
