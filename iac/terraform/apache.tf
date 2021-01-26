resource "aws_instance" "apache" {
  for_each = data.aws_subnet_ids.default_private.ids

  ami           = data.aws_ami.apache.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.apache.key_name

  subnet_id = each.value

  vpc_security_group_ids = [
    aws_security_group.allows_http_ssh.id
  ]

  monitoring = true

  tags = {
    ManagedBy   = "Terraform"
    Maintainer  = var.maintaner
    Environment = var.environment
  }
}
