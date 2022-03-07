resource "aws_vpc" "vpc_talleransible" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = "true"

}

resource "aws_internet_gateway" "vpc_talleransible_ig" {
  vpc_id = aws_vpc.vpc_talleransible.id

}

resource "aws_subnet" "vpc_talleransible_sn1" {
  cidr_block              = "10.0.0.0/24"
  vpc_id                  = aws_vpc.vpc_talleransible.id
  map_public_ip_on_launch = true
}

# ROUTING
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc_talleransible.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_talleransible_ig.id
  }
}

resource "aws_route_table_association" "rta-subnet-1" {
  subnet_id      = aws_subnet.vpc_talleransible_sn1.id
  route_table_id = aws_route_table.rtb.id
}

# SECURITY GROUPS
resource "aws_security_group" "taller_ansible-sg" {
  name   = "taller_ansible-sg"
  vpc_id = aws_vpc.vpc_talleransible.id

  # Permitimos entrada de trafico al 80/443/SSH
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}