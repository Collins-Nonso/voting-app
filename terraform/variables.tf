
variable "aws_region" {
  description = "AWS region for the EKS cluster"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "voting-app-eks"
}
