resource "aws_s3_bucket" "main" {
  bucket = "tg-nginx-assets"

  tags = {
    Name        = "nginx-assets-bucket"
  }
}