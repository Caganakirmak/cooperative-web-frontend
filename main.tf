terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

# ─── MEVCUT VPC (import edilecek) ───────────────────────────────────────────
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "cooperative-web-server-vpc"
  }
}

# ─── MEVCUT PUBLIC SUBNET (import edilecek) ──────────────────────────────────
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.0.0/20"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "cooperative-web-server-subnet-public1-eu-north-1a"
  }
}

# ─── YENİ PRIVATE SUBNET ─────────────────────────────────────────────────────
resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.128.0/20"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "cooperative-web-server-subnet-private1-eu-north-1a"
  }
}

# ─── INTERNET GATEWAY ────────────────────────────────────────────────────────
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "cooperative-web-server-igw"
  }
}

# ─── PUBLIC ROUTE TABLE ──────────────────────────────────────────────────────
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "cooperative-web-server-rt-public"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# ─── PRIVATE ROUTE TABLE (internet yok) ─────────────────────────────────────
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "cooperative-web-server-rt-private"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

# ─── SECURITY GROUP ──────────────────────────────────────────────────────────
resource "aws_security_group" "web_sg" {
  name        = "cooperative-web-sg"
  description = "Allow HTTP, HTTPS and SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cooperative-web-sg"
  }
}

# ─── MEVCUT EC2 INSTANCE (import edilecek) ───────────────────────────────────
resource "aws_instance" "web" {
  ami                    = "ami-0b5a4e51202cd98e5" # Amazon Linux 2023 eu-north-1
  instance_type          = "t3.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  key_name               = "cooperative-web-server-key"
  user_data = file("user_data.sh")

  tags = {
    Name = "cooperative-web-server"
  }
}

# ─── S3 BUCKET (storage - actual data) ──────────────────────────────────────
resource "aws_s3_bucket" "farmer_data" {
  bucket = "cooperative-farmer-data-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name = "cooperative-farmer-data"
  }
}

resource "aws_s3_bucket_versioning" "farmer_data" {
  bucket = aws_s3_bucket.farmer_data.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "farmer_data" {
  bucket                  = aws_s3_bucket.farmer_data.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ─── DATA SOURCES ────────────────────────────────────────────────────────────
data "aws_caller_identity" "current" {}

# ─── OUTPUTS ─────────────────────────────────────────────────────────────────
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id" {
  value = aws_subnet.private.id
}

output "ec2_public_ip" {
  value = aws_instance.web.public_ip
}

output "s3_bucket_name" {
  value = aws_s3_bucket.farmer_data.bucket
}
