# reserved-instance

Manage an RDS reserved instance.

## Usage

```hcl
module "rds-reserved-instance" {
  source = "modules/reserved-instance"
  
  db_instance_class   = "db.t4g.large"
  duration            = 1 # Expressed in year(s).
  multi_az            = true
  offering_type       = "No Upfront"
  product_description = "mariadb"
  reservation_id      = "foobar" # value is merged into the Name tag.
  
  tags = {
    Service = "foobar"
  }
}
```

Argument Reference
-----------------

The following arguments are supported:

* `db_instance_class` - (Required) DB instance class for the reserved DB instance

* `duration` - (Required) Duration of the reservation in years or seconds

* `instance_count` - (Optional) Number of instances to reserve

* `multi_az` - (Required) Whether the reservation applies to Multi-AZ deployments

* `offering_type` - (Required) Offering type of this reserved DB instance. Valid values are `All Upfront`, `No Upfront`, and `Partial Upfront`

* `product_description` - (Required) Description of the reserved DB instance

* `reservation_id` - (Optional) Customer-specified identifier to track this reservation

* `tags` - (Optional) Tags to be applied to resources where supported

Attributes Reference
--------------------

The following attributes are exported:

* `arn` - Amazon Resource Name of the reserved instance

* `lease_id` - Unique identifier for the lease associated with the reserved DB instance

* `offering_id` - ID of the reserved DB instance offering purchased
