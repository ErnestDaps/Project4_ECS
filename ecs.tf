resource "aws_ecs_cluster" "project4_ecs_cluster" {
  name = "project4-ECS-cluster"
}

resource "aws_ecr_repository" "worker" {
  name = "worker"
}

resource "aws_ecs_service" "project4_ECS_worker" {
  name            = "project4_ECS_worker"
  cluster         = aws_ecs_cluster.project4_ecs_cluster.id
  task_definition = aws_ecs_task_definition.project4_task_definition.arn
  desired_count   = 2
}

resource "aws_ecs_task_definition" "project4_task_definition" {
  family                = "worker"
  container_definitions = data.template_file.project4_task_definition_template.rendered
}


data "template_file" "project4_task_definition_template" {
  template = file("task_definition.json.tpl")
  vars = {
    REPOSITORY_URL = replace(aws_ecr_repository.worker.repository_url, "https://", "")
  }
}