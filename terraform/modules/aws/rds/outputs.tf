output "identifier" {
  value = aws_db_instance.instance.identifier
}

output "address" {
  value = aws_db_instance.instance.address
}

output "db_name" {
  value = aws_db_instance.instance.db_name
}

output "port" {
  value = aws_db_instance.instance.port
}

# Managed via Secrets Manager
output "secret_arn" {
  value = aws_db_instance.instance.master_user_secret[0].secret_arn
}
