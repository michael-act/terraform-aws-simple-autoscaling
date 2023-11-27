# AWS Auto Scaling Module

This is a collection of submodules that make it easier to non-destructively manage multiple Auto Scaling for resources on Amazon Web Services:

- [ECS Cluster Auto Scaling](modules/ecs-cluster)
- [ECS Service Auto Scaling](modules/ecs-service)

## Usage 

```hcl
module "ecs_service_basic_cluster" {
  source = "michaelact/simple-autoscaling/aws//modules/ecs-cluster"

  cluster_name           = "ecs-cluster-exploration-michaelact"
  autoscaling_group_name = "asg-cluster-exploration-michaelact"
}
```

## Examples

- [Simple ECS Cluster Auto Scaling](examples/ecs-cluster)
- [Simple ECS Service Auto Scaling](examples/ecs-service)

## Authors

Module is maintained by [Michael Act](https://github.com/michaelact) with help from [these awesome contributors](https://github.com/michaelact/terraform-aws-simple-autoscaling/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/michaelact/terraform-aws-simple-autoscaling/tree/master/LICENSE) for full details.
