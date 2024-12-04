# TODO: Keep for debugging?
#output "zzzzz" {
# value = aws_db_event_subscription.default
# }

output "aws_db_event_subscription" {
  value = { for name, sub in aws_db_event_subscription.default : name => sub.arn }
}

output "sns_topic_arn" {
  value = data.aws_sns_topic.selected.arn
}
