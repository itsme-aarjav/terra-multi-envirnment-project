output "ec2_public_ips" {
  value = aws_instance.web_server[*].public_ip
}

output "nginx_urls" {
  value = [for ip in aws_instance.web_server[*].public_ip : "http://${ip}"]
}

output "s3_bucket_name" {
  value = aws_s3_bucket.app_bucket.id
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.app_table.name
}
