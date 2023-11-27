module "ecs_service_basic_cluster" {
  source = "../../modules/ecs-cluster"

  cluster_name           = "ecs-cluster-exploration-michaelact"
  autoscaling_group_name = "asg-cluster-exploration-michaelact"
}
