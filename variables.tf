variable "allocated_storage" {
  description = "Required unless a snapshot_identifier or replicate_source_db is provided) The allocated storage in gigabytes"
}

variable "max_allocated_storage" {
  description = "When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance (in gigabytes)"
  default     = null
}

variable "allow_major_version_upgrade" {
  description = "Allow major RDS engine upgrades (applied during the maintenance window)"
  default     = false
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  default     = false
}

variable "auto_minor_version_upgrade" {
  description = "Allow minor RDS engine upgrades (applied during the maintenance window)"
  default     = true
}

variable "availability_zone" {
  description = "Availability zone"
  default     = null
}

variable "backup_retention_period" {
  description = "Number of daily backups to retain"
  default     = 1
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window"
  default     = "09:46-10:16"
}

variable "character_set_name" {
  description = "(Optional) The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS for more information"
  default     = null
}

variable "copy_tags_to_snapshot" {
  description = "Copy instance tags to final snapshot if one is created"
  default     = true
}

variable "db_name" {
  description = "Database name to create."
}

variable "db_subnet_group_name" {
  description = "Database subnet group name; instance will be created in the associated VPC"
  default     = null
}

variable "deletion_protection" {
  description = "Prevent database deletion when set"
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace."
  type        = list(string)
  default     = []
}

variable "engine" {
  description = "(Required) Database engine to use"
}

variable "engine_version" {
  description = "Engine version to use"
  default     = null
}

variable "final_snapshot_identifier" {
  description = "Computed by default. Without a final snapshot, you will be unable to restore the data in a deleted RDS instance"
  default     = null
}

variable "iam_database_authentication_enabled" {
  description = "Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled"
  default     = false
}

variable "identifier" {
  # TODO: Should we provide a sane default rather than allow omitting?
  description = "(REQUIRED) Name of the RDS instance. If omitted, Terraform will assign a random, unique identifier"
}

variable "instance_class" {
  description = "(REQUIRED) The instance type"
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of 'io1'"
  default     = null
}

variable "kms_key_id" {
  description = "ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN."
  default     = null
}

variable "license_model" {
  description = "License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1"
  default     = null
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  default     = null
}

# variable "monitoring_interval" {
#   description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
#   default     = 0
# }

# variable "monitoring_role_arn" {
#   description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
#   default     = null
# }

# variable "monitoring_role_name" {
#   description = "Name of the IAM role which will be created when create_monitoring_role is enabled."
#   default     = "rds-monitoring-role"
# }

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  default     = false
}

variable "option_group_name" {
  description = "Name of the DB option group to associate"
  default     = null
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  default     = null
}

variable "port" {
  description = "Database connection port"
  type        = number
}

variable "publicly_accessible" {
  description = "Controls whether instance is publicly accessible"
  default     = false
}

variable "replicate_source_db" {
  description = "For a replicated database, use the database identifier specified here as the source database"
  default     = null
}

variable "feature_role_arns" {
  description = "(Optional) A map of feature names to IAM role ARNs to attach to the RDS instance"
  type        = map(string)
  default     = {}
}

variable "security_group_names" {
  description = "List of security group names"
  type        = list(string)
  default     = []
}

variable "skip_final_snapshot" {
  description = "Skip creating a final database snapshot before the instance is deleted. WARNING! Specifying 'true' can cause data loss"
  default     = false
}

# TODO: Determine how to simplify management of dump to snapshot and load from snapshot, and whether default values can be computed.
variable "snapshot_identifier" {
  description = "If specified, use the named snapshot to create the database. The snapshot ID can be found in the RDS console, e.g: rds:service-2015-06-26-06-05."
  default     = null
}

variable "storage_encrypted" {
  description = "Determines whether the DB instance is encrypted"
  default     = true
}

variable "storage_type" {
  description = "One of the supported storage types"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "timeouts" {
  description = "(Optional) Terraform resource management timeouts"
  type = object({
    create = optional(string)
    delete = optional(string)
    update = optional(string)
  })
  default = null
}

variable "username" {
  description = "Username for the database master user"
}
