# ------------------------------------------------------------------------------
# 1. Hub VPC (Central Management / Egress)
# ------------------------------------------------------------------------------
resource "aws_vpc" "hub" {
  cidr_block           = var.hub_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc-hub"
    Role = "Hub-Network"
  }
}

resource "aws_internet_gateway" "hub" {
  vpc_id = aws_vpc.hub.id

  tags = {
    Name = "${var.project_name}-${var.environment}-igw-hub"
  }
}

resource "aws_subnet" "hub_public" {
  vpc_id            = aws_vpc.hub.id
  cidr_block        = var.hub_public_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.project_name}-${var.environment}-snet-hub-public"
    Tier = "Public"
  }
}

# ------------------------------------------------------------------------------
# 2. Spoke VPC (Isolated Workload Environment)
# ------------------------------------------------------------------------------
resource "aws_vpc" "spoke" {
  cidr_block           = var.spoke_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-${var.environment}-vpc-spoke"
    Role = "Workload-Spoke"
  }
}

resource "aws_subnet" "spoke_workload" {
  vpc_id            = aws_vpc.spoke.id
  cidr_block        = var.spoke_workload_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "${var.project_name}-${var.environment}-snet-spoke-workload"
    Tier = "Private-Workload"
  }
}

# ------------------------------------------------------------------------------
# 3. VPC Peering (Bidirectional Interconnect)
# ------------------------------------------------------------------------------
resource "aws_vpc_peering_connection" "hub_spoke" {
  vpc_id      = aws_vpc.hub.id
  peer_vpc_id = aws_vpc.spoke.id
  auto_accept = true

  tags = {
    Name = "${var.project_name}-${var.environment}-peer-hub-spoke"
  }
}

# ------------------------------------------------------------------------------
# 4. Routing Tables and Subnet Associations
# ------------------------------------------------------------------------------
# Hub Route Table: Internet access via IGW + Peering route to Spoke
resource "aws_route_table" "hub" {
  vpc_id = aws_vpc.hub.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hub.id
  }

  route {
    cidr_block                = var.spoke_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.hub_spoke.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-rt-hub"
  }
}

resource "aws_route_table_association" "hub_public" {
  subnet_id      = aws_subnet.hub_public.id
  route_table_id = aws_route_table.hub.id
}

# Spoke Route Table: Peering route back to Hub
resource "aws_route_table" "spoke" {
  vpc_id = aws_vpc.spoke.id

  route {
    cidr_block                = var.hub_cidr
    vpc_peering_connection_id = aws_vpc_peering_connection.hub_spoke.id
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-rt-spoke"
  }
}

resource "aws_route_table_association" "spoke_workload" {
  subnet_id      = aws_subnet.spoke_workload.id
  route_table_id = aws_route_table.spoke.id
}