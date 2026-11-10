# AWS Enterprise Landing Zone (Terraform)

A modular, enterprise-grade AWS Landing Zone built with **Terraform** following the **AWS Well-Architected Framework**, **Cloud Adoption Framework (CAF)** standards, and **Zero Trust** security principles.

---

## 🏛️ Architecture Overview

The landing zone implements a dual-VPC **Hub-and-Spoke** network topology connected via bidirectional **VPC Peering**, fortified with Layer 4 perimeter security and centralized envelope encryption for secrets management.

```text
+-----------------------------------------------------------------------------------+
|                                     AWS CLOUD                                     |
|                                                                                   |
|  +-----------------------------------+     +-----------------------------------+  |
|  |             HUB VPC               |     |            SPOKE VPC              |  |
|  |          (10.0.0.0/16)            |     |          (10.1.0.0/16)            |  |
|  |                                   |     |                                   |  |
|  |  +-----------------------------+  |     |  +-----------------------------+  |  |
|  |  |      Public Subnet          |  |     |  |   Workload Private Subnet   |  |  |
|  |  |       (10.0.1.0/24)         |  |     |  |        (10.1.1.0/24)        |  |  |
|  |  |                             |  |     |  |                             |  |  |
|  |  |  [Internet Gateway (IGW)]   |  |     |  |  [Security Group: Port 443] |  |  |
|  |  +--------------+--------------+  |     |  +--------------^--------------+  |  |
|  +-----------------|-----------------+     +-----------------|-----------------+  |
|                    |                                         |                    |
|                    +===========[ VPC Peering ]===============+                    |
|                               (Bidirectional)                                     |
|                                                                                   |
|  +-----------------------------------------------------------------------------+  |
|  |                      IDENTITY & SECRETS GOVERNANCE                          |  |
|  |                                                                             |  |
|  |   [AWS KMS Customer Managed Key] --------> [AWS Secrets Manager Vault]      |  |
|  |      (Automatic Key Rotation)                   (App Credentials)           |  |
|  +-----------------------------------------------------------------------------+  |
+-----------------------------------------------------------------------------------+

```

Key Architectural Pillars

1. **Network Segregation (Hub-and-Spoke):**
   - **Hub VPC (10.0.0.0/16)**: Central management point hosting public ingress/egress via an Internet Gateway.
   - **Spoke VPC (10.1.0.0/16)**: Isolated private workload network with no direct route to the public internet.
   - **VPC Peering**: Non-overlapping CIDR routing facilitating secure, private communication between Hub and Spoke.
2. **Layer 4 Perimeter Security:**
   - Security Group enforces **Zero Trust** by restricting inbound ingress strictly to **HTTPS (Port 443)** originating only from the Hub VPC CIDR.
3. **Identity & Secrets Governance:**
   - Centralized **AWS Secrets Manager** protected by an **AWS KMS Customer Managed Key (CMK)** with automatic annual key rotation and recovery grace periods enabled.
4. **Environment Decoupling:**
   - Configurable environment profiles (`environments/dev.tfvars`) decouple operational configurations from reusable module logic.

---

📁 Repository Structure

```
aws-enterprise-landing-zone/
├── .gitignore
├── LICENSE
├── README.md
├── main.tf                    # Root orchestration wiring child modules
├── variables.tf               # Global input variable definitions
├── outputs.tf                 # Root output exports for downstream consumers
├── providers.tf               # Terraform core and AWS provider configuration
├── environments/
│   └── dev.tfvars             # Environment-specific configuration (Development)
└── modules/
    ├── networking/            # Hub VPC, Spoke VPC, Subnets, IGW, Peering, Routes
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security/              # Security groups restricting inbound HTTPS (443)
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── identity/              # KMS CMK envelope encryption & Secrets Manager
        ├── main.tf
        ├── variables.tf
        └── outputs.tf

```
