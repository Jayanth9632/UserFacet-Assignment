output "public_ip" {
  description = "Public IP of the Jenkins EC2 instance"
  value       = aws_instance.ec2.public_ip
}

output "public_dns" {
  description = "Public DNS of the Jenkins EC2 instance"
  value       = aws_instance.ec2.public_dns
}
