resource "aws_security_group" "cfp_app_worker" {
  vpc_id = data.aws_vpc.kaigionrails_apne1.id
  name   = "cfp-app-worker"
}

resource "aws_vpc_security_group_ingress_rule" "cfp_app_worker_ingress_self" {
  security_group_id            = aws_security_group.cfp_app_worker.id
  referenced_security_group_id = aws_security_group.cfp_app_worker.id
  ip_protocol                  = -1
}

resource "aws_vpc_security_group_egress_rule" "cfp_app_worker_egress_to_internet_v4" {
  security_group_id = aws_security_group.cfp_app_worker.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = -1
}

resource "aws_vpc_security_group_egress_rule" "cfp_app_worker_egress_to_internet_v6" {
  security_group_id = aws_security_group.cfp_app_worker.id
  cidr_ipv6         = "::/0"
  ip_protocol       = -1
}
