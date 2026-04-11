variable "name" {
  description = "Name tag for the EC2 instance."
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type."
  type        = string
  default     = "t4g.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the EC2 instance."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the instance security group."
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance."
  type        = bool
  default     = false
}

variable "iam_instance_profile" {
  description = "IAM instance profile name to attach to the instance."
  type        = string
  default     = null
}

variable "additional_security_group_ids" {
  description = "Additional security group IDs to attach to the instance."
  type        = list(string)
  default     = []
}

variable "root_volume_size" {
  description = "Root EBS volume size in gibibytes."
  type        = number
  default     = 8
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
