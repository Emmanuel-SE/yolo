locals {
  vpc_id           = "vpc-0e0ce94ded44cf75a"
  subnet_id        = "subnet-01ccda142aded42d2"
  ssh_user         = "ubuntu"
  key_name         = "yolo"
  private_key_path = "~/Downloads/yolo.pem"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "yolo_sg" {
  name        = "yolo_sg"
  description = "Security group for the EC2 instances"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5001
    to_port     = 5001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "yolo_sg"
  }
}

resource "aws_instance" "yolo_server" {
  ami             = "ami-0cd59ecaf368e5ccf"  # Ubuntu AMI
  instance_type   = "t2.micro"
  key_name        = local.key_name
  security_groups = [aws_security_group.yolo_sg.name]

  tags = {
    Name = "yolo_server"
  }
}
