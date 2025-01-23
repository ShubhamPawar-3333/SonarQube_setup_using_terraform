# Specify the provider
provider "aws" {
  region = "ap-south-1"
}

# Define the key pair (adjust as needed)
resource "aws_key_pair" "sonarqube_key" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub") # Path to your public SSH key
}

# Security group for SonarQube
resource "aws_security_group" "sonarqube_sg" {
  name = "sonarqube-sg"
  description = "Allow sonarqube and SSH traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.ssh_cidr]
  }

  ingress {
    from_port = 9000
    to_port = 9000
    protocol = "tcp"
    cidr_blocks = [var.sonarqube_cidr]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SonarqubeSecurityGroup"
  }
}

# EC2 Instance
resource "aws_instance" "sonarqube_instance" {
  ami = var.ami_id
  instance_type = var.instance_type

  key_name = aws_key_pair.sonarqube_key.key_name
  security_groups = [aws_security_group.sonarqube_sg.name]

  user_data = templatefile("./setup_sonarqube.sh", {})

  tags = {
    Name = "SonarQube-Server"
  }

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      host = self.public_ip
    }
}
