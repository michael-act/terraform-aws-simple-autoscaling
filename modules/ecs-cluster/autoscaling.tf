resource "aws_autoscaling_policy" "scale_out" {
  name                   = "${var.name_prefix}-${var.cluster_name}-scale-out"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.autoscaling.scale_out.cooldown
  autoscaling_group_name = var.autoscaling_group_name
}

resource "aws_autoscaling_policy" "scale_in" {
  name                   = "${var.name_prefix}-${var.cluster_name}-scale-in"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = var.autoscaling.scale_in.cooldown
  autoscaling_group_name = var.autoscaling_group_name
}
