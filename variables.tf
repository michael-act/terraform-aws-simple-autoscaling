variable "name_prefix" {
  description = "Prefix of the resources (cloudwatch, autoscaling policy) name"
  type        = string
}

variable "auto_scaling" {
  description = "Auto Scaling Configuration"
  type        = object({
    namespace          = string
    resource_id        = string
    scalable_dimension = string
    min_size           = number
    max_size           = number

    scale_in = object({
      evaluation_periods = optional(number, 5)
      cooldown           = optional(number, 300)
      interval_period    = optional(number, 60)
    })

    scale_out = object({
      evaluation_periods = optional(number, 3)
      cooldown           = optional(number, 60)
      interval_period    = optional(number, 60)
    })
  })
}

variable "metric" {
  description = "Target Metric Configuration"
  type        = object({
    name           = string
    statistic_type = string
    target_high    = number
    target_low     = number
    dimensions     = map(string)
  })
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