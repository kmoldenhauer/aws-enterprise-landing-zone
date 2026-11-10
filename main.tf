# ------------------------------------------------------------------------------
# 1. Foundational Networking Module (Hub-and-Spoke VPCs & Peering)
# ------------------------------------------------------------------------------
module "networking" {
  source = "./modules/networking"

  environment  = var.environment
  project_name = var.project_name
}

# ------------------------------------------------------------------------------
# 2. Layer 4 Perimeter Security Module (Security Groups & Inbound Rules)
# ------------------------------------------------------------------------------
module "security" {
  source = "./modules/security"

  environment         = var.environment
  project_name        = var.project_name
  vpc_id              = module.networking.spoke_vpc_id
  allowed_cidr_blocks = [module.networking.hub_cidr]
}

# ------------------------------------------------------------------------------
# 3. Identity & Secrets Governance Module (KMS CMK & Secrets Manager)
# ------------------------------------------------------------------------------
module "identity" {
  source = "./modules/identity"

  environment  = var.environment
  project_name = var.project_name
}