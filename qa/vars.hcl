# Set common variables for the terraform vars. This is automatically pulled in in the root terragrunt.hcl configuration to
# feed forward to the child modules.
locals {
  region = "us-east-1"
  account_name = "yavinenana"
  account_id = "729405875301" # TODO: replace me with your AWS account ID!
  profile = "dev-auna"
}
