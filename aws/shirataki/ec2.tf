resource "aws_security_group" "shirataki_ec2" {
  name   = "shirataki-ec2"
  vpc_id = data.aws_vpc.kaigionrails_apne1.id
}

resource "aws_vpc_security_group_ingress_rule" "shirataki_ec2_inbound_from_internet_v4_rtmp" {
  security_group_id = aws_security_group.shirataki_ec2.id
  from_port         = 1935
  to_port           = 1935
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "shirataki_ec2_inbound_from_internet_v6_rtmp" {
  security_group_id = aws_security_group.shirataki_ec2.id
  from_port         = 1935
  to_port           = 1935
  ip_protocol       = "tcp"
  cidr_ipv6         = "::/0"
}

resource "aws_vpc_security_group_ingress_rule" "shirataki_ec2_inbound_from_alb_to_falcon" {
  security_group_id            = aws_security_group.shirataki_ec2.id
  referenced_security_group_id = aws_security_group.shirataki_lb_staging.id
  from_port                    = 4000
  to_port                      = 4000
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "shirataki_ec2_egress_to_internet_v4" {
  security_group_id = aws_security_group.shirataki_ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}

resource "aws_vpc_security_group_egress_rule" "shirataki_ec2_egress_to_internet_v6" {
  security_group_id = aws_security_group.shirataki_ec2.id
  cidr_ipv6         = "::/0"
  ip_protocol       = -1
}

resource "aws_security_group" "shirataki_lb_staging" {
  name   = "shirataki-lb-staging"
  vpc_id = data.aws_vpc.kaigionrails_apne1.id
}

resource "aws_vpc_security_group_ingress_rule" "shirataki_lb_staging_inbound_from_internet_v4_http" {
  security_group_id = aws_security_group.shirataki_lb_staging.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "shirataki_lb_staging_inbound_from_internet_v4_https" {
  security_group_id = aws_security_group.shirataki_lb_staging.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "shirataki_lb_staging_inbound_from_internet_v6_http" {
  security_group_id = aws_security_group.shirataki_lb_staging.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv6         = "::/0"
}

resource "aws_vpc_security_group_ingress_rule" "shirataki_lb_staging_inbound_from_internet_v6_https" {
  security_group_id = aws_security_group.shirataki_lb_staging.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv6         = "::/0"
}

resource "aws_vpc_security_group_egress_rule" "shirataki_lb_staging_outbound_to_falcon" {
  security_group_id            = aws_security_group.shirataki_lb_staging.id
  referenced_security_group_id = aws_security_group.shirataki_ec2.id
  from_port                    = 4000
  to_port                      = 4000
  ip_protocol                  = "tcp"
}

resource "aws_lb" "shirataki_staging" {
  name               = "shirataki-staging"
  internal           = false
  load_balancer_type = "application"
  ip_address_type    = "dualstack"
  security_groups = [
    aws_security_group.shirataki_lb_staging.id
  ]
  subnets = [
    data.aws_subnet.kaigionrails_apne1_c_public.id,
    data.aws_subnet.kaigionrails_apne1_d_public.id,
  ]

  enable_deletion_protection = true

  access_logs {
    bucket  = data.aws_s3_bucket.kaigionrails_logs.id
    prefix  = "shirataki/staging"
    enabled = true
  }
}

resource "aws_lb_target_group" "shirataki_staging" {
  name        = "shirataki-staging"
  port        = 4000
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.kaigionrails_apne1.id
  target_type = "instance"

  health_check {
    enabled             = true
    interval            = 15
    path                = "/health"
    port                = 4000
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
}

resource "aws_acm_certificate" "shirataki_staging" {
  domain_name       = "shirataki-staging.kaigionrails.org"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener" "shirataki_staging_http" {
  load_balancer_arn = aws_lb.shirataki_staging.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.shirataki_staging.arn
  }
}


resource "aws_lb_listener" "shirataki_staging_https" {
  load_balancer_arn = aws_lb.shirataki_staging.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  certificate_arn   = aws_acm_certificate.shirataki_staging.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.shirataki_staging.arn
  }
}
