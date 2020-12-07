locals {
  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  aws_env = local.environment_vars.locals.environment
}

# working directory, into a temporary folder, and execute your Terraform commands in that folder.
# reference in : https://www.terraform.io/docs/modules/sources.html#github

terraform {
# source = "git::git@github.com:gruntwork-io/terragrunt-infrastructure-modules-example.git//asg-elb-service?ref=v0.3.0"
#  source = "git::git@github.com:yavinenana/tf-ec2.git?ref=v0.1.0"
  source = "git::git@github.com:yavinenana/tf-ec2.git?ref=dev"
#  source = "git::git@github.com:jordypb/cloudfront-oai-s3.git"
}

#module "main" {
#  source = "../ec2/main.tf"
#}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}


# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  region = "us-east-1"
  tag_environment = "stage"  
}
