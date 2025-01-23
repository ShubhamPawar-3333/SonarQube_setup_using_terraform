variable "key_name" {
  description = "Name of the SSH key pair"
  type = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "t2.micro"
}

variable "ssh_cidr" {
  description = "CIDR block for SSH access"
  type = string
  default = "0.0.0.0/0"
}

variable "sonarqube_cidr" {
  description = "CIDR block for sonarqube HTTP access"
  type = string
  default = "0.0.0.0/0"
}