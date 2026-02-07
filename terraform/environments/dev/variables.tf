variable "project_name" {
  type        = string
  description = "Project name for tagging and naming."
}

variable "environment" {
  type        = string
  description = "Environment name (dev, staging, prod)."

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be one of: dev, staging, prod."
  }
}

variable "region" {
  type        = string
  description = "AWS region."
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
}

variable "kubernetes_version" {
  type        = string
  description = "EKS Kubernetes version."
  default     = "1.29"
}

variable "node_instance_type" {
  type        = string
  description = "EC2 instance type for worker nodes."
  default     = "t3.medium"
}

variable "desired_size" {
  type        = number
  description = "Desired number of worker nodes."
  default     = 2
}

variable "min_size" {
  type        = number
  description = "Minimum number of worker nodes."
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Maximum number of worker nodes."
  default     = 3
}

