# ================================================
# DATA RESOURCE SUBNETS
# ================================================

data "aws_subnet_ids" "default_private" {
  vpc_id = data.aws_vpc.default.id
  tags = {
    Network = "Private"
  }
}

data "aws_subnet" "default_private" {
  for_each = data.aws_subnet_ids.default_private.ids
  id       = each.value
}

# ================================================
# OUTPUT MY SUBNETS
# ================================================

output "subnet_ids" {
  value = [for subnet in data.aws_subnet.default_private : subnet.id]
}
