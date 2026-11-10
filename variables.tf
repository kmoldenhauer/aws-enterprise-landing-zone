variable "aws_region" {
  type        = string
  description = "The AWS region where resources will be deployed"
  default     = "us-east-1"
}

variable "environment" {
  type        = string
  description = "Deployment environment name (e.g., dev, staging, prod)"
  default     = "dev"
}

variable "project_name" {
  type        = string
  description = "Project name prefix used for resource naming"
  default     = "alz"
}