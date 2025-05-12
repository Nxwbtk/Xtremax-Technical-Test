data "aws_region" "current" {}



resource "aws_vpc_ipam" "school-ipam" {
  operating_regions {
    region_name = data.aws_region.current.name
  }
}

resource "aws_vpc_ipam_scope" "school-ipam-scope" {
  ipam_id = aws_vpc_ipam.school-ipam.id
}

resource "aws_vpc_ipam_pool" "school-ipam-pool" {
  address_family = "ipv4"
  ipam_scope_id  = aws_vpc_ipam_scope.school-ipam-scope.id
  locale         = data.aws_region.current.name
}

resource "aws_vpc_ipam_pool_cidr" "school-ipam-pool-cidr" {
  ipam_pool_id = aws_vpc_ipam_pool.school-ipam-pool.id
  cidr         = var.vpc_cidr_pool
}

resource "aws_vpc" "main" {
  ipv4_ipam_pool_id   = aws_vpc_ipam_pool.school-ipam-pool.id
  ipv4_netmask_length = 16
  depends_on = [
    aws_vpc_ipam_pool_cidr.school-ipam-pool-cidr
  ]
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_cidr_block
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  depends_on    = [aws_internet_gateway.igw]
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
