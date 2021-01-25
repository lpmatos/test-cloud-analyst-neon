# ================================================
# DECLARING PROVIDERS AND TERRAFORM SETTINGS
# ================================================

terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.25.0"
    }
  }
}
