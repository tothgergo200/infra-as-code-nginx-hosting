resource "aws_s3_bucket" "main" {
    bucket = "tg-nginx-assets"

    tags = {
        Name        = "nginx-assets-bucket"
    }
}

resource "aws_s3_object" "index_file" {
    bucket = aws_s3_bucket.main.bucket
    key    = "index.html"
    source = "${path.module}/index.html"
    content_type = "text/html"
}

