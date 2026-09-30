resource "aws_s3_bucket" "app_bucket" {
  bucket_prefix = "${var.project_name}-${var.environment}-"

  tags = {
    Name        = "${var.project_name}-${var.environment}-bucket"
    Environment = var.environment
  }
}
