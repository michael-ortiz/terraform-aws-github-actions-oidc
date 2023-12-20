output "oidc_provider_arn" {
  description = "OIDC provider ARN"
  value       = try(aws_iam_openid_connect_provider.provider[0].arn)
}

output "oidc_role_arn" {
  description = "GitHub Actions OIDC role ARN"
  value       = aws_iam_role.github_actions_role.arn
}