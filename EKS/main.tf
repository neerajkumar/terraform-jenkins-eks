# VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eks-vpc"
  cidr = var.vpc_cidr

  azs = data.aws_availability_zones.azs.names
  #   private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  #   enable_vpn_gateway = true
  enable_dns_hostnames = true
  single_nat_gateway   = true

  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/elb"               = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
    "kubernetes.io/role/internal-elb"      = 1
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.31"

  cluster_endpoint_public_access = true

  #   # Optional
  #   cluster_endpoint_public_access = true

  #   # Optional: Adds the current caller identity as an administrator via cluster access entry
  #   enable_cluster_creator_admin_permissions = true

  #   cluster_compute_config = {
  #     enabled    = true
  #     node_pools = ["general-purpose"]
  #   }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    nodes = {
      min_size     = 1
      max_size     = 3
      desired_size = 2

      instance_types = [var.instance_type]
    }
  }

  tags = {
    Name        = "My EKS Cluster"
    Environment = "dev"
    Terraform   = "true"
  }
}

data "aws_iam_user" "jan_tyminski" {
  user_name = "tf-user"
}

resource "aws_eks_access_entry" "jan_tyminski" {
  cluster_name  = module.eks.cluster_name
  principal_arn = data.aws_iam_user.jan_tyminski.arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "jan_tyminski_AmazonEKSAdminPolicy" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
  principal_arn = aws_eks_access_entry.jan_tyminski.principal_arn

  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_access_policy_association" "jan_tyminski_AmazonEKSClusterAdminPolicy" {
  cluster_name  = module.eks.cluster_name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  principal_arn = aws_eks_access_entry.jan_tyminski.principal_arn

  access_scope {
    type = "cluster"
  }
}
