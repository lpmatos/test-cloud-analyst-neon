# ================================================
# RESOURCE CRERATE KEY PAIR
# ================================================

resource "aws_key_pair" "apache" {
  key_name   = var.ssh_key_name
  public_key = file("/root/git/neon/github/test-cloud-analyst-neon/keys/apache.pub")
}
