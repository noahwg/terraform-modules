# dynamo-db

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.39.0 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_dynamodb_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | List of nested attribute definitions. Only required for hash\_key and range\_key attributes. | <pre>list(object({<br/>    name = string<br/>    type = string<br/>  }))</pre> | `[]` | no |
| <a name="input_billing_mode"></a> [billing\_mode](#input\_billing\_mode) | Controls how you are charged for read and write throughput and how you manage capacity. | `string` | `"PAY_PER_REQUEST"` | no |
| <a name="input_deletion_protection_enabled"></a> [deletion\_protection\_enabled](#input\_deletion\_protection\_enabled) | Enables deletion protection for the table. | `bool` | `false` | no |
| <a name="input_global_secondary_indexes"></a> [global\_secondary\_indexes](#input\_global\_secondary\_indexes) | List of global secondary index definitions. | <pre>list(object({<br/>    name               = string<br/>    hash_key           = string<br/>    range_key          = optional(string)<br/>    projection_type    = optional(string, "ALL")<br/>    non_key_attributes = optional(list(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_hash_key"></a> [hash\_key](#input\_hash\_key) | The attribute to use as the hash (partition) key. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the DynamoDB table | `string` | n/a | yes |
| <a name="input_point_in_time_recovery_enabled"></a> [point\_in\_time\_recovery\_enabled](#input\_point\_in\_time\_recovery\_enabled) | Whether to enable point-in-time recovery. | `bool` | `false` | no |
| <a name="input_range_key"></a> [range\_key](#input\_range\_key) | The attribute to use as the range (sort) key. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_ttl_attribute_name"></a> [ttl\_attribute\_name](#input\_ttl\_attribute\_name) | The name of the table attribute to store the TTL timestamp in. | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_table_arn"></a> [table\_arn](#output\_table\_arn) | ARN of the DynamoDB table |
| <a name="output_table_id"></a> [table\_id](#output\_table\_id) | ID of the DynamoDB table |
| <a name="output_table_name"></a> [table\_name](#output\_table\_name) | Name of the DynamoDB table |
<!-- END_TF_DOCS -->
