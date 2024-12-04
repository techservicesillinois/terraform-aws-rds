data "aws_db_instances" "selected" {
  # If var.instance_names is null, omit filter, matching all RDS instances.
  for_each = toset(var.instance_names != null ? [""] : [])
  filter {
    name   = "db-instance-id"
    values = var.instance_names
  }
}

# Retrieve existing RDS event by name.

data "aws_sns_topic" "selected" {
  name = var.sns_topic
}

# TODO: This creates one subscription per RDS resource; if we're satisfied
# with a single subscription name, we can bunch all resources into a
# single subscription. This is a choice between simplicity and robustness.

resource "aws_db_event_subscription" "default" {
  for_each = toset(data.aws_db_instances.selected[""].instance_identifiers)

  event_categories = var.event_categories
  name             = format("rds-event-%s", each.key)
  sns_topic        = data.aws_sns_topic.selected.arn
  source_type      = "db-instance"
  source_ids       = [each.key]
  tags             = merge({ Name = each.key }, var.tags)
}
