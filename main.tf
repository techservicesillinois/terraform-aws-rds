locals {
  final_snapshot_identifier = "${var.final_snapshot_identifier != "" ? var.final_snapshot_identifier : format("%s-FINAL", var.identifier)}"
  security_group_names      = "${compact(split(" ", var.security_group_names))}"

  # TODO: Rethink how to make restoring from snapshot and destroying with snapshot
  # more foolproof.
  # snapshot_identifier = "${var.snapshot_identifier != "" ? var.snapshot_identifier : format("%s", var.identifier)}"
}

data "aws_security_group" "selected" {
  count = "${length(local.security_group_names)}"
  name  = "${local.security_group_names[count.index]}"
}

resource "aws_db_instance" "default" {
  allocated_storage                   = "${var.allocated_storage}"
  allow_major_version_upgrade         = "${var.allow_major_version_upgrade}"
  apply_immediately                   = "${var.apply_immediately}"
  auto_minor_version_upgrade          = "${var.auto_minor_version_upgrade}"
  availability_zone                   = "${var.availability_zone}"
  backup_retention_period             = "${var.backup_retention_period}"
  backup_window                       = "${var.backup_window}"
  character_set_name                  = "${var.character_set_name}"
  copy_tags_to_snapshot               = "${var.copy_tags_to_snapshot}"
  db_subnet_group_name                = "${var.db_subnet_group_name}"
  deletion_protection                 = "${var.deletion_protection}"
  enabled_cloudwatch_logs_exports     = "${var.enabled_cloudwatch_logs_exports}"
  engine                              = "${var.engine}"
  engine_version                      = "${var.engine_version}"
  final_snapshot_identifier           = "${local.final_snapshot_identifier}"
  iam_database_authentication_enabled = "${var.iam_database_authentication_enabled}"
  identifier                          = "${var.identifier}"
  instance_class                      = "${var.instance_class}"
  iops                                = "${var.iops}"
  kms_key_id                          = "${var.kms_key_id}"
  license_model                       = "${var.license_model}"
  maintenance_window                  = "${var.maintenance_window}"

  # monitoring_interval                 = "${var.monitoring_interval}"
  # monitoring_role_arn                 = "${coalesce(var.monitoring_role_arn, join("", aws_iam_role.enhanced_monitoring.*.arn))}"
  multi_az = "${var.multi_az}"

  name                 = "${var.name}"
  option_group_name    = "${var.option_group_name}"
  parameter_group_name = "${var.parameter_group_name}"
  password             = "${var.password}"
  port                 = "${var.port}"
  publicly_accessible  = "${var.publicly_accessible}"
  replicate_source_db  = "${var.replicate_source_db}"
  skip_final_snapshot  = "${var.skip_final_snapshot}"
  snapshot_identifier  = "${var.snapshot_identifier}"
  storage_encrypted    = "${var.storage_encrypted}"
  storage_type         = "${var.storage_type}"
  tags                 = "${merge(map("Name", var.identifier), var.tags)}"
  timeouts             = "${var.timeouts}"
  username             = "${var.username}"

  # Database password is established on creation. It should be changed IMMEDIATELY,
  # and should be maintained in Amazon SSM so that the initial password stored
  # in Terraform's state file is no longer usable. Similarly, we do *NOT* want
  # Terraform to downgrade database instances after `auto_minor_version_upgrade`
  # has done its work.

  lifecycle {
    ignore_changes = ["engine_version", "password"]
  }
  # Calculated from "security_group_names" variable
  vpc_security_group_ids = ["${data.aws_security_group.selected.*.id}"]
}
