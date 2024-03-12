variable "description" {
  description = "Description of option group"
  default     = null
}

variable "engine" {
  description = "Database engine to which group applies"
}

variable "engine_version" {
  description = "Major engine version to which group applies"
}

variable "name_suffix" {
  description = "Suffix for option group name (appended after engine and engine_version)"
}

variable "option" {
  description = "List containing option maps to include in the option group"
  type = list(object({
    option_name = string
    option_settings = optional(list(object({
      name  = string
      value = string
    })))
    port    = optional(number)
    version = optional(string)
  }))
}

variable "security_group_names" {
  description = "List of VPC security group names used for these options"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to be applied to resources where supported"
  type        = map(string)
  default     = {}
}

variable "timeouts" {
  description = "(Optional) Terraform resource management timeouts"
  type = object({
    delete = optional(string)
  })
  default = null
}
