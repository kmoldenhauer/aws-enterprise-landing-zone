variable "environment" {
  type        = string
  description = "Environment name (e.g. dev, prod)"
}

variable "project_name" {
  type        = string
  description = "Project prefix for resource naming"
}

variable "hub_cidr" {
  type        = string
  description = "CIDR block for the Hub VPC"
  default     = "10.0.0.0/16"
}

variable "spoke_cidr" {
  type        = string
  description = "CIDR block for the Workload Spoke VPC"
  default     = "10.1.0.0/16"
}

variable "hub_public_subnet_cidr" {
  type        = string
  description = "CIDR block for the Hub public/egress subnet"
  default     = "10.0.1.0/24"
}

variable "spoke_workload_subnet_cidr" {
  type        = string
  description = "CIDR block for the Spoke workload subnet"
  default     = "10.1.1.0/24"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone for subnet placement"
  default     = "us-east-1a"
}