output "repository_url" {
  value       = aws_ecr_repository.app.repository_url
  description = "The URL of the repository"
}

output "repository_arn" {
  value       = aws_ecr_repository.app.arn
  description = "The ARN of the repository"
}
