variable "db_instance_class" {
  description = "DB instance class for the reserved DB instance"
  type        = string
}

variable "duration" {
  description = "Duration of the reservation in years or seconds"
  type        = number
}

variable "instance_count" {
  description = "Number of instances to reserve"
  type        = number
  default     = null
}

variable "multi_az" {
  description = "Whether the reservation applies to Multi-AZ deployments"
  type        = bool
}

variable "offering_type" {
  description = "Offering type of this reserved DB instance. Valid values are `No Upfront`, `Partial Upfront`, `All Upfront`"
  type        = string

  validation {
    condition     = try(contains(["All Upfront", "No Upfront", "Partial Upfront"], var.offering_type), true)
    error_message = "The 'offering_type' is not one of the valid values 'All Upfront', 'No Upfront', or 'Partial Upfront'"
  }
}

variable "product_description" {
  description = "Description of the reserved DB instance"
  type        = string
}

variable "reservation_id" {
  description = "Customer-specified identifier to track this reservation"
}

variable "tags" {
  description = "Tags to be applied to resources where supported"
  type        = map(string)
  default     = {}
}
