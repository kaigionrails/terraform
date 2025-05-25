resource "aws_rds_cluster" "cfp_app_apne1" {
  cluster_identifier          = "cfp-app"
  engine                      = "aurora-postgresql"
  engine_version              = "14.17"
  master_username             = "postgres"
  manage_master_user_password = true
  db_subnet_group_name        = data.aws_db_subnet_group.kaigionrails_apne1_private.name
  apply_immediately           = true
  network_type                = "DUAL"
  skip_final_snapshot         = true # tmp
  vpc_security_group_ids      = [aws_security_group.cfp_app_db.id]

  serverlessv2_scaling_configuration {
    min_capacity = 0
    max_capacity = 1
  }
}

resource "aws_rds_cluster_instance" "cfp_app_apne1" {
  cluster_identifier   = aws_rds_cluster.cfp_app_apne1.id
  count                = 1
  identifier           = "cfp-app-1"
  engine               = aws_rds_cluster.cfp_app_apne1.engine
  engine_version       = aws_rds_cluster.cfp_app_apne1.engine_version
  instance_class       = "db.serverless"
  apply_immediately    = true
  db_subnet_group_name = data.aws_db_subnet_group.kaigionrails_apne1_private.name
}

resource "aws_security_group" "cfp_app_db" {
  name   = "cfp-app-db"
  vpc_id = data.aws_vpc.kaigionrails_apne1.id
}

resource "aws_vpc_security_group_ingress_rule" "cfp_app_db_inbound_from_apprunner" {
  security_group_id            = aws_security_group.cfp_app_db.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.cfp_app_apprunner.id
}

resource "aws_vpc_security_group_ingress_rule" "cfp_app_db_inbound_from_worker" {
  security_group_id            = aws_security_group.cfp_app_db.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.cfp_app_worker.id
}
