variable "create_oidc_provider" {
  description = "Should create or not the OIDC provider."
  type        = bool
  default     = true
}

variable "oidc_provider_arn" {
  description = "If you already have an OIDC provider, you can specify the ARN here. (create_oidc_provider) must be set to false."
  type        = string
  default     = ""
}

variable "github_thumbprints" {
  description = "GitHub OpenID TLS certificate thumbprints."
  type        = list(string)
  default     = ["6938fd4d98bab03faadb97b34396831e3780aea1", "1c58a3a8518e8759bf075b76b750d4f2df264fcd"]
}

variable "repositories" {
  description = "List of GitHub organization/repository names authorized to assume the role."
  type        = list(string)
  default     = []

  validation {
    condition = length([
      for repo in var.repositories : 1
      if length(regexall("^[A-Za-z0-9_.-]+?/([A-Za-z0-9_.:/-]+|\\*)$", repo)) > 0
    ]) == length(var.repositories)
    error_message = "Repositories must be specified in the organization/repository format."
  }
}

variable "max_session_duration" {
  description = "Maximum session duration in seconds."
  type        = number
  default     = 3600

  validation {
    condition     = var.max_session_duration >= 3600 && var.max_session_duration <= 43200
    error_message = "Maximum session duration should be between 3600 and 43200 seconds."
  }
}

variable "oidc_role_policies_arns" {
  description = "Policy ARNs to be attached to the role."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to be applied to resources."
  type        = map(string)
  default     = {}
}

variable "role_name" {
  description = "Name of the GitHub Actions OIDC role."
  type        = string
  default     = "github-actions-oidc-role"
}