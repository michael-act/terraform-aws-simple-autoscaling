variable "cluster_name" {
  description = "Name of ECS Cluster Name"
  type        = string
}

variable "service_name" {
  description = "Name of ECS Service Name"
  type        = string
}

variable "name_prefix" {
  description = "Prefix of the resources (cloudwatch, autoscaling policy) name"
  type        = string

  default = "ecs-service"
}

variable "auto_scaling" {
  description = "Auto Scaling Configuration"
  type        = object({
    scale_in = optional(object({
      evaluation_periods = optional(number, 5)
      cooldown           = optional(number, 300)
      interval_period    = optional(number, 60)
    }), {})

    scale_out = optional(object({
      evaluation_periods = optional(number, 3)
      cooldown           = optional(number, 60)
      interval_period    = optional(number, 60)
    }), {})

    min_size          = optional(number, 1)
    max_size          = optional(number, 3)
  })

  default = {
    scale_in = {
      evaluation_period = 5
      cooldown          = 300
      interval_period   = 60
    }

    scale_out = {
      evaluation_period = 3
      cooldown          = 60
      interval_period   = 60
    }

    min_size = 1
    max_size = 3
  }
}

variable "metric" {
  description = "Target Metric Configuration"
  type        = object({
    name           = optional(string, "MemoryUtilization") # Available built-in metrics: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#ecs-metrics
    statistic_type = optional(string, "Average") # Available built-in statistic type: https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Statistics-definitions.html
    target_high    = optional(number, 85)
    target_low     = optional(number, 30)
  })

  default = {
    name           = "MemoryUtilization"
    statistic_type = "Average"
    target_high    = 85
    target_low     = 30
  }
}

variable "additional_alarm_actions" {
  description = "Additional Alarm Action to be Executed"
  type        = list(string)

  default = []
}

variable "tags" {
  description = "Tags of Resources"
  type        = map(string)

  default = {}
}