resource "aws_ebs_volume" "programming" {
  availability_zone = "us-east-1a"
  size              = 20

  tags = {
    Name = "programming"
  }
}