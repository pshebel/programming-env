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

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.programming.id

  tags = {
    Name = "programming IGW"
  }
}


# IGW route table
resource "aws_route_table" "igw-rt" {
  vpc_id = aws_vpc.programming.id


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "IGW RT"
  }
}

# Management Subnet association with IGW route table
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.programming.id
  route_table_id = aws_route_table.igw-rt.id
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


data "aws_ami" "debian" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-12-amd64-*"]
  }

  owners = ["136693071363"] # Debian
}

data "aws_ebs_volume" "programming" {
  filter {
    name   = "tag:Name"
    values = ["programming"]
  }
}

resource "aws_volume_attachment" "programming-ebs" {
  device_name = "/dev/sdd"
  volume_id = data.aws_ebs_volume.programming.id
  instance_id = aws_instance.programming.id
}

resource "aws_instance" "programming" {
  ami           = data.aws_ami.debian.id
  instance_type = "t3.nano"
  vpc_security_group_ids = [aws_security_group.programming-sg.id]
  subnet_id              = aws_subnet.programming.id
  key_name = "programming"
  tags = {
    Name = "programming"
  }
}



