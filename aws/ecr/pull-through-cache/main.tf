resource "aws_ecr_pull_through_cache_rule" "main" {
  ecr_repository_prefix = var.pull_through_cache_rule.repository_prefix
  upstream_registry_url = var.pull_through_cache_rule.upstream_registry_url
  credential_arn        = var.secretsmanager_secret != null ? aws_secretsmanager_secret.main[0].arn : null
}

resource "aws_secretsmanager_secret" "main" {
  count = var.secretsmanager_secret != null ? 1 : 0

  name        = "ecr-pullthroughcache/${var.secretsmanager_secret.name}"
  description = var.secretsmanager_secret.description
}
