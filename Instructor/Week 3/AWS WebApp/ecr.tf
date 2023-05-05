resource "aws_ecr_repository" "bradt-ecr-repo" {
  name = "bradt-ecr"
  tags = {
    Name = "bradt-ecr"

  }
}