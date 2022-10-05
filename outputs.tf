output "arn" {
  description = "Instance ARN"
  value       = aws_db_instance.default.arn
}

output "db_name" {
  description = "Instance name"
  value       = aws_db_instance.default.db_name
}

output "endpoint" {
  description = "Instance endpoint"
  value       = aws_db_instance.default.endpoint
}

output "hostname" {
  description = "Instance hostname"
  value       = aws_db_instance.default.address
}

output "username" {
  description = "Master username"
  value       = aws_db_instance.default.username
}
