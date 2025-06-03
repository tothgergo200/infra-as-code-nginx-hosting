resource "aws_vpc" "main" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
        Name = "main-vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id                  = aws_vpc.main.id
    cidr_block              = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone       = "${var.aws_region}a"

    tags = {
        Name = "public-subnet"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "main-igw"
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id

    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags{
        Name = "main-route-table"
    }
}

resource "aws_route_table_association" "public_assoc" {
    subnet_id      = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public.id
}

resource "aws_instance" "web_server" {
    ami                    = "ami-09026d3b7b3b40436"
    instance_type          = var.instance_type
    subnet_id              = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.web_sg.id]
    key_name               = var.key_name

    iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
    associate_public_ip_address = true

    user_data = <<-EOF
                #!/bin/bash
                apt update -y
                apt install -y nginx awscli

                systemctl start nginx
                systemctl enable nginx

                aws s3 cp s3://${aws_s3_bucket.main.bucket}/index.html /var/www/html/index.html
                EOF

    tags = {
        Name = "nginx-ec2"
    }
}




