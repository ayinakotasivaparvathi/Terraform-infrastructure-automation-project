provider "aws" {
  region = "us-east-1"
}

# ---------------- VPC ----------------
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Terraform-VPC"
  }
}

# ---------------- Public Subnet ----------------
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "Public-Subnet"
  }
}

# ---------------- Internet Gateway ----------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Terraform-IGW"
  }
}

# ---------------- Route Table ----------------
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "Public-RT"
  }
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# ---------------- Security Group ----------------
resource "aws_security_group" "ec2_sg" {
  name   = "ec2-sg"
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
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
}

# ---------------- Latest AMI ----------------
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# ---------------- EC2 Instance ----------------
resource "aws_instance" "web_server" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_subnet.id

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  associate_public_ip_address = true

  tags = {
    Name = "Terraform-EC2"
  }
}

# ---------------- Outputs ----------------
output "ec2_public_ip" {
  value = aws_instance.web_server.public_ip
}