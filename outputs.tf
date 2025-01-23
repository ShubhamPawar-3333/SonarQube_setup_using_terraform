# Output SonarQube Public IP
output "sonarqube_public_ip" {
  value = aws_instance.sonarqube_instance.public_ip
  description = "Public IP of the SonarQube instance"
}

# Output SSH Command
output "ssh_command" {
  value = "ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.sonarqube_instance.public_ip}"
  description = "SSH command to connect to the Sonarqube server"
}