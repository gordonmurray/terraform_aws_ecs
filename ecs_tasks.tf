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
          "awslogs-group"         = "/ecs/triton"
          "awslogs-region"        = "us-west-2"
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
