# Configure the Virtual Private Cloud

resource "aws_vpc" "project8_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "project8_vpc"
  }
}

# Create Web Subnet-1

resource "aws_subnet" "proj8_web_1" {
  vpc_id     = aws_vpc.project8_vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-west-2a"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "proj8_web_1"
  }
}


# Create Web Subnet-2

resource "aws_subnet" "proj8_web_2" {
  vpc_id     = aws_vpc.project8_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-2b"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "proj8_web_2"
  }
}


# Create Application Subnet-1

resource "aws_subnet" "proj8_app_1" {
  vpc_id     = aws_vpc.project8_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-2c"

  tags = {
    Name = "proj8_app_1"
  }
}


# Create Application Subnet-2

resource "aws_subnet" "proj8_app_2" {
  vpc_id     = aws_vpc.project8_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "proj8_app_2"
  }
}

# Create Database Subnet-1

resource "aws_subnet" "proj8_dtb_1" {
  vpc_id     = aws_vpc.project8_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "proj8_dtb_1"
  }
}

# Create Database Subnet-2

resource "aws_subnet" "proj8_dtb_2" {
  vpc_id     = aws_vpc.project8_vpc.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "eu-west-2c"

  tags = {
    Name = "proj8_dtb_2"
  }
}

# Create Internet Gateway

resource "aws_internet_gateway" "proj8_igw" {
  vpc_id = aws_vpc.project8_vpc.id

  tags = {
    Name = "proj8_igw"
  }
}

# Create Public Route Table

resource "aws_route_table" "proj8_RT" {
  vpc_id = aws_vpc.project8_vpc.id 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.proj8_igw.id
  }

}

# Create Private Route Table

resource "aws_route_table" "proj8_RT_pri" {
  vpc_id = aws_vpc.project8_vpc.id

  route = []

  tags = {
    Name = "proj8_RT_pri"
  }
}


# Private Subnet association to Private Route Table

resource "aws_route_table_association" "proj8_RT_app1" {
  subnet_id      = aws_subnet.proj8_app_1.id 
  route_table_id = aws_route_table.proj8_RT_pri.id
}

# Private Subnet association to Private Route Table

resource "aws_route_table_association" "proj8_RT_app2" {
  subnet_id      = aws_subnet.proj8_app_2.id
  route_table_id = aws_route_table.proj8_RT_pri.id
}

# Private Subnet association to Private Route Table

resource "aws_route_table_association" "proj8_RT_dtb1" {
  subnet_id      = aws_subnet.proj8_dtb_1.id 
  route_table_id = aws_route_table.proj8_RT_pri.id
}

# Private Subnet association to Private Route Table

resource "aws_route_table_association" "proj8_RT_dtb2" {
  subnet_id      = aws_subnet.proj8_dtb_2.id 
  route_table_id = aws_route_table.proj8_RT_pri.id
}

# Association of Public Route Table to Public Subnet

resource "aws_route_table_association" "proj8_RT_Sub1" {
  subnet_id      = aws_subnet.proj8_web_1.id
  route_table_id = aws_route_table.proj8_RT.id
}

# Association of Public Route Table to Public Subnet

resource "aws_route_table_association" "proj8_RT_Sub2" {
  subnet_id      = aws_subnet.proj8_web_2.id 
  route_table_id = aws_route_table.proj8_RT.id
}

# Association of Internet Gateway to Public Route Table

resource "aws_route" "proj8_igw_pubsub" {
  route_table_id            = aws_route_table.proj8_RT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.proj8_igw.id 
  
}
