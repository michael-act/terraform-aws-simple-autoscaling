<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.26.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.26.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.scale_in](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.scale_out](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_metric_alarm.firing](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_cloudwatch_metric_alarm.relax](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_alarm_actions"></a> [additional\_alarm\_actions](#input\_additional\_alarm\_actions) | Additional Alarm Action to be Executed | `list(string)` | `[]` | no |
| <a name="input_autoscaling"></a> [autoscaling](#input\_autoscaling) | Auto Scaling Configuration | <pre>object({<br>    scale_in = optional(object({<br>      evaluation_periods = optional(number, 5)<br>      cooldown           = optional(number, 300)<br>      interval_period    = optional(number, 60)<br>    }), {})<br><br>    scale_out = optional(object({<br>      evaluation_periods = optional(number, 3)<br>      cooldown           = optional(number, 60)<br>      interval_period    = optional(number, 60)<br>    }), {})<br><br>    min_size          = optional(number, 1)<br>    max_size          = optional(number, 3)<br>  })</pre> | <pre>{<br>  "max_size": 3,<br>  "min_size": 1,<br>  "scale_in": {<br>    "cooldown": 300,<br>    "evaluation_period": 5,<br>    "interval_period": 60<br>  },<br>  "scale_out": {<br>    "cooldown": 60,<br>    "evaluation_period": 3,<br>    "interval_period": 60<br>  }<br>}</pre> | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of ECS Cluster Name | `string` | n/a | yes |
| <a name="input_metric"></a> [metric](#input\_metric) | Target Metric Configuration | <pre>object({<br>    name           = optional(string, "MemoryUtilization") # Available built-in metrics: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#ecs-metrics<br>    statistic_type = optional(string, "Average") # Available built-in statistic type: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Statistics-definitions.html<br>    target_high    = optional(number, 85)<br>    target_low     = optional(number, 30)<br>  })</pre> | <pre>{<br>  "name": "MemoryUtilization",<br>  "statistic_type": "Average",<br>  "target_high": 85,<br>  "target_low": 30<br>}</pre> | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Prefix of the resources (cloudwatch, autoscaling policy) name | `string` | `"ecs-service"` | no |
| <a name="input_service_name"></a> [service\_name](#input\_service\_name) | Name of ECS Service Name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags of Resources | `map(string)` | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->