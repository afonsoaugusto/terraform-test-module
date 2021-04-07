data "aws_eks_cluster" "default" {
  name = module.cluster.cluster_id
}

data "aws_eks_cluster_auth" "default" {
  name = module.cluster.cluster_id
}

output "name" {
  
}