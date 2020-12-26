resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"

  tags = {
    Name = "ssambi-vpc"
  }
}

resource "aws_subnet" "public_subnet_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.0/27"

  availability_zone = "us-east-1a"

  tags = {
    Name = "public_subnet_a"
  }
}

resource "aws_subnet" "public_subnet_c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.32/27"

  availability_zone = "us-east-1c"

  tags = {
    Name = "public_subnet_c"
  }
}

resource "aws_subnet" "private_subnet_was_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.64/27"

  availability_zone = "us-east-1a"

  tags = {
    Name = "private_subnet_was_a"
  }
}

resource "aws_subnet" "private_subnet_was_c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.128/27"

  availability_zone = "us-east-1c"

  tags = {
    Name = "private_subnet_was_c"
  }
}

resource "aws_subnet" "private_subnet_db_a" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.160/27"

  availability_zone = "us-east-1a"

  tags = {
    Name = "private_subnet_db_a"
  }
}

resource "aws_subnet" "private_subnet_db_c" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.0.192/27"

  availability_zone = "us-east-1c"

  tags = {
    Name = "private_subnet_db_c"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table" "private_route_table_a" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private_route_table_a"
  }
}

resource "aws_route_table" "private_route_table_c" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private_route_table_c"
  }
}

resource "aws_route_table_association" "route_table_association_public_subnet_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "route_table_association_public_subnet_c" {
  subnet_id      = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "route_table_association_private_subnet_was_a" {
  subnet_id      = aws_subnet.private_subnet_was_a.id
  route_table_id = aws_route_table.private_route_table_a.id
}

resource "aws_route_table_association" "route_table_association_private_subnet_was_c" {
  subnet_id      = aws_subnet.private_subnet_was_c.id
  route_table_id = aws_route_table.private_route_table_c.id
}

resource "aws_route_table_association" "route_table_association_private_subnet_db_a" {
  subnet_id      = aws_subnet.private_subnet_db_a.id
  route_table_id = aws_route_table.private_route_table_a.id
}

resource "aws_route_table_association" "route_table_association_private_subnet_db_c" {
  subnet_id      = aws_subnet.private_subnet_db_c.id
  route_table_id = aws_route_table.private_route_table_c.id
}

resource "aws_eip" "nat_eip_1" {
  vpc   = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "nat_eip_2" {
  vpc   = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat_gateway_a" {
  allocation_id = aws_eip.nat_eip_1.id

  subnet_id = aws_subnet.public_subnet_a.id

  tags = {
    Name = "NAT-GW-a"
  }
}

resource "aws_nat_gateway" "nat_gateway_c" {
  allocation_id = aws_eip.nat_eip_2.id

  subnet_id = aws_subnet.public_subnet_c.id

  tags = {
    Name = "NAT-GW-c"
  }
}

resource "aws_route" "public_route" {
  route_table_id              = aws_route_table.public_route_table.id
  destination_cidr_block      = "0.0.0.0/0"
  gateway_id                  = aws_internet_gateway.igw.id
}

resource "aws_route" "private_route_1" {
  route_table_id              = aws_route_table.private_route_table_a.id
  destination_cidr_block      = "0.0.0.0/0"
  nat_gateway_id              = aws_nat_gateway.nat_gateway_a.id
}

resource "aws_route" "private_route_2" {
  route_table_id              = aws_route_table.private_route_table_c.id
  destination_cidr_block      = "0.0.0.0/0"
  nat_gateway_id              = aws_nat_gateway.nat_gateway_c.id
}

