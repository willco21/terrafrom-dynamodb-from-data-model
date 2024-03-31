locals {
  data_models_json     = file(var.datamodel_filepath)
  dynamodb_data_models = jsondecode(local.data_models_json).DataModel
}

data "aws_caller_identity" "current" {}


module "dynamodb_Forum" {
  ### Module Path
  source = "../../modules/DynamoDB/from_data_model"

  for_each = { for i in local.dynamodb_data_models : i.TableName => i if endswith(i.TableName, "Forum") }

  name       = "${var.resource_prefix}-Forum"
  data_model = each.value
}

module "dynamodb_Thread" {
  ### Module Path
  source = "../../modules/DynamoDB/from_data_model"

  for_each = { for i in local.dynamodb_data_models : i.TableName => i if endswith(i.TableName, "Thread") }

  name       = "${var.resource_prefix}-Thread"
  data_model = each.value
}

module "dynamodb_Reply" {
  ### Module Path
  source = "../../modules/DynamoDB/from_data_model"

  for_each = { for i in local.dynamodb_data_models : i.TableName => i if endswith(i.TableName, "Reply") }

  name       = "${var.resource_prefix}-Reply"
  data_model = each.value
}
