# Create an Application Load Balancer

resource "aws_lb" "proj8_alb" {
  name               = "proj8-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.proj8_SG.id]
  subnets            = [aws_subnet.proj8_web_1.id, aws_subnet.proj8_web_2.id]

  enable_deletion_protection = false

}


# ALB Target Group

resource "aws_lb_target_group" "project8_TG" {
  name     = "project8-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.project8_vpc.id
}
