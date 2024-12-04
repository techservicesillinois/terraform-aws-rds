variable "event_categories" {
  description = "List of event categories to which to subscribe"
  type        = list(string)
  default     = []
}

variable "instance_names" {
  description = "List of database identifiers for which events will be returned; empty list specifies all databases in this account and region"
  type        = list(string)
  default     = null
}

variable "sns_topic" {
  description = "SNS topic"
}

variable "tags" {
  description = "Tags to be applied to resources where supported"
  type        = map(string)
  default     = {}
}
