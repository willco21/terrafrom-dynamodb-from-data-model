variable "name" {}
variable "data_model" {}
variable "local_secondary_index" { default = {} }
variable "point_in_time_recovery" { default = {} }
variable "replica" { default = {} }
variable "restore_date_time" { default = null }
variable "restore_source_name" { default = null }
variable "restore_to_latest_time" { default = null }
variable "server_side_encryption" { default = {} }
variable "ttl" { default = {} }
variable "stream_enabled" { default = null }
variable "stream_view_type" { default = null }
variable "tags" { default = null }
