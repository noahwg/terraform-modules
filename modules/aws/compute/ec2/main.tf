terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

resource "aws_security_group" "this" {
  name        = "${var.name}-ec2"
  description = "Security group for ${var.name} EC2 instance"
  vpc_id      = var.vpc_id

  tags = var.tags
}

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.this.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.iam_instance_profile
  vpc_security_group_ids      = concat([aws_security_group.this.id], var.additional_security_group_ids)

  root_block_device {
    volume_size = var.root_volume_size
    volume_type = "gp3"
    encrypted   = true
  }

  tags = merge(
    var.tags,
    {
      Name = var.name
    }
  )
}
