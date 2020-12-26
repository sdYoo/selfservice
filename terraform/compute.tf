# Keypair 생성
resource "aws_key_pair" "morpheus_server_keypair" {
  key_name = "morpheus_server_keypair"
  public_key = file("yoo-keypair.pub")
}

# SG 생성
resource "aws_security_group" "ssh" {
  name = "allow_ssh_from_all"
  description = "Allow SSH port from sangduk"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0","1.237.36.21/32"]
  }
}

# EC2 생성
resource "aws_instance" "morpheus_server" {
  ami           = "ami-04d29b6f966df1537"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public_subnet_a.id
  key_name = aws_key_pair.morpheus_server_keypair.key_name
  vpc_security_group_ids = [
    aws_security_group.ssh.id,
  ]

  tags = {
    Name = "morpheus_server"
    CoreInfra = "false"
  }

  lifecycle {
    prevent_destroy = true
  }
}

# EIP 생성
resource "aws_eip" "morpheus_server_eip" {
  vpc   = true
  instance = aws_instance.morpheus_server.id

  lifecycle {
    create_before_destroy = true
  }
}

# EIP 할당
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.morpheus_server.id
  allocation_id = aws_eip.morpheus_server_eip.id
}

# EBS 할당
resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.morpheus_server_volume.id
  instance_id = aws_instance.morpheus_server.id
}

# EBS 생성
resource "aws_ebs_volume" "morpheus_server_volume" {
  availability_zone = "us-east-1a"
  size              = 100
}