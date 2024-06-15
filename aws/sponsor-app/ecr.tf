resource "aws_ecr_repository" "sponsor_app" {
  provider = aws.usw2
  name     = "sponsor-app"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_lifecycle_policy" "sponsor_app" {
  provider   = aws.usw2
  repository = aws_ecr_repository.sponsor_app.name

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
