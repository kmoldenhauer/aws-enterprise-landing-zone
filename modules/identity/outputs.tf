output "kms_key_arn" {
  description = "The ARN of the KMS Customer Managed Key"
  value       = aws_kms_key.vault_key.arn
}

output "kms_key_id" {
  description = "The ID of the KMS Customer Managed Key"
  value       = aws_kms_key.vault_key.key_id
}

output "secret_arn" {
  description = "The ARN of the Secrets Manager secret"
  value       = aws_secretsmanager_secret.workload_secret.arn
}

output "secret_name" {
  description = "The name of the Secrets Manager secret"
  value       = aws_secretsmanager_secret.workload_secret.name
}