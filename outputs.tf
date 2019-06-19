output "address" {
  description = "Address of the RDS instance"
  value       = "${aws_db_instance.default.address}"
}

output "arn" {
  description = "ARN of the RDS instance"
  value       = "${aws_db_instance.default.arn}"
}

output "name" {
  description = "Database instance name"
  value       = "${aws_db_instance.default.name}"
}

output "username" {
  description = "Database username"
  value       = "${aws_db_instance.default.username}"
}
