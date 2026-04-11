output "instance_id" {
  description = "ID of the EC2 instance."
  value       = aws_instance.this.id
}

output "instance_arn" {
  description = "ARN of the EC2 instance."
  value       = aws_instance.this.arn
}

output "private_ip" {
  description = "Private IP address of the EC2 instance."
  value       = aws_instance.this.private_ip
}

output "public_ip" {
  description = "Public IP address of the EC2 instance, if assigned."
  value       = aws_instance.this.public_ip
}

output "security_group_id" {
  description = "Security group created for the EC2 instance."
  value       = aws_security_group.this.id
}
