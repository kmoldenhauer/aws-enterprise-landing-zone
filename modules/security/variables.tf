variable "environment" {
  type        = string
  description = "Deployment environment name"
}

variable "project_name" {
  type        = string
  description = "Project name prefix"
}

variable "vpc_id" {
  type        = string
  description = "The ID of the VPC where the security group will be created (Spoke VPC)"
}

variable "allowed_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks allowed to access the workload (Hub VPC CIDR)"
}