resource "aws_security_group" "workload" {
  name        = "${var.project_name}-${var.environment}-sg-workload"
  description = "Zero Trust perimeter security: allow inbound HTTPS strictly from Hub network"
  vpc_id      = var.vpc_id

  # Inbound Rule: Allow HTTPS (Port 443) ONLY from the Hub CIDR
  ingress {
    description = "Allow inbound HTTPS from Hub VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.allowed_cidr_blocks
  }

  # Outbound Rule: Allow all egress
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.environment}-sg-workload"
    Tier = "Security"
  }
}