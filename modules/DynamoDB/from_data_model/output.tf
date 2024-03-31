output "table_arn" {
  value = aws_dynamodb_table.DynamoDBTable.arn
}

output "table_id" {
  value = aws_dynamodb_table.DynamoDBTable.id
}

output "table_stream_arn" {
  value = aws_dynamodb_table.DynamoDBTable.stream_arn
}
