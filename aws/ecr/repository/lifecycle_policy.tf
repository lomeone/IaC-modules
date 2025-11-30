resource "aws_ecr_lifecycle_policy" "main" {
  count      = length(var.lifecycle_policies) > 0 ? 1 : 0
  repository = aws_ecr_repository.main.name

  policy = <<EOF
{
  "rules": ${
  jsonencode([
    for priority, rule in var.lifecycle_policies : {
      "rulePriority" : priority,
      "description" : rule.description,
      "selection" : rule.selection,
      "action" : rule.action
    }
  ])
}
}
EOF
}
