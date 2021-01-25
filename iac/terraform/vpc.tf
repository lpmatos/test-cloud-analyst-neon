# ================================================
# DECLARING VPC VARIABLES
# ================================================

variable "default_vpc_id_bastion" {
  type        = string
  description = "VPC ID used in Bastion EC2"
  default     = "vpc-0ed406c0b66beccd3"
}

# ================================================
# DATA RESOURCE VPC
# ================================================

data "aws_vpc" "default_bastion" {
  id = var.default_vpc_id_bastion
}

# ================================================
# OUTPUT VPC ID
# ================================================

output "default_vpc_bastion" {
  value       = data.aws_vpc.default_bastion.id
  description = "Bastion VPC ID"
}
