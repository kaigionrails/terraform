resource "aws_security_group" "cfp_app_cache" {
  name   = "cpf-app-cache"
  vpc_id = data.aws_vpc.kaigionrails_apne1.id
}

resource "aws_vpc_security_group_ingress_rule" "cfp_app_cache_inbound_from_apprunner" {
  security_group_id            = aws_security_group.cfp_app_cache.id
  from_port                    = 6379
  to_port                      = 6380
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.cfp_app_apprunner.id
}

resource "aws_vpc_security_group_ingress_rule" "cfp_app_cache_inbound_from_worker" {
  security_group_id            = aws_security_group.cfp_app_cache.id
  from_port                    = 6379
  to_port                      = 6380
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.cfp_app_worker.id
}

resource "aws_elasticache_serverless_cache" "cfp_app" {
  engine               = "valkey"
  name                 = "cfp-app"
  major_engine_version = 7
  security_group_ids   = [aws_security_group.cfp_app_cache.id]
  subnet_ids = [
    data.aws_subnet.kaigionrails_apne1_c_private.id,
    data.aws_subnet.kaigionrails_apne1_d_private.id,
  ]
}
