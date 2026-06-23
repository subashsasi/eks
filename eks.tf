module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "sandbox-eks"
  cluster_version = "1.30"

  cluster_endpoint_public_access = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    sandbox_nodes = {
      min_size     = 1
      max_size     = 2
      desired_size = 2

      instance_types = ["t3.small"]
      capacity_type  = "SPOT" # SPOT instances are highly cost-effective for sandbox testing
    }
  }

  enable_cluster_creator_admin_permissions = true

  # Disable KMS and CloudWatch logs to avoid resource conflict errors in sandbox
  create_kms_key            = false
  cluster_encryption_config = {}
  cluster_enabled_log_types = []
}
