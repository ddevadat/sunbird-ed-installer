include "root" {
  path = find_in_parent_folders("terragrunt.hcl")
}

# include "environment" {
#   path = "${get_terragrunt_dir()}/../../_common/network.hcl"
#   # This section will be enabled after final code is pushed and tagged
#   #  expose = true
# }

# This section will be enabled after final code is pushed and tagged
# terraform {
#   source = "${include.environment.locals.source_base_url}?ref=v1.0.0"
# }

terraform {
  source = "../../modules//network/"
}


locals {
  env_vars = yamldecode(
    file("${find_in_parent_folders("environment.yaml")}")
  )
}

inputs = {
  environment    = get_env("ENVIRONMENT")
  compartment_id = get_env("OCI_COMPARTMENT_ID")
  region         = get_env("OCI_REGION")
  subnet_map     = local.env_vars.subnet_map
}
