# ================================================
# DATA RESOURCE VPC
# ================================================

data "aws_vpc" "default" {
  id = var.default_vpc_id
}

# ================================================
# OUTPUT VPC ID
# ================================================

output "default_vpc" {
  value       = data.aws_vpc.default.id
  description = "Show default VPC ID used in this code"
}
