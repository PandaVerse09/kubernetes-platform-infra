terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }

  # Hardening phase: Configure S3 backend for remote state
  # backend "s3" {
  #   bucket         = "pandaverse09-terraform-state"
  #   key            = "platform-lab/terraform.tfstate"
  #   region         = "us-east-1"
  #   dynamodb_table = "terraform-locks"
  # }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "KubernetesPlatformEngineeringLab"
      Environment = var.environment
      ManagedBy   = "Terraform"
      Owner       = "PandaVerse09"
    }
  }
}

# 1. VPC & Networking Module
module "vpc" {
  source       = "../../modules/vpc"
  cluster_name = var.cluster_name
}

# 2. Container Registry Module
module "ecr" {
  source          = "../../modules/ecr"
  repository_name = "kubernetes-platform-app"
}

# 3. EKS Managed Kubernetes Module
module "eks" {
  source         = "../../modules/eks"
  cluster_name   = var.cluster_name
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnet_ids
  desired_size   = 2
  min_size       = 1
  max_size       = 4
  instance_types = ["t3.medium"]

  depends_on = [module.vpc]
}
