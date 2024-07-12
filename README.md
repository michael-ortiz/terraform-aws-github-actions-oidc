# terraform-aws-github-actions-oidc

A simple module that creates a single OIDC Role to be assumed by GitHub Actions to have access to your AWS Account.

## Usage:

```
module "github-actions-oidc" {
  source  = "michael-ortiz/github-actions-oidc/aws"
  version = "~> 1.0"

  create_oidc_provider = true

  repositories            = ["Organization/RepositoryName"]
  oidc_role_policies_arns = ["YOUR_POLICY_ARN"]
}
```

## Resources

| Name | Type |
|------|------|
| [aws_iam_openid_connect_provider.provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_role.github_actions_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="create_oidc_provider"></a> [create\_oidc\_provider](#input\_create\_oidc\_provider) | Should create or not the OIDC provider. | `bool` | `true` | no |
| <a name="input_github_thumbprints"></a> [github\_thumbprint](#input\_github\_thumbprint) | GitHub OpenID TLS certificate thumbprints. | `list(string)` | `6938fd4d98bab03faadb97b34396831e3780aea1`, `1c58a3a8518e8759bf075b76b750d4f2df264fcd` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum session duration in seconds. | `number` | `3600` | no |
| <a name="oidc_role_policies_arns"></a> [oidc\_role\_policies\_arns](#input\_oidc\_role\_attach\_policies) | Policy ARNs to be attached to the role. | `list(string)` | `[]` | no |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | List of GitHub organization/repository names authorized to assume the role. | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to be applied to resources. | `map(string)` | `{}` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of the GitHub Actions OIDC role. | `string` | `github-actions-oidc-role` | no |


## Outputs

| Name | Description |
|------|-------------|
| <a name="output_oidc_provider_arn"></a> [oidc\_provider\_arn](#output\_oidc\_provider\_arn) | OIDC provider ARN |
| <a name="output_oidc_role"></a> [oidc\_role\_arn](#output\_oidc\_role) | GitHub Actions OIDC role ARN |
