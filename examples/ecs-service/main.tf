module "ecs_service_basic_web" {
  source = "../../modules/ecs-service"

  cluster_name = "ecs-cluster-exploration-michaelact"
  service_name = "ecs-service-nginx"
}