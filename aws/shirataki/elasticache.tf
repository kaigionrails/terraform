resource "aws_security_group" "shirataki_cache" {
  name   = "shirataki-cache"
  vpc_id = data.aws_vpc.kaigionrails_apne1.id
}

resource "aws_vpc_security_group_ingress_rule" "shirataki_cache_inbound_from_ec2" {
  security_group_id            = aws_security_group.shirataki_cache.id
  from_port                    = 6379
  to_port                      = 6380
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.shirataki_ec2.id
}


data "aws_elasticache_subnet_group" "kaigionrails_apne1_private" {
  name = "kaigionrails-apne1-private"
}

resource "aws_elasticache_serverless_cache" "shirataki_staging" {
  engine               = "valkey"
  name                 = "shirataki-staging"
  major_engine_version = 7
  security_group_ids   = [aws_security_group.shirataki_cache.id]
  subnet_ids = [
    data.aws_subnet.kaigionrails_apne1_c_private.id,
    data.aws_subnet.kaigionrails_apne1_d_private.id,
  ]
}

resource "aws_elasticache_serverless_cache" "shirataki_production" {
  engine               = "valkey"
  name                 = "shirataki-production"
  major_engine_version = 7
  security_group_ids   = [aws_security_group.shirataki_cache.id]
  subnet_ids = [
    data.aws_subnet.kaigionrails_apne1_c_private.id,
    data.aws_subnet.kaigionrails_apne1_d_private.id,
  ]
}
