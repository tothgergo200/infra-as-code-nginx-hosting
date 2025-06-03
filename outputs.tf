output "ec2_public_ip" {
    description = "Public IP of the EC2 instance"
    value       = aws_instance.web_server.public_ip
}

output "s3_bucket_name" {
    description = "S3 bucket name"
    value       = aws_s3_bucket.main.bucket
}
