# ================================================
# DECLARING GENERIC VARIABLES
# ================================================

variable "environment" {
  type        = string
  description = "The deployment environment state (eg. production, develop, labs)"
  default     = "Labs"
}

variable "autor" {
  type        = string
  description = "Terraform resource author"
  default     = "Lucca Pessoa"
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
