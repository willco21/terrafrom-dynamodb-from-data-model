#!/bin/bash -ux

terraform validate
tflint --version && tflint
tfsec --version && tfsec
terraform fmt
