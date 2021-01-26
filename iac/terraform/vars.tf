# ================================================
# DECLARING GENERIC VARIABLES
# ================================================

variable "environment" {
  type        = string
  description = "The deployment environment state (eg. production, develop, labs)"
  default     = "Labs"
}

variable "maintaner" {
  type        = string
  description = "Terraform resource author"
  default     = "Lucca Pessoa da Silva Matos"
}

variable "values_file" {
  type        = string
  description = "Values File"
  default     = "values.yml"
  validation {
    condition     = length(regexall(".yml", var.values_file)) > 0 || length(regexall(".yaml", var.values_file)) > 0
    error_message = "The values_file value must be a valid YML file."
  }
}

# ================================================
# DECLARING VPC VARIABLES
# ================================================

variable "default_vpc_id" {
  type        = string
  description = "Default VPC ID used"
  default     = "vpc-0ed406c0b66beccd3"
}
