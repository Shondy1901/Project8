resource "aws_security_group" "proj8_SG" {
  name        = "proj8_SG"
  description = "Enable HTTP access on port 80"
  vpc_id      = aws_vpc.project8_vpc.id 

  ingress {
    description      = "Allow HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "proj8_SG"
  }
}