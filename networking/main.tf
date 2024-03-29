#-- networking/main.tf ---
data "aws_availability_zones" "available" {}

#--- VPC 1

resource "aws_vpc" "vpc1" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { 
    name = format("%s_vpc1", var.project_name)
    project_name = var.project_name
  }
}

resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id

  tags = { 
    name = format("%s_igw1", var.project_name)
    project_name = var.project_name
  }
}

resource "aws_subnet" "subpub1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.1.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  
  tags = { 
    name = format("%s_subpub1", var.project_name)
    project_name = var.project_name
  }
}

# Public route table, allows all outgoing traffic to go the the internet gateway.
# https://www.terraform.io/docs/providers/aws/r/route_table.html?source=post_page-----1a7fb9a336e9----------------------
resource "aws_route_table" "rtpub1" {
  vpc_id = "${aws_vpc.vpc1.id}"
  route {
    cidr_block = "10.0.0.0/8"
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  }  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw1.id}"
  }
  tags = {
    name = format("%s_rtpub1", var.project_name)
    project_name = var.project_name
  }
  depends_on = ["aws_ec2_transit_gateway.tgw"]  
}

# Main Route Tables Associations
## Forcing our Route Tables to be the main ones for our VPCs,
## otherwise AWS automatically will create a main Route Table
## for each VPC, leaving our own Route Tables as secondary
resource "aws_main_route_table_association" "rtpub1assoc" {
  vpc_id         = aws_vpc.vpc1.id
  route_table_id = aws_route_table.rtpub1.id
}

resource "aws_security_group" "sgpub1" {
  name        = "sgpub1"
  description = "Used for access to the public instances"
  vpc_id      = aws_vpc.vpc1.id
  ingress { # allow ping
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0 # the ICMP type number for 'Echo Reply'
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { 
    name = format("%s_sgpub1", var.project_name)
    project_name = var.project_name
  }
}


#--- VPC 2

resource "aws_vpc" "vpc2" {
  cidr_block           = "10.2.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = { 
    name = format("%s_vpc2", var.project_name)
    project_name = var.project_name
  }
}

resource "aws_internet_gateway" "igw2" {
  vpc_id = aws_vpc.vpc2.id

  tags = { 
    name = format("%s_igw2", var.project_name)
    project_name = var.project_name
  }
}

resource "aws_subnet" "subpub2" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = "10.2.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]
  
  tags = { 
    name = format("%s_subpub2", var.project_name)
    project_name = var.project_name
  }
}

# Public route table, allows all outgoing traffic to go the the internet gateway.
# https://www.terraform.io/docs/providers/aws/r/route_table.html?source=post_page-----1a7fb9a336e9----------------------
resource "aws_route_table" "rtpub2" {
  vpc_id = "${aws_vpc.vpc2.id}"
  route {
    cidr_block = "10.0.0.0/8"
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  }  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw2.id}"
  }
  tags = {
    name = format("%s_rtpub2", var.project_name)
    project_name = var.project_name
  }
  depends_on = ["aws_ec2_transit_gateway.tgw"]  
}

# Main Route Tables Associations
## Forcing our Route Tables to be the main ones for our VPCs,
## otherwise AWS automatically will create a main Route Table
## for each VPC, leaving our own Route Tables as secondary
resource "aws_main_route_table_association" "rtpub2assoc" {
  vpc_id         = aws_vpc.vpc2.id
  route_table_id = aws_route_table.rtpub2.id
}

resource "aws_security_group" "sgpub2" {
  name        = "sgpub2"
  description = "Used for access to the public instances"
  vpc_id      = aws_vpc.vpc2.id
  ingress { # allow ping
    from_port = 8
    to_port = 0
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0 # the ICMP type number for 'Echo Reply'
    to_port     = 0 # the ICMP code
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress { # allow ssh
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress { # allow http
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { 
    name = format("%s_sgpub2", var.project_name)
    project_name = var.project_name
  }
}

## The default setup being a full mesh scenario where all VPCs can see every other
resource "aws_ec2_transit_gateway" "tgw" {
  description                     = "Transit Gateway in default setup connecting all attached VPCs in a full mesh"
  tags                            = {
    name = format("%s_tgw", var.project_name)
    project_name = var.project_name
  }
}
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-attachment-1" {
  subnet_ids         = [aws_subnet.subpub1.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.vpc1.id

  tags = { 
    name = format("%s_tgw-attachment-1", var.project_name)
    project_name = var.project_name
  }
}
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw-attachment-2" {
  subnet_ids         = [aws_subnet.subpub2.id]
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.vpc2.id

  tags = { 
    name = format("%s_tgw-attachment-2", var.project_name)
    project_name = var.project_name
  }
}
