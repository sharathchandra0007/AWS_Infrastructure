resource "aws_vpc" "base" {
  cidr_block = var.vpc_info.cidr_block

  tags = var.vpc_info.tags
}

resource "aws_subnet" "web" {
  count             = local.web_subnets_count
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.web_subnets[count.index].cidr_block
  availability_zone = var.web_subnets[count.index].availability_zone

  tags = var.web_subnets[count.index].tags

  depends_on = [aws_vpc.base]

}


resource "aws_subnet" "db" {
  count             = local.db_subnets_count
  vpc_id            = aws_vpc.base.id
  cidr_block        = var.db_subnets[count.index].cidr_block
  availability_zone = var.db_subnets[count.index].availability_zone

  tags = var.db_subnets[count.index].tags

  depends_on = [aws_vpc.base]
}

resource "aws_security_group" "web-sg" {
  name        = var.web_securitygroups.name
  description = var.web_securitygroups.description
  vpc_id      = aws_vpc.base.id
  tags        = var.web_securitygroups.tags
  depends_on  = [aws_vpc.base]

}

resource "aws_vpc_security_group_ingress_rule" "web_ingress" {
  count             = local.ingress_count
  from_port         = var.web_ingress[count.index].from_port
  to_port           = var.web_ingress[count.index].to_port
  ip_protocol       = var.web_ingress[count.index].ip_protocol
  cidr_ipv4         = local.anywhere
  security_group_id = aws_security_group.web-sg.id


}

resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.web-sg.id
  cidr_ipv4         = local.anywhere
  ip_protocol       = -1 # to specify all protocols.Note that if ip_protocol is set to -1, it translates to all protocols

}

resource "aws_security_group" "db-sg" {
  name        = var.db_securitygroups.name
  description = var.db_securitygroups.description
  vpc_id      = aws_vpc.base.id
  tags        = var.db_securitygroups.tags
  depends_on  = [aws_vpc.base]

}

resource "aws_vpc_security_group_egress_rule" "db_ingress" {
  from_port         = var.db_ingress.from_port
  to_port           = var.db_ingress.to_port
  ip_protocol       = var.db_ingress.ip_protocol
  cidr_ipv4         = local.anywhere
  security_group_id = aws_security_group.db-sg.id
}


