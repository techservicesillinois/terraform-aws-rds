# rds

Provide an [RDS database instance](https://www.terraform.io/docs/providers/aws/r/db_instance.html).

Use the [terraform-aws-client-server-security-group](https://github.com/techservicesillinois/terraform-aws-client-server-security-group) module to create security groups
to be used by clients and servers of this RDS instance. The referred-to module
creates two RDS security groups – one a client security group, and the other a
server security group.
The server security group should be referenced in the `security_group_names`
attribute when building an RDS instance.
The client security group should be added to authorized clients. and one
Members of the client security group are granted access to the RDS servers on
the appropriate network port.

**NOTE:** The `deletion_protection` attribute is `true` by default in order to make it
difficult to unintentionally destroy a persistent resource. To enable destruction, you
must set the attribute to `false` and then apply this change using Terraform.

Once applied, you can then run `terraform destroy` to destroy the database, which
includes destroying daily snapshots. **If you do not make a final snapshot, your
data will be irrevocably lost.**

## Usage

```hcl
module "db" {
  source = "git@github.com:techservicesillinois/terraform-aws-rds"

# Identifier for RDS instance.
identifier = "service"

# Security group referenced below is created by the https://github.com/techservicesillinois/terraform-aws-client-server-security-group module.
security_group_names = "service-db-servers"

# Name of database to be created.
name     = "service-db"

# NOTE: Terraform-specified password is used to bring up infrastructure,
# but is insecure because it's stored in the infrastructure state file.
# We recommend changing password IMMEDIATELY to new value using AWS console,
# and saving that password as a secure parameter in Amazon SSM.

# User name and password.
username = "user"
password = "password"
port     = "1521"

# Database engine details. Note that version needs to be consistent
# with family and option_group_name settings in this file.
engine         = "oracle-ee"
engine_version = "12.1.0.2.v11"

# Don't use the following settings in production!
# apply_immediately = true
# allow_major_version_upgrade = true

# Instance class and storage in gigabytes.
instance_class    = "db.t2.medium"
allocated_storage = "100"

# Automatically apply minor version upgrades during maintenance window.
auto_minor_version_upgrade = true

# Save backups for this many days.
backup_retention_period = "7"

# Deploy in multiple availability zones.
multi_az           = false

# Backup window is expressed in UTC. Must not overlap with maintenance window.
backup_window      = "07:00-10:00"

# Maintenance window is expressed in UTC. Must not overlap with backup window.
maintenance_window = "Sun:04:00-Sun:07:00"

# When set to "true", deleting the database instance using the API or
# Terraform is prohibited. In order to delete the database (and snapshots),
# this setting must be changed to "false", either using Terraform
# or the AWS console.
deletion_protection = true

# If specified, use snapshot for initial database build.
# snapshot_identifier = "service-snapshot"

###########################################################################
# WARNING: Use caution; setting this value to "true" can cause data loss. #
###########################################################################
skip_final_snapshot = "false"

# Final database snapshot is given this identifier by default.
# final_snapshot_identifier = "service-FINAL"

# Subnet, parameter, and option group resources must already exist.
db_subnet_group_name = "develop-subnet-2"
parameter_group_name = "service-pg"
# Note that RDS manages default option group.
option_group_name    = "default:oracle-ee-12-1"

tags = {
  Environment = "test"
  Name        = "service"
  Owner       = "user"
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| allocated_storage | The allocated storage in gigabytes | string | - | yes |
| allow_major_version_upgrade | Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible | string | `false` | no |
| apply_immediately | Specifies whether any database modifications are applied immediately, or during the next maintenance window | string | `false` | no |
| auto_minor_version_upgrade | Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window | string | `true` | no |
| availability_zone | The Availability Zone of the RDS instance | string | `` | no |
| backup_retention_period | The days to retain backups for | string | `1` | no |
| backup_window | The daily time range (in UTC) during which automated backups are created if they are enabled. Example: '09:46-10:16'. Must not overlap with maintenance_window | string | - | yes |
| character_set_name | (Optional) The character set name to use for DB encoding in Oracle instances. This can't be changed. See Oracle Character Sets Supported in Amazon RDS for more information | string | `` | no |
| copy_tags_to_snapshot | On delete, copy all Instance tags to the final snapshot (if final_snapshot_identifier is specified) | string | `false` | no |
| db_subnet_group_name | Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC | string | `` | no |
| deletion_protection | The database can't be deleted when this value is set to true. | string | `false` | no |
| enabled_cloudwatch_logs_exports | List of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine): alert, audit, error, general, listener, slowquery, trace. | string | `<list>` | no |
| engine | The database engine to use | string | - | yes |
| engine_version | The engine version to use | string | - | yes |
| final_snapshot_identifier | The name of your final DB snapshot when this DB instance is deleted. | string | `false` | no |
| iam_database_authentication_enabled | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled | string | `false` | no |
| identifier | The name of the RDS instance. If omitted, Terraform will assign a random, unique identifier | string | - | yes |
| instance_class | The instance type of the RDS instance | string | - | yes |
| iops | The amount of provisioned IOPS. Setting this implies a storage_type of 'io1' | string | `0` | no |
| kms_key_id | The ARN for the KMS encryption key. If creating an encrypted replica, set this to the destination KMS ARN. If storage_encrypted is set to true and kms_key_id is not specified the default KMS key created in your account will be used | string | `` | no |
| license_model | License model information for this DB instance. Optional, but required for some DB engines, i.e. Oracle SE1 | string | `` | no |
| maintenance_window | The window to perform maintenance in. Syntax: 'ddd:hh24:mi-ddd:hh24:mi'. Eg: 'Mon:00:00-Mon:03:00' | string | - | yes |
| ~~monitoring_interval~~ | ~~The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance. To disable collecting Enhanced Monitoring metrics, specify 0. The default is 0. Valid Values: 0, 1, 5, 10, 15, 30, 60.~~ | ~~string~~ | ~~`0`~~ | ~~no~~ |
| ~~monitoring_role_arn~~ | ~~ARN for the IAM role that permits RDS to send enhanced monitoring metrics to CloudWatch Logs. Must be specified if monitoring_interval is non-zero.~~ | ~~string~~ | ~~``~~ | ~~no~~ |
| ~~monitoring_role_name~~ | ~~Name of the IAM role which will be created when create_monitoring_role is enabled.~~ | ~~string~~ | ~~`rds-monitoring-role`~~ | ~~no~~ |
| multi_az | Specifies if the RDS instance is multi-AZ | string | `false` | no |
| name | The DB name to create. If omitted, no database is created initially. | string | `` | no |
| option_group_name | Name of the DB option group to associate. Setting this automatically disables option_group creation | string | `` | no |
| parameter_group_name | Name of the DB parameter group to associate. | string | `` | no |
| password | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | string | - | yes |
| port | The port on which the DB accepts connections | string | - | yes |
| publicly_accessible | Bool to control if instance is publicly accessible | string | `false` | no |
| replicate_source_db | Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate. | string | `` | no |
| security_group_names | Additonal security groups to associated with the task or service. This is a space delimited string list of security group names. | - | no |
| skip_final_snapshot | Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier | string | `true` | no |
| snapshot_identifier | Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05. | string | `` | no |
| storage_encrypted | Specifies whether the DB instance is encrypted | string | `false` | no |
| storage_type | One of 'standard' (magnetic), 'gp2' (general purpose SSD), or 'io1' (provisioned IOPS SSD). The default is 'io1' if iops is specified, 'standard' if not. Note that this behaviour is different from the AWS web console, where the default is 'gp2'. | string | `gp2` | no |
| tags | A mapping of tags to assign to all resources | string | `<map>` | no |
| timeouts | (Optional) Updated Terraform resource management timeouts. Applies to `aws_db_instance` in particular to permit resource management times | map | `<map>` | no |
| username | Username for the master DB user | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| address | The address of the RDS instance |
| arn | The ARN of the RDS instance |
| name | The database name |
| username | The master username for the database |


<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Authors

This module is an all-new module produced by the University of Illinois at Urbana-Champaign.
We adapted some code from [https://github.com/terraform-aws-modules/terraform-aws-rds/](https://github.com/terraform-aws-modules/terraform-aws-rds/).

## License

Apache 2 Licensed. See LICENSE for full details.
