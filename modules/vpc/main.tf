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
  locale = data.aws_region.current.name
  
}

resource "aws_vpc_ipam_pool_cidr" "school-ipam-pool-cidr" {
  ipam_pool_id = aws_vpc_ipam_pool.school-ipam-pool.id
  cidr         = var.vpc_cidr_pool
}

resource "aws_vpc" "main" {
  ipv4_ipam_pool_id   = aws_vpc_ipam_pool.school-ipam-pool.id
  ipv4_netmask_length = 28
  depends_on = [
    aws_vpc_ipam_pool_cidr.school-ipam-pool-cidr
  ]
}