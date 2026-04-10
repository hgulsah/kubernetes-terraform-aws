output "vpc_id" {
  description = "VPC ID for the dev environment."
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private subnet IDs used by EKS worker nodes."
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Public subnet IDs used for public load balancers."
  value       = module.vpc.public_subnets
}

output "cluster_name" {
  description = "EKS cluster name."
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster API server endpoint."
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "EKS Kubernetes version."
  value       = module.eks.cluster_version
}

output "cluster_security_group_id" {
  description = "Security group ID attached to the EKS cluster."
  value       = module.eks.cluster_security_group_id
}

output "node_group_names" {
  description = "Names of the EKS managed node groups."
  value       = keys(module.eks.eks_managed_node_groups)
}
