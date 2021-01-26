provider "aws" {
  access_key = local.variables.aws_access_key
  secret_key = local.variables.aws_secret_key
  region     = local.variables.aws_region
}

locals {
  variables = {
    aws_access_key = try(yamldecode(file(var.values_file))["aws"]["access_key"], "Exception")
    aws_secret_key = try(yamldecode(file(var.values_file))["aws"]["secret_key"], "Exception")
    aws_region     = try(yamldecode(file(var.values_file))["aws"]["region"], "Exception")
  }
}

data "aws_ami" "apache" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["ami-apache-*"]
  }
}
