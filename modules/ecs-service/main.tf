module "ecs_service_autoscaling" {
  source = "../../"

  name_prefix = var.name_prefix

  auto_scaling = {
    namespace          = "ECS"
    resource_id        = "service/${var.cluster_name}/${var.service_name}"
    scalable_dimension = "ecs:service:DesiredCount"
    min_size           = var.auto_scaling.min_size
    max_size           = var.auto_scaling.max_size
    scale_out          = var.auto_scaling.scale_out
    scale_in           = var.auto_scaling.scale_in
  }

  metric = {
    name           = var.metric.name
    statistic_type = var.metric.statistic_type
    target_high    = var.metric.target_high
    target_low     = var.metric.target_low
    dimensions     = {
      ClusterName = var.cluster_name
      ServiceName = var.service_name
    }
  }

  additional_alarm_actions = var.additional_alarm_actions
  tags                     = var.tags
}
