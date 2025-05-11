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

variable "ec2_security_group_id" {
  type        = string
  description = "The ID of the EC2 security group allowed to access RDS"
}
