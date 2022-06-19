# Creating networking for the project 
resource "aws_vpc" "Project4_VPC" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Project_4_VPC"
  }

}

# Project Public Subnet 1 
resource "aws_subnet" "Project4_Public_Sub1" {
  vpc_id            = aws_vpc.Project4_VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "Project4_Public_Sub1"
  }

}

# Project Public Subnet  
resource "aws_subnet" "Project4_Public_Sub2" {
  vpc_id            = aws_vpc.Project4_VPC.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "Project4_Public_Sub2"
  }

}

# Internet Gateway 
resource "aws_internet_gateway" "Project4_igw" {
  vpc_id = aws_vpc.Project4_VPC.id

  tags = {
    Name = "Project4_igw"
  }

}# Route table 

resource "aws_route_table" "project4-route-table" {
  vpc_id = aws_vpc.Project4_VPC.id

  tags = {
    Name = "project4-route-table"
  }
}

# Associate public subnet1 with the route table 

resource "aws_route_table_association" "sub1_route_assoc" {

  subnet_id = aws_subnet.Project4_Public_Sub1.id

  route_table_id = aws_route_table.project4-route-table.id

}

# Associate public subnet2 with the route table 

resource "aws_route_table_association" "sub2_route_assoc" {

  subnet_id = aws_subnet.Project4_Public_Sub2.id

  route_table_id = aws_route_table.project4-route-table.id

}

# Associate the internet gateway to the public route table 

resource "aws_route" "project4_IGW_route_assoc" {

  route_table_id = aws_route_table.project4-route-table.id

  gateway_id = aws_internet_gateway.Project4_igw.id

  destination_cidr_block = "0.0.0.0/0"
}





