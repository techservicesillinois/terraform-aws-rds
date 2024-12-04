# event-subscription

Subscribe specified RDS events for specified RDS instancs to an Amazon SNS topic.

## Usage

```hcl
module "rds-reserved-instance" {
  source = "modules/event-subscription"

  event_categories = [
    "failover",
    "failure",
    "low storage",
    "maintenance",
  ]
  instance_names = [
    "bar-db",
    "foo-db",
  ]
  sns_topic = "rds-notify"

  tags = {
    Service = "foobar"
  }
}
```

Argument Reference
-----------------

The following arguments are supported:

* `event_categories` - (Optional) List of event categories for a SourceType that you want to subscribe to. See [Working with Amazon RDS event notification](http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Events.html) or run `aws rds describe-event-categories`.

* `instance_names` - (Optional) List of database identifiers (RDS instance names) for which events will be returned; empty list specifies all databases in this account and region

* `tags` - (Optional) Tags to be applied to resources where supported

* `sns_topic` - (Required) Name of SNS topic to which events are published

Attributes Reference
--------------------

The following attributes are exported:

* `aws_db_event_subscription` - Amazon Resource Name of the reserved instance

* `sns_topic_arn` - SNS topic ARN
