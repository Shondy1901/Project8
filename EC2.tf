# Create EC2 Instance


resource "aws_instance" "proj8_EC2" {
  ami           = "ami-0d37e07bd4ff37148"
  instance_type = "t2.micro"
  #security_groups = ["proj8_SG"]
  vpc_security_group_ids = [aws_security_group.proj8_SG.id]
  subnet_id = aws_subnet.proj8_web_2.id

  tags = {
    Name = "proj8_EC2"
  }
}