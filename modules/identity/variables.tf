variable "environment" {
  type        = string
  description = "Deployment environment name (e.g. dev, prod)"
}

variable "project_name" {
  type        = string
  description = "Project name prefix"
}

variable "secret_name" {
  type        = string
  description = "Name identifier for the initial landing zone secret"
  default     = "app-credentials"
}