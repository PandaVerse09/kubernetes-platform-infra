# Kubernetes Platform Infrastructure (IaC)

Reproducible Infrastructure as Code (IaC) powered by Terraform for AWS EKS, VPC, and ECR.

## Architecture
- **VPC Module:** Multi-AZ deployment (2 Public subnets, 2 Private subnets, Internet Gateway, NAT Gateway).
- **ECR Module:** Private container repository with automated CVE scan-on-push and lifecycle cleanup policy.
- **EKS Module:** Managed Kubernetes control plane (v1.30) with managed Linux worker node group and OIDC provider for IRSA.

## Directory Structure
```
├── modules/
│   ├── vpc/             # VPC, subnets, route tables, NAT GW
│   ├── ecr/             # Private container registry
│   └── eks/             # EKS cluster, node groups, IAM, OIDC
└── environments/
    └── aws/             # Root live deployment configuration
        ├── main.tf
        ├── variables.tf
        ├── outputs.tf
        └── terraform.tfvars.example
```

## Provisioning Workflow

### 1. Configure AWS CLI
```bash
aws configure
```

### 2. Initialize and Validate
```bash
cd environments/aws
terraform init
terraform fmt -check
terraform validate
```

### 3. Review Plan and Apply
```bash
terraform plan -out=tfplan
terraform apply tfplan
```

### 4. Connect kubectl to EKS
```bash
aws eks --region us-east-1 update-kubeconfig --name k8s-platform-eks
kubectl get nodes
```

### 5. Tear Down / Destroy (Cost Control)
```bash
terraform destroy -auto-approve
```
