# VPC
resource "aws_vpc" "programming" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "programming"
  }
}

# subnet
resource "aws_subnet" "programming" {
  vpc_id     = aws_vpc.programming.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "programming"
  }
}

# programming Security Group
# Only allow ssh access
resource "aws_security_group" "programming-sg" {
  name        = "programming-sg"
  description = "Allow inbound traffic from ssh"
  vpc_id      = aws_vpc.programming.id


 ingress {
    description = "ssh"
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
    Name = "programming-sg"
  }
}

resource "aws_key_pair" "programming" {
  key_name   = "programming"
}

data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }

  owners = ["136693071363"] # Debian
}

resource "aws_ebs_volume" "programming" {
  availability_zone = "us-east-1a"
  size              = 40

  tags = {
    Name = "programming"
  }
}

resource "aws_instance" "programming" {
  ami           = data.aws_ami.debian.id
  ebs_block_device = aws_ebs_volume.programming.id  
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.programming-sg.id]
  subnet_id              = data.aws_subnet.programming-subnet.id
  key_name = "programming"
  tags = {
    Name = "programming"
  }
}



