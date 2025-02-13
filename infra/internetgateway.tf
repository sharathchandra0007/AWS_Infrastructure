resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "igw"
  }

}

resource "aws_route_table" "web_router" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "Pubic-route"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "web_associate" {
  count          = local.web_subnets_count
  subnet_id      = aws_subnet.web[count.index].id
  route_table_id = aws_route_table.web_router.id

}

resource "aws_route_table" "db_router" {
  vpc_id = aws_vpc.base.id
  tags = {
    Name = "private-route"
  }

}

resource "aws_route_table_association" "db_associate" {
  count          = local.db_subnets_count
  subnet_id      = aws_subnet.db[count.index].id
  route_table_id = aws_route_table.db_router.id

}