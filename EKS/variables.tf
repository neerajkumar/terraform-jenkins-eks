variable "region" {
  description = "The region of your EKS cluster"
  type        = string
}

variable "instance_type" {
  description = "The instance type of EC2 server"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "private_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}

variable "public_subnets" {
  description = "Subnets CIDR"
  type        = list(string)
}
