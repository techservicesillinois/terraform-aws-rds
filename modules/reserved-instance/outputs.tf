output "arn" {
  value = aws_rds_reserved_instance.default.arn
}

output "lease_id" {
  value = aws_rds_reserved_instance.default.lease_id
}

output "offering_id" {
  value = aws_rds_reserved_instance.default.offering_id
}
