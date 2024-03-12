# option-group

Manage an RDS option group.

## Usage

```hcl
module "rds-option-group" {
  source = "git@github.com:techservicesillinois/terraform-aws-rds//modules/option-group"

  engine         = "oracle-ee"
  engine_version = "19"

  description = "Enable S3 integration for database migration"
  name_suffix = "db-migration-s3-integration"

  option = [
    {
    option_name = "S3_INTEGRATION"
    }
  ]

  tags = {
    Service = "dba-migrate"
  }
}
```

Argument Reference
-----------------

The following arguments are supported:

* `engine` - (Required) Engine name to which option group applies

* `engine_version` - (Required) Major engine version to which option group applies

* `option` - (Optional) List of option objects to include in the option group. Note that options differ from one RDS engine to another. A full list of all options for a given RDS engine can be discovered via the AWS command line interface by running

  ```
  aws rds describe-option-group-options --engine-name <rds_engine_name>
  ```

* `name_suffix` - (Required) Suffix for option group name. The full name is generated from the engine name, engine version, and the suffix. The suffix may contain only letters, digits, or hyphens. See [Working with DB option groups](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_WorkingWithOptionGroups.html) for additional restrictions.

* `tags` - (Optional) Tags to be applied to resources where supported.

* `timeouts` - (Optional) Map of timeouts for the AWS API when working with this resource. The only timeout available for this module is the delete timeout and should be an item in the map with a key of `delete`.

* `security_group_names` - (Optional) A list of VPC security group names that apply to these options

`option`
----------

An `option` block consists of a list containing one or more objects, each of which may contain the following attributes:

* `option_name` - (Required) Name of the option to enable.

* `option_settings` - (Optional) A list of option setting maps, each containing a setting that applies to this option. Each map must contain an `name` element and a `value` element.

* `port` - (Optional) Port number for this option.

* `version` - (Optional) version string for this option.

Attributes Reference
--------------------

The following attributes are exported:

* `arn` - Amazon Resource Name of the option group.

* `name` - name of the RDS option group.
