# ECS cluster on AWS using Terraform

This project sets up an AWS infrastructure including a VPC with public and private subnets, an ECS cluster, and associated resources for running containerized applications.


### Estimated monthly cost

```
Project: terraform_aws_ecs

 Name                                       Monthly Qty  Unit                    Monthly Cost

 aws_nat_gateway.main
 ├─ NAT gateway                                     730  hours                         $32.85
 └─ Data processed                    Monthly cost depends on usage: $0.045 per GB

 aws_lb.main
 ├─ Application load balancer                       730  hours                         $16.43
 └─ Load balancer capacity units      Monthly cost depends on usage: $5.84 per LCU

 aws_kms_key.ecr_key
 ├─ Customer master key                               1  months                         $1.00
 ├─ Requests                          Monthly cost depends on usage: $0.03 per 10k requests
 ├─ ECC GenerateDataKeyPair requests  Monthly cost depends on usage: $0.10 per 10k requests
 └─ RSA GenerateDataKeyPair requests  Monthly cost depends on usage: $0.10 per 10k requests

 aws_kms_key.flow_logs
 ├─ Customer master key                               1  months                         $1.00
 ├─ Requests                          Monthly cost depends on usage: $0.03 per 10k requests
 ├─ ECC GenerateDataKeyPair requests  Monthly cost depends on usage: $0.10 per 10k requests
 └─ RSA GenerateDataKeyPair requests  Monthly cost depends on usage: $0.10 per 10k requests

 aws_cloudwatch_log_group.flow_logs
 ├─ Data ingested                     Monthly cost depends on usage: $0.50 per GB
 ├─ Archival Storage                  Monthly cost depends on usage: $0.03 per GB
 └─ Insights queries data scanned     Monthly cost depends on usage: $0.005 per GB

 aws_ecr_repository.repository
 └─ Storage                           Monthly cost depends on usage: $0.10 per GB

 OVERALL TOTAL                                                                        $51.28

*Usage costs can be estimated by updating Infracost Cloud settings, see docs for other options.

──────────────────────────────────
41 cloud resources were detected:
∙ 6 were estimated
∙ 35 were free

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━┓
┃ Project                                            ┃ Baseline cost ┃ Usage cost* ┃ Total cost ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━╋━━━━━━━━━━━━┫
┃ main                                               ┃           $51 ┃           - ┃        $51 ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━┛
```