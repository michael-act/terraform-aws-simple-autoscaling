##################################
# Amazon App Auto Scaling Policy #
##################################

resource "aws_appautoscaling_target" "this" {
  service_namespace  = lower(var.auto_scaling.namespace)
  resource_id        = var.auto_scaling.resource_id
  scalable_dimension = var.auto_scaling.scalable_dimension
  min_capacity       = var.auto_scaling.min_size
  max_capacity       = var.auto_scaling.max_size
}

resource "aws_appautoscaling_policy" "scale_out" {
  name               = "${var.name_prefix}-scale-out"
  service_namespace  = lower(var.auto_scaling.namespace)
  resource_id        = var.auto_scaling.resource_id
  scalable_dimension = var.auto_scaling.scalable_dimension
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.auto_scaling.scale_out.cooldown
    metric_aggregation_type = var.metric.statistic_type
    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [aws_appautoscaling_target.this]
}

resource "aws_appautoscaling_policy" "scale_in" {
  name               = "${var.name_prefix}-scale-in"
  service_namespace  = lower(var.auto_scaling.namespace)
  resource_id        = var.auto_scaling.resource_id
  scalable_dimension = var.auto_scaling.scalable_dimension
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.auto_scaling.scale_in.cooldown
    metric_aggregation_type = var.metric.statistic_type
    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [aws_appautoscaling_target.this]
}
