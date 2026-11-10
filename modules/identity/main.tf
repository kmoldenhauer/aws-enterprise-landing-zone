# ------------------------------------------------------------------------------
# 1. AWS KMS Customer Managed Key (CMK) for Envelope Encryption
# ------------------------------------------------------------------------------
resource "aws_kms_key" "vault_key" {
  description             = "KMS Key for ${var.project_name}-${var.environment} landing zone secrets"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  tags = {
    Name = "${var.project_name}-${var.environment}-kms-vault"
    Tier = "Security-Governance"
  }
}

resource "aws_kms_alias" "vault_key_alias" {
  name          = "alias/${var.project_name}-${var.environment}-vault-key"
  target_key_id = aws_kms_key.vault_key.key_id
}

# ------------------------------------------------------------------------------
# 2. AWS Secrets Manager Secret (Protected by the KMS Key)
# ------------------------------------------------------------------------------
resource "aws_secretsmanager_secret" "workload_secret" {
  name                    = "${var.project_name}-${var.environment}-${var.secret_name}"
  description             = "Centralized secret store for workload applications"
  kms_key_id              = aws_kms_key.vault_key.arn
  recovery_window_in_days = 7

  tags = {
    Name = "${var.project_name}-${var.environment}-secret-vault"
    Tier = "Identity-Secrets"
  }
}