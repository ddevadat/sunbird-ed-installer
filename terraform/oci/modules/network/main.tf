module "vcn" {
  source                   = "oracle-terraform-modules/vcn/oci"
  version                  = "3.6.0"
  compartment_id           = var.compartment_id
  create_internet_gateway  = true
  create_nat_gateway       = true
  create_service_gateway   = true
  subnets                  = local.subnet_maps
  vcn_cidrs                = var.vcn_cidrs
  vcn_name                 = "${var.environment}-sunbird-ed-vcn"
  lockdown_default_seclist = false
}