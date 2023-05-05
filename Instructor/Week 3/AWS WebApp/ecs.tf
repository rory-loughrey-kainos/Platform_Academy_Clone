# create the ecs cluster
resource "aws_ecs_cluster" "ecs_cluster" {
    name = "bradt-clsuter"

    setting {
        name = "containerInsights"
        value = "enabled"
    }
}
