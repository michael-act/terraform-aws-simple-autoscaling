#####################################
# Amazon ECS Service Metric Scaling #
#####################################

resource "aws_cloudwatch_metric_alarm" "firing" {
  alarm_name          = "${var.name_prefix}-${var.cluster_name}-${var.service_name}-firing"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.autoscaling.scale_out.evaluation_periods
  metric_name         = var.metric.name
  namespace           = "AWS/ECS"
  period              = var.autoscaling.scale_out.interval_period
  statistic           = var.metric.statistic_type
  threshold           = var.metric.target_high
  dimensions          =  {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  alarm_description = "WARNING! ${var.name_prefix} is increasing..."
  alarm_actions     = concat([aws_appautoscaling_policy.scale_out.arn], var.additional_alarm_actions)
  tags              = var.tags
}

resource "aws_cloudwatch_metric_alarm" "relax" {
  alarm_name          = "${var.name_prefix}-${var.cluster_name}-${var.service_name}-relax"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.autoscaling.scale_in.evaluation_periods
  metric_name         = var.metric.name
  namespace           = "AWS/ECS"
  period              = var.autoscaling.scale_in.interval_period
  statistic           = var.metric.statistic_type
  threshold           = var.metric.target_low
  dimensions          =  {
    ClusterName = var.cluster_name
    ServiceName = var.service_name
  }

  alarm_description = "WARNING! ${var.name_prefix} is decreasing... we will terminate one of the instance."
  alarm_actions     = concat([aws_appautoscaling_policy.scale_in.arn], var.additional_alarm_actions)
  tags              = var.tags
}
