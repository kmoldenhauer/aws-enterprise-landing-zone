output "security_group_id" {
  description = "The ID of the workload security group"
  value       = aws_security_group.workload.id
}