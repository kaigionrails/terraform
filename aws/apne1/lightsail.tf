resource "aws_lightsail_instance" "kaigionrails_apps" {
  name              = "kaigionrails-apps"
  availability_zone = "ap-northeast-1a"
  blueprint_id      = "ubuntu_24_04"
  bundle_id         = "medium_3_0"
  key_pair_name     = "kaigionrails-apps-pubkey"
  user_data         = file("${path.module}/lightsail_launch_script.sh")

  lifecycle {
    ignore_changes  = [user_data]
    prevent_destroy = true
  }
}

resource "aws_lightsail_static_ip" "kaigionrails_apps" {
  name = "kaigionrails-apps-static-ip"
}

resource "aws_lightsail_static_ip_attachment" "kaigionrails_apps" {
  static_ip_name = aws_lightsail_static_ip.kaigionrails_apps.name
  instance_name  = aws_lightsail_instance.kaigionrails_apps.name
}

resource "aws_lightsail_instance_public_ports" "kaigionrails_apps" {
  instance_name = aws_lightsail_instance.kaigionrails_apps.name

  port_info {
    protocol   = "tcp"
    from_port  = 9922
    to_port    = 9922
    cidrs      = ["0.0.0.0/0"]
    ipv6_cidrs = ["::/0"]
  }

  port_info {
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    cidrs      = ["0.0.0.0/0"]
    ipv6_cidrs = ["::/0"]
  }

  port_info {
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    cidrs      = ["0.0.0.0/0"]
    ipv6_cidrs = ["::/0"]
  }
}


resource "aws_lightsail_database" "kaigionrails_apps" {
  relational_database_name = "kaigionrails-apps-db"
  blueprint_id             = "postgres_18"
  bundle_id                = "micro_2_0"
  master_database_name     = "dbmaster"
  master_username          = "dbmasteruser"
  master_password          = "PLACEHOLDER"
  availability_zone        = "ap-northeast-1a"
  publicly_accessible      = false
  skip_final_snapshot      = true
  final_snapshot_name      = "kaigionrails-apps-db-final"

  lifecycle {
    ignore_changes  = [master_password]
    prevent_destroy = true
  }
}
