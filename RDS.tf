# RDS

resource "aws_db_instance" "proj8_DB" {
  allocated_storage    = 12
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "project8"
  password             = "password"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.proj8_Sub_Group.id
  
}

#DB Subnet Group

resource "aws_db_subnet_group" "proj8_Sub_Group" {
  name       = "project sub group"
  subnet_ids = [aws_subnet.proj8_dtb_1.id, aws_subnet.proj8_dtb_2.id]

  tags = {
    Name = "proj8 sub group"
  }
}

# DB Security Instance

resource "aws_security_group" "proj8_db_sg" {
  name        = "proj8_db_sg"
  description = "Allow http inbound traffic"
  vpc_id      = aws_vpc.project8_vpc.id 

  ingress {
    description      = "HTTP from VPC"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  tags = {
    Name = "proj8_db_sg"
  }
}