 locals {
   # Automatically load account-level variables
   terraform_vars = read_terragrunt_config(find_in_parent_folders("vars.hcl"))
   environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))

   # Extract the variables we need for easy access
   aws_region         = local.terraform_vars.locals.region
   aws_account_name   = local.terraform_vars.locals.account_name
   aws_account_id     = local.terraform_vars.locals.account_id
   awsprofile         = local.terraform_vars.locals.profile
   aws_environment    = local.environment_vars.locals.environment
 }

 # Generate an AWS provider block
 generate "provider" {
   path      = "provider.tf"
   if_exists = "overwrite_terragrunt"
   contents  = <<EOF
 provider "aws" {
   region = "${local.aws_region}"
   profile = "${local.awsprofile}"

   # Only these AWS Account IDs may be operated on by this template
 #  allowed_account_ids = ["${local.aws_account_id}"]
 }
 EOF
 }

 remote_state {
   backend = "s3"
   config = {
     bucket         = "b-jordypb"
#     bucket         = "${get_env("TG_BUCKET_PREFIX", "saleor-frontend-dashboard-${local.aws_environment}")}terragrunt-terraform-state-${local.account_name}-${local.aws_region}"
#     bucket         = "${get_env("TG_BUCKET_PREFIX", "")}terragrunt-terraform-state-${local.account_name}-${local.aws_region}"
#     key            = "${path_relative_to_include()}/saleor-frontend-dashboard-${local.aws_environment}.tfstate"
     key            = "${path_relative_to_include()}/terraformi.tfstate"
     region         = "${local.aws_region}"
     encrypt        = true
     dynamodb_table = "terraform_locks"
 #    profile        = "${local.awsprofile}"
   }
 }
 #include {
 #  path = find_in_parent_folders()
 #}

#remote_state {
#  backend = "s3"
#  config = {
#    bucket         = "bucket-yavinenana-general"
#    key            = "qa/terraform.tfstate"
#    region         = "us-west-2"
#    encrypt        = true
#    dynamodb_table = "terraform_locks"
#    profile        = "${local.awsprofile}"
#  }
#}
