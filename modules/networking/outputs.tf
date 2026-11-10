output "hub_vpc_id" {
  description = "The ID of the Hub VPC"
  value       = aws_vpc.hub.id
}

output "hub_cidr" {
  description = "The CIDR block of the Hub VPC"
  value       = aws_vpc.hub.cidr_block
}

output "spoke_vpc_id" {
  description = "The ID of the Spoke VPC"
  value       = aws_vpc.spoke.id
}

output "spoke_workload_subnet_id" {
  description = "The ID of the Spoke Workload Subnet"
  value       = aws_subnet.spoke_workload.id
}

output "peering_connection_id" {
  description = "The ID of the Hub-to-Spoke VPC Peering connection"
  value       = aws_vpc_peering_connection.hub_spoke.id
}