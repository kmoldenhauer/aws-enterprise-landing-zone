output "hub_vpc_id" {
  description = "The ID of the Hub VPC"
  value       = module.networking.hub_vpc_id
}

output "spoke_vpc_id" {
  description = "The ID of the Workload Spoke VPC"
  value       = module.networking.spoke_vpc_id
}

output "peering_connection_id" {
  description = "The ID of the VPC Peering connection"
  value       = module.networking.peering_connection_id
}

output "workload_security_group_id" {
  description = "The ID of the Spoke Workload Security Group"
  value       = module.security.security_group_id
}

output "kms_key_arn" {
  description = "The ARN of the centralized KMS Key"
  value       = module.identity.kms_key_arn
}

output "secrets_manager_secret_name" {
  description = "The name of the Secrets Manager secret"
  value       = module.identity.secret_name
}