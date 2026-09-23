variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "AWS deployment region"
}

variable "cluster_name" {
  type        = string
  default     = "k8s-platform-eks"
  description = "Name of the EKS cluster"
}

variable "environment" {
  type        = string
  default     = "production"
  description = "Environment identifier"
}
