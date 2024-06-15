resource "aws_ecr_repository" "cfp_app" {
  provider = aws.usw2
  name     = "cfp-app"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "cfp_app" {
  provider   = aws.usw2
  repository = aws_ecr_repository.cfp_app.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Expire old images",
        selection = {
          tagStatus   = "any",
          countType   = "imageCountMoreThan",
          countNumber = 10
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}
