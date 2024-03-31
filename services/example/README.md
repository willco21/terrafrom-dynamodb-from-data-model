## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.8 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.57 |
| <a name="requirement_gitlab"></a> [gitlab](#requirement\_gitlab) | 15.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.54.0 |
| <a name="provider_gitlab"></a> [gitlab](#provider\_gitlab) | 15.8.0 |
| <a name="provider_template"></a> [template](#provider\_template) | 2.2.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alb_for_ecs"></a> [alb\_for\_ecs](#module\_alb\_for\_ecs) | ../../../modules/ALB | n/a |
| <a name="module_aws_api_gateway_rest_api"></a> [aws\_api\_gateway\_rest\_api](#module\_aws\_api\_gateway\_rest\_api) | ../../../modules/APIGateway | n/a |
| <a name="module_codebuild_project"></a> [codebuild\_project](#module\_codebuild\_project) | ../../../modules/CodeBuild | n/a |
| <a name="module_codebuild_project_lambda"></a> [codebuild\_project\_lambda](#module\_codebuild\_project\_lambda) | ../../../modules/CodeBuild | n/a |
| <a name="module_codedeploy_project"></a> [codedeploy\_project](#module\_codedeploy\_project) | ../../../modules/CodeDeploy | n/a |
| <a name="module_codepipeline_pipeline"></a> [codepipeline\_pipeline](#module\_codepipeline\_pipeline) | ../../../modules/CodePipeline | n/a |
| <a name="module_dynamodb_anchor_dev_Ads"></a> [dynamodb\_anchor\_dev\_Ads](#module\_dynamodb\_anchor\_dev\_Ads) | ../../../modules/DynamoDB/from_data_model | n/a |
| <a name="module_dynamodb_anchor_dev_Codes"></a> [dynamodb\_anchor\_dev\_Codes](#module\_dynamodb\_anchor\_dev\_Codes) | ../../../modules/DynamoDB/from_data_model | n/a |
| <a name="module_dynamodb_anchor_dev_Events"></a> [dynamodb\_anchor\_dev\_Events](#module\_dynamodb\_anchor\_dev\_Events) | ../../../modules/DynamoDB/from_data_model | n/a |
| <a name="module_dynamodb_anchor_dev_LPs"></a> [dynamodb\_anchor\_dev\_LPs](#module\_dynamodb\_anchor\_dev\_LPs) | ../../../modules/DynamoDB/from_data_model | n/a |
| <a name="module_dynamodb_anchor_dev_Sequences"></a> [dynamodb\_anchor\_dev\_Sequences](#module\_dynamodb\_anchor\_dev\_Sequences) | ../../../modules/DynamoDB/from_data_model | n/a |
| <a name="module_dynamodb_anchor_dev_Users"></a> [dynamodb\_anchor\_dev\_Users](#module\_dynamodb\_anchor\_dev\_Users) | ../../../modules/DynamoDB/from_data_model | n/a |
| <a name="module_ecr_private_repository"></a> [ecr\_private\_repository](#module\_ecr\_private\_repository) | ../../../modules/ECR | n/a |
| <a name="module_ecs_cluster_set"></a> [ecs\_cluster\_set](#module\_ecs\_cluster\_set) | ../../../modules/ECS-Fargate | n/a |
| <a name="module_lambda_bigquery"></a> [lambda\_bigquery](#module\_lambda\_bigquery) | ../../../modules/Lambda | n/a |
| <a name="module_lambda_forward"></a> [lambda\_forward](#module\_lambda\_forward) | ../../../modules/Lambda | n/a |
| <a name="module_lambda_kickback"></a> [lambda\_kickback](#module\_lambda\_kickback) | ../../../modules/Lambda | n/a |
| <a name="module_lambda_process"></a> [lambda\_process](#module\_lambda\_process) | ../../../modules/Lambda | n/a |
| <a name="module_lambda_socket"></a> [lambda\_socket](#module\_lambda\_socket) | ../../../modules/Lambda | n/a |
| <a name="module_sns_dynamodb_anchor_dev_Sequences"></a> [sns\_dynamodb\_anchor\_dev\_Sequences](#module\_sns\_dynamodb\_anchor\_dev\_Sequences) | ../../../modules/SNS | n/a |
| <a name="module_sqs_dynamodb_stream_sns_to_lambda_bigquery"></a> [sqs\_dynamodb\_stream\_sns\_to\_lambda\_bigquery](#module\_sqs\_dynamodb\_stream\_sns\_to\_lambda\_bigquery) | ../../../modules/SQS | n/a |
| <a name="module_sqs_dynamodb_stream_sns_to_lambda_kickback"></a> [sqs\_dynamodb\_stream\_sns\_to\_lambda\_kickback](#module\_sqs\_dynamodb\_stream\_sns\_to\_lambda\_kickback) | ../../../modules/SQS | n/a |
| <a name="module_sqs_dynamodb_stream_sns_to_lambda_process"></a> [sqs\_dynamodb\_stream\_sns\_to\_lambda\_process](#module\_sqs\_dynamodb\_stream\_sns\_to\_lambda\_process) | ../../../modules/SQS | n/a |
| <a name="module_ssmparameter_parameter_store"></a> [ssmparameter\_parameter\_store](#module\_ssmparameter\_parameter\_store) | ../../../modules/ParameterStore | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../../modules/VPC | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.lambda_socket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.socket_tag_putItem](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [gitlab_repository_file.dynamo_tables](https://registry.terraform.io/providers/gitlabhq/gitlab/15.8.0/docs/data-sources/repository_file) | data source |
| [template_file.openapi](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.taskdef_json](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [terraform_remote_state.common](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cidr_private"></a> [cidr\_private](#input\_cidr\_private) | n/a | `list(string)` | <pre>[<br>  "10.1.100.0/24",<br>  "10.1.101.0/24"<br>]</pre> | no |
| <a name="input_cidr_public"></a> [cidr\_public](#input\_cidr\_public) | n/a | `list(string)` | <pre>[<br>  "10.1.0.0/24",<br>  "10.1.1.0/24"<br>]</pre> | no |
| <a name="input_cidr_vpc"></a> [cidr\_vpc](#input\_cidr\_vpc) | n/a | `string` | `"10.1.0.0/16"` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | `"ad-bridge.com"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"stg"` | no |
| <a name="input_gitlab_token"></a> [gitlab\_token](#input\_gitlab\_token) | gitlab config | `any` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | # Project Name | `string` | `"anchor"` | no |
| <a name="input_system"></a> [system](#input\_system) | n/a | `string` | `"api"` | no |

## Outputs

No outputs.
