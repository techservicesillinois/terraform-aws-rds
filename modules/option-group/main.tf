locals {
  og_description = (var.description != null) ? var.description : format("%s option group", local.og_name)
  og_name        = format("%s-%s-%s", var.engine, replace(var.engine_version, ".", "-"), var.name_suffix)
}

# todo: module should allow a separate VPC security group to be supplied
# for each option
data "aws_security_group" "selected" {
  for_each = toset(var.security_group_names)
  name     = each.key
}

resource "aws_db_option_group" "default" {
  name                     = local.og_name
  option_group_description = local.og_description
  engine_name              = var.engine
  major_engine_version     = var.engine_version
  tags                     = merge({ Name = var.name_suffix }, var.tags)

  dynamic "option" {
    for_each = toset(var.option != null ? var.option : [])

    content {
      option_name                    = option.value.option_name
      port                           = option.value.port
      version                        = option.value.version
      vpc_security_group_memberships = [for sg in data.aws_security_group.selected : sg.id]

      dynamic "option_settings" {
        for_each = toset(option.value.option_settings != null ? option.value.option_settings : [])

        content {
          name  = option_settings.value.name
          value = option_settings.value.value
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = toset(var.timeouts != null ? [var.timeouts] : [])

    content {
      delete = timeouts.value.delete
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}
