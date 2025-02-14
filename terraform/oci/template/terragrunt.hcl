skip = true
remote_state {
  backend = "s3"

  #---------------------------------------------------#
  # The following vars must be changed for OCI environment
  #---------------------------------------------------#
  config = {
    key                                = "${path_relative_to_include()}/terraform.tfstate"
    bucket                             = get_env("REMOTE_STATE_S3_BUCKET")
    region                             = get_env("REMOTE_STATE_S3_REGION")
    endpoint                           = get_env("REMOTE_STATE_S3_ENDPOINT")
    use_path_style                     = true
    skip_bucket_ssencryption           = true
    skip_bucket_root_access            = true
    skip_bucket_enforced_tls           = true
    skip_bucket_public_access_blocking = true
    skip_bucket_versioning             = true
    skip_region_validation             = true
    skip_credentials_validation        = true
  }
  generate = {
    path = "backend.tf"
    if_exists = "overwrite"
  }
}