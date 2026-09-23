output "aws_region" {
  value       = var.aws_region
  description = "AWS region deployed to"
}

output "eks_cluster_name" {
  value       = module.eks.cluster_name
  description = "EKS Cluster identifier"
}

output "eks_cluster_endpoint" {
  value       = module.eks.cluster_endpoint
  description = "EKS API server endpoint"
}

output "ecr_repository_url" {
  value       = module.ecr.repository_url
  description = "ECR repository URL for publishing images"
}

output "configure_kubectl_command" {
  value       = "aws eks --region ${var.aws_region} update-kubeconfig --name ${module.eks.cluster_name}"
  description = "Command to configure kubectl credentials for the newly created EKS cluster"
}
