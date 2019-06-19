variable "allocated_storage" {
  description = "Required unless a snapshot_identifier or replicate_source_db is provided) The allocated storage in gigabytes"
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
  default     = ""
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
  default     = ""
}

variable "copy_tags_to_snapshot" {
  description = "Copy instance tags to final snapshot if one is created"
  default     = true
}

variable "db_subnet_group_name" {
  description = "Database subnet group name; instance will be created in the associated VPC"
  default     = ""
}

variable "deletion_protection" {
  description = "Prevent database deletion when set"
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  description = "List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace."
  default     = []
}

variable "engine" {
  description = "(Required) Database engine to use"
}

variable "engine_version" {
  description = "Engine version to use"
  default     = ""
}

variable "final_snapshot_identifier" {
  description = "Computed by default. Without a final snapshot, you will be unable to restore the data in a deleted RDS instance"
  default     = ""
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
  default     = 0
}

variable "kms_key_id" {
  description = "ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN."
  default     = ""
}

variable "license_model" {
  description = "License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1"
  default     = ""
}

variable "maintenance_window" {
  description = "The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00'"
  default     = ""
}

# variable "monitoring_interval" {
#   description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60."
#   default     = 0
# }

# variable "monitoring_role_arn" {
#   description = "The ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero."
#   default     = ""
# }

# variable "monitoring_role_name" {
#   description = "Name of the IAM role which will be created when create_monitoring_role is enabled."
#   default     = "rds-monitoring-role"
# }

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  default     = false
}

variable "name" {
  description = "Database name to create. If omitted, no database is created initially"
  default     = ""
}

variable "option_group_name" {
  description = "Name of the DB option group to associate"
  default     = ""
}

variable "parameter_group_name" {
  description = "Name of the DB parameter group to associate"
  default     = ""
}

variable "password" {
  description = "Password for the master DB user. Note that this may show up in logs, and it will be stored in Terraform's state file"
}

variable "port" {
  description = "Database connection port"
}

variable "publicly_accessible" {
  description = "Controls whether instance is publicly accessible"
  default     = false
}

variable "replicate_source_db" {
  description = "For a replicated database, use the database identifier specified here as the source database"
  default     = ""
}

variable "security_group_names" {
  description = "Space-delimited string containing security group names"
}

variable "skip_final_snapshot" {
  description = "Skip creating a final database snapshot before the instance is deleted. WARNING! Specifying 'true' can cause data loss"
  default     = false
}

# TODO: Determine how to simplify management of dump to snapshot and load from snapshot, and whether default values can be computed.
variable "snapshot_identifier" {
  description = "If specified, use the named snapshot to create the database. The snapshot ID can be found in the RDS console, e.g: rds:service-2015-06-26-06-05."
  default     = ""
}

variable "storage_encrypted" {
  description = "Determines whether the DB instance is encrypted"
  default     = true
}

variable "storage_type" {
  description = "One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'."
  default     = "gp2"
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource"
  default     = {}
}

variable "timeouts" {
  description = "(Optional) Terraform resource management timeouts"
  type        = "map"

  default = {
    create = "40m"
    update = "80m"
    delete = "40m"
  }
}

variable "username" {
  description = "Username for the database master user"
}
