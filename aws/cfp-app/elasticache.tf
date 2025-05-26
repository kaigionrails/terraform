resource "aws_security_group" "cfp_app_cache" {
  name   = "cfp-app-cache"
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

# serverless valkey uses cluster mode but sidekiq not support cluster mode
# resource "aws_elasticache_serverless_cache" "cfp_app" {
#   engine               = "valkey"
#   name                 = "cfp-app"
#   major_engine_version = 7
#   security_group_ids   = [aws_security_group.cfp_app_cache.id]
#   subnet_ids = [
#     data.aws_subnet.kaigionrails_apne1_c_private.id,
#     data.aws_subnet.kaigionrails_apne1_d_private.id,
#   ]
# }

data "aws_elasticache_subnet_group" "kaigionrails_apne1_private" {
  name = "kaigionrails-apne1-private"
}

# Hikkoshi is interrupted
# resource "aws_elasticache_replication_group" "cfp_app" {
#   replication_group_id = "cfp-app-singlemode"
#   description          = "cache for cfp-app, single mode"
#   engine               = "valkey"
#   engine_version       = "7.2"
#   cluster_mode         = "disabled"
#   node_type            = "cache.t2.micro"
#   apply_immediately    = true
#   security_group_ids   = [aws_security_group.cfp_app_cache.id]
#   subnet_group_name    = data.aws_elasticache_subnet_group.kaigionrails_apne1_private.name
# }
