#####################################
# Amazon ECS Service Metric Scaling #
#####################################

resource "aws_cloudwatch_metric_alarm" "firing" {
  alarm_name          = "${var.name_prefix}-firing"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.auto_scaling.scale_out.evaluation_periods
  metric_name         = var.metric.name
  namespace           = "AWS/${lower(var.auto_scaling.namespace)}"
  period              = var.auto_scaling.scale_out.interval_period
  statistic           = var.metric.statistic_type
  threshold           = var.metric.target_high
  dimensions          = var.metric.dimensions

  alarm_description = "WARNING! ${var.name_prefix} is increasing..."
  alarm_actions     = concat([aws_appautoscaling_policy.scale_out.arn], var.additional_alarm_actions)
  tags              = var.tags
}

resource "aws_cloudwatch_metric_alarm" "relax" {
  alarm_name          = "${var.name_prefix}-relax"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = var.auto_scaling.scale_in.evaluation_periods
  metric_name         = var.metric.name
  namespace           = "AWS/${lower(var.auto_scaling.namespace)}"
  period              = var.auto_scaling.scale_in.interval_period
  statistic           = var.metric.statistic_type
  threshold           = var.metric.target_high
  dimensions          = var.metric.dimensions

  alarm_description = "WARNING! ${var.name_prefix} is decreasing... we will terminate one of the instance."
  alarm_actions     = concat([aws_appautoscaling_policy.scale_in.arn], var.additional_alarm_actions)
  tags              = var.tags
}
