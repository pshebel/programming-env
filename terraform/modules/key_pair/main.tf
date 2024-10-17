
resource "aws_key_pair" "programming" {
  key_name   = "programming"
  public_key = var.public_key
}

