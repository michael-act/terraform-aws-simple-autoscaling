##################################
# Amazon App Auto Scaling Policy #
##################################

resource "aws_appautoscaling_target" "this" {
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  min_capacity       = var.autoscaling.min_size
  max_capacity       = var.autoscaling.max_size
}

resource "aws_appautoscaling_policy" "scale_out" {
  name               = "${var.name_prefix}-${var.cluster_name}-${var.service_name}-scale-out"
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.autoscaling.scale_out.cooldown
    metric_aggregation_type = var.metric.statistic_type
    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [aws_appautoscaling_target.this]
}

resource "aws_appautoscaling_policy" "scale_in" {
  name               = "${var.name_prefix}-${var.cluster_name}-${var.service_name}-scale-in"
  service_namespace  = "ecs"
  resource_id        = "service/${var.cluster_name}/${var.service_name}"
  scalable_dimension = "ecs:service:DesiredCount"
  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = var.autoscaling.scale_in.cooldown
    metric_aggregation_type = var.metric.statistic_type
    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [aws_appautoscaling_target.this]
}
