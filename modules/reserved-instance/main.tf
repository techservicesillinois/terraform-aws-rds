data "aws_rds_reserved_instance_offering" "default" {
  db_instance_class   = var.db_instance_class
  duration            = var.duration
  multi_az            = var.multi_az
  offering_type       = var.offering_type
  product_description = var.product_description
}

resource "aws_rds_reserved_instance" "default" {
  instance_count = var.instance_count
  offering_id    = data.aws_rds_reserved_instance_offering.default.offering_id
  reservation_id = var.reservation_id
  tags           = merge({ Name = var.reservation_id }, var.tags)
  lifecycle {
    prevent_destroy = true
  }
}
