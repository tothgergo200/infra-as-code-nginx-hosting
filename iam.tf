resource "aws_iam_role" "ec2_s3_access_role" {
  name = "ec2-s3-access-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "ec2-s3-access-role"
  }
}

resource "aws_iam_policy" "s3_read_policy" {
  name        = "s3-read-policy"
  description = "Allow EC2 to read from tg-nginx-assets bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "Statement1",
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::tg-nginx-assets",
          "arn:aws:s3:::tg-nginx-assets/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_s3_policy" {
    role       = aws_iam_role.ec2_s3_access_role.name
    policy_arn = aws_iam_policy.s3_read_policy.arn
}

resource "aws_iam_instance_profile" "ec2_instance_profile" { # ez megy az EC2-nek
    name = "ec2-instance-profile"
    role = aws_iam_role.ec2_s3_access_role.name
}



