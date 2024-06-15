# See also https://kaigionrails.esa.io/posts/451

resource "aws_vpc" "main_usw2" {
  cidr_block = "10.40.192.0/18"

  assign_generated_ipv6_cidr_block = true
  enable_dns_support               = true
  enable_dns_hostnames             = true

  tags = {
    Name = "kaigionrails-usw2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_usw2.id

  tags = {
    Name = "kor-usw2-igw"
  }
}

resource "aws_egress_only_internet_gateway" "eigw" {
  vpc_id = aws_vpc.main_usw2.id
}

resource "aws_subnet" "c_public" {
  availability_zone               = "us-west-2c"
  vpc_id                          = aws_vpc.main_usw2.id
  cidr_block                      = "10.40.192.0/21"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.main_usw2.ipv6_cidr_block, 8, 192)
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = true

  tags = {
    Name = "kor-usw2-c-public"
  }
}

resource "aws_subnet" "c_private" {
  availability_zone               = "us-west-2c"
  vpc_id                          = aws_vpc.main_usw2.id
  cidr_block                      = "10.40.200.0/21"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.main_usw2.ipv6_cidr_block, 8, 193)
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = false

  tags = {
    Name = "kor-usw2-c-private"
  }
}

resource "aws_subnet" "d_public" {
  availability_zone               = "us-west-2d"
  vpc_id                          = aws_vpc.main_usw2.id
  cidr_block                      = "10.40.208.0/21"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.main_usw2.ipv6_cidr_block, 8, 208)
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = true

  tags = {
    Name = "kor-usw2-d-public"
  }

}

resource "aws_subnet" "d_private" {
  availability_zone               = "us-west-2d"
  vpc_id                          = aws_vpc.main_usw2.id
  cidr_block                      = "10.40.216.0/21"
  ipv6_cidr_block                 = cidrsubnet(aws_vpc.main_usw2.ipv6_cidr_block, 8, 209)
  assign_ipv6_address_on_creation = true
  map_public_ip_on_launch         = false

  tags = {
    Name = "kor-usw2-d-private"
  }
}

locals {
  public_subnet_ids = {
    c = aws_subnet.c_public.id,
    d = aws_subnet.d_public.id,
  }
  private_subnet_ids = {
    c = aws_subnet.c_private.id,
    d = aws_subnet.d_private.id,
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.main_usw2.id
  tags = {
    Name = "kor-usw2-public"
  }
}

resource "aws_route" "public_v4_default" {
  route_table_id         = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "public_v6_default" {
  route_table_id              = aws_route_table.public_rtb.id
  destination_ipv6_cidr_block = "::/0"
  gateway_id                  = aws_internet_gateway.igw.id
}

resource "aws_route_table" "private_rtb" {
  vpc_id = aws_vpc.main_usw2.id
  tags = {
    Name = "kor-usw2-private"
  }
}

resource "aws_route" "private_v6_default" {
  route_table_id              = aws_route_table.private_rtb.id
  destination_ipv6_cidr_block = "::/0"
  egress_only_gateway_id      = aws_egress_only_internet_gateway.eigw.id
}

resource "aws_route_table_association" "public" {
  for_each       = local.public_subnet_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "private" {
  for_each       = local.private_subnet_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.private_rtb.id
}

resource "aws_vpn_gateway" "main_usw2" {
  vpc_id = aws_vpc.main_usw2.id

  tags = {
    Name = "kor-usw2-vpn-gw"
  }
}

resource "aws_vpn_gateway_route_propagation" "main_public" {
  vpn_gateway_id = aws_vpn_gateway.main_usw2.id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_vpn_gateway_route_propagation" "main_private" {
  vpn_gateway_id = aws_vpn_gateway.main_usw2.id
  route_table_id = aws_route_table.private_rtb.id
}
