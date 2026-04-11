# ec2

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.all](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_additional_security_group_ids"></a> [additional\_security\_group\_ids](#input\_additional\_security\_group\_ids) | Additional security group IDs to attach to the instance. | `list(string)` | `[]` | no |
| <a name="input_ami_id"></a> [ami\_id](#input\_ami\_id) | AMI ID to use for the EC2 instance. | `string` | n/a | yes |
| <a name="input_associate_public_ip_address"></a> [associate\_public\_ip\_address](#input\_associate\_public\_ip\_address) | Whether to associate a public IP address with the instance. | `bool` | `false` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | IAM instance profile name to attach to the instance. | `string` | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type. | `string` | `"t4g.micro"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name tag for the EC2 instance. | `string` | n/a | yes |
| <a name="input_root_volume_size"></a> [root\_volume\_size](#input\_root\_volume\_size) | Root EBS volume size in gibibytes. | `number` | `8` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID for the EC2 instance. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources. | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID for the instance security group. | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_instance_arn"></a> [instance\_arn](#output\_instance\_arn) | ARN of the EC2 instance. |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | ID of the EC2 instance. |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | Private IP address of the EC2 instance. |
| <a name="output_public_ip"></a> [public\_ip](#output\_public\_ip) | Public IP address of the EC2 instance, if assigned. |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security group created for the EC2 instance. |
<!-- END_TF_DOCS -->
