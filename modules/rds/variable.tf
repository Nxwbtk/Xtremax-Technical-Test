variable "vpc_id" {
  type = string
}

variable "allowed_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks to allow access to the RDS instance"

}

variable "subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the RDS instance"
}
