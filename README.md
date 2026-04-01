# Terraform Three-Tier Architecture on AWS

A production-ready three-tier architecture on AWS using Terraform for infrastructure as code. This infrastructure will be modified as need be.

## Architecture Overview

This project deploys a three-tier architecture in the `us-east-1` region consisting of:

- **Web Tier** — Public subnets across 2 AZs with a Bastion host and Web server
- **Application Tier** — Private subnets across 2 AZs with an App server
- **Database Tier** — Private subnets across 2 AZs with a DB server

### Resources Created

| Resource | Details |
|---|---|
| VPC | `10.0.0.0/16` |
| Public Subnets | `10.0.1.0/24` (us-east-1a), `10.0.2.0/24` (us-east-1b) |
| App Private Subnets | `10.0.11.0/24` (us-east-1a), `10.0.12.0/24` (us-east-1b) |
| DB Private Subnets | `10.0.21.0/24` (us-east-1a), `10.0.22.0/24` (us-east-1b) |
| Internet Gateway | For public subnet internet access |
| NAT Gateway | For private subnet outbound internet access |
| Security Groups | Web-SG, App-SG, DB-SG with tier-specific rules |
| EC2 Instances | Bastion, Web-VM, App-VM, DB-VM (all `t3.micro`, Ubuntu 22.04) |

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/install) >= 1.0
- AWS CLI configured with valid credentials (`aws configure`)
- An existing EC2 key pair in the `us-east-1` region

## Usage

### 1. Clone the repository

```bash
git clone https://github.com/<your-username>/terraform-three-tier-architecture.git
cd terraform-three-tier-architecture
```

### 2. Configure variables

Create a `terraform.tfvars` file:

```hcl
key_name = "your-ec2-keypair-name"
```

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Review the execution plan

```bash
terraform plan
```

### 5. Apply the infrastructure

```bash
terraform apply
```

Type `yes` when prompted to confirm.

## Variables

| Name | Description | Type | Required |
|---|---|---|---|
| `key_name` | The SSH key pair name for EC2 instances | `string` | Yes |

## Outputs

| Name | Description |
|---|---|
| `Bastion_Server_ip` | Public IP of the Bastion host |
| `Web-VM_ip` | Public IP of the Web server |
| `App-VM_ip` | Private IP of the App server |
| `DB-VM_ip` | Private IP of the DB server |

## Connecting to Instances

SSH into the Bastion host, then hop to private instances:

```bash
# Connect to Bastion
ssh -i your-key.pem ubuntu@<Bastion_Server_ip>

# From Bastion, connect to App or DB instances
ssh -i your-key.pem ubuntu@<App-VM_ip>
ssh -i your-key.pem ubuntu@<DB-VM_ip>
```

## Cleanup

To destroy all resources:

```bash
terraform destroy
```

Type `yes` when prompted to confirm.

## Project Structure

```
.
├── main.tf          # Core infrastructure resources
├── variables.tf     # Input variable definitions
├── outputs.tf       # Output definitions
├── providers.tf     # Provider and version configuration
├── terraform.tfvars # Variable values (not committed)
└── README.md        # This file
```
