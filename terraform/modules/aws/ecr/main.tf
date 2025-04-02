resource "aws_ecr_repository" "repository" {
  name                 = "${var.project_name}-${var.name}"
  image_tag_mutability = "MUTABLE"
  force_delete         = true # Allow quick teardown*

  tags = {
    Name = "${var.project_name}-repository"
  }
}
