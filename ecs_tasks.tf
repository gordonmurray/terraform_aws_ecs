resource "aws_ecs_task_definition" "main" {
  family                   = "my-task"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "1024" # 1 vCPU
  memory                   = "2048" # 2 GB
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "triton"
      image     = "${aws_ecr_repository.repository.repository_url}:24_06"
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        },
        {
          containerPort = 8001
          hostPort      = 8001
        },
        {
          containerPort = 8002
          hostPort      = 8002
        }
      ]
      environment = [
        {
          name  = "CUDA_VISIBLE_DEVICES"
          value = "0"
        }
      ]
      mountPoints = [
        {
          sourceVolume  = "models"
          containerPath = "/models"
        },
        {
          sourceVolume  = "model_cache"
          containerPath = "/model_cache"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
          "awslogs-region"        = "${var.region}"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

  volume {
    name      = "models"
    host_path = "models/models"
  }

  volume {
    name      = "model_cache"
    host_path = "models/model_cache"
  }
}


resource "aws_ecs_task_definition" "nginx" {
  family                   = "nginx"
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  cpu                      = "1024" # 1 vCPU
  memory                   = "2048" # 2 GB
  execution_role_arn       = aws_iam_role.ecs_task_execution.arn
  task_role_arn            = aws_iam_role.ecs_task_execution.arn

  container_definitions = jsonencode([
    {
      name      = "nginx"
      image     = "${aws_ecr_repository.repository.repository_url}:latest"
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 8080
        },
        {
          containerPort = 443
          hostPort      = 4443
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
          "awslogs-region"        = "${var.region}"
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])

}
