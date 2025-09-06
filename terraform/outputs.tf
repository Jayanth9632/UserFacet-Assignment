output "public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2_jenkins.public_ip
}

output "public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = module.ec2_jenkins.public_dns
}
