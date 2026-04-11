terraform {
  required_version = ">= 1.0"
}

module "example_ec2" {
  source = "../../../../modules/aws/compute/ec2"

  name          = "example-tooling-host"
  ami_id        = "ami-0123456789abcdef0"
  instance_type = "t4g.micro"
  subnet_id     = "subnet-0123456789abcdef0"
  vpc_id        = "vpc-0123456789abcdef0"

  iam_instance_profile = "example-ssm-instance-profile"
  root_volume_size     = 10

  tags = {
    Environment = "dev"
    Project     = "example"
  }
}
