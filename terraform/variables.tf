variable "region" {
  description = "AWS region"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for resource names"
  type        = string
  default     = "react-ci"
}

variable "key_name" {
  description = "EC2 key pair name for SSH"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.small"
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH (22)"
  type        = string
}

variable "allowed_jenkins_cidr" {
  description = "CIDR block allowed for Jenkins (8080)"
  type        = string
}

variable "volume_size_gb" {
  description = "Root volume size in GB"
  type        = number
  default     = 20
}
