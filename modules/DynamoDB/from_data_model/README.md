## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.dynamodb_table_read_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_policy.dynamodb_table_write_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.dynamodb_table_read_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_appautoscaling_target.dynamodb_table_write_target](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_dynamodb_table.DynamoDBTable](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table_item.DynamoDBItem](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table_item) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_data_model"></a> [data\_model](#input\_data\_model) | n/a | `any` | n/a | yes |
| <a name="input_local_secondary_index"></a> [local\_secondary\_index](#input\_local\_secondary\_index) | n/a | `map` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_point_in_time_recovery"></a> [point\_in\_time\_recovery](#input\_point\_in\_time\_recovery) | n/a | `map` | `{}` | no |
| <a name="input_replica"></a> [replica](#input\_replica) | n/a | `map` | `{}` | no |
| <a name="input_restore_date_time"></a> [restore\_date\_time](#input\_restore\_date\_time) | n/a | `any` | `null` | no |
| <a name="input_restore_source_name"></a> [restore\_source\_name](#input\_restore\_source\_name) | n/a | `any` | `null` | no |
| <a name="input_restore_to_latest_time"></a> [restore\_to\_latest\_time](#input\_restore\_to\_latest\_time) | n/a | `any` | `null` | no |
| <a name="input_server_side_encryption"></a> [server\_side\_encryption](#input\_server\_side\_encryption) | n/a | `map` | `{}` | no |
| <a name="input_stream_enabled"></a> [stream\_enabled](#input\_stream\_enabled) | n/a | `any` | `null` | no |
| <a name="input_stream_view_type"></a> [stream\_view\_type](#input\_stream\_view\_type) | n/a | `any` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `any` | `null` | no |
| <a name="input_ttl"></a> [ttl](#input\_ttl) | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_table_arn"></a> [table\_arn](#output\_table\_arn) | n/a |
| <a name="output_table_id"></a> [table\_id](#output\_table\_id) | n/a |
| <a name="output_table_stream_arn"></a> [table\_stream\_arn](#output\_table\_stream\_arn) | n/a |
