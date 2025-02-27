variable "compartment_id" {
  type        = string
  description = "compartment ocid"
}

variable "region" {
  type        = string
  description = "oci region"
}

variable "environment" {
    type        = string
    description = "environment name. All resources will be prefixed with this value."
}

variable "vcn_cidrs" {
  description = "List of CIDR blocks for the VCN"
  type        = list(string)

  default = ["10.0.0.0/16"]

  validation {
    condition     = alltrue([for cidr in var.vcn_cidrs : can(cidrsubnet(cidr, 0, 0))])
    error_message = "Each value in 'vcn_cidrs' must be a valid CIDR block."
  }
}


variable "subnet_map" {
  description = "List of subnets with their attributes"
  type = list(object({
    name       = string
    cidr_block = string
    type       = string
    dns_label  = string
  }))

  default = [
    {
      name       = "default-subnet"
      cidr_block = "10.0.1.0/24"
      type       = "private"
      dns_label  = "defaultsubnet"
    }
  ]

  validation {
    condition     = alltrue([for s in var.subnet_map : contains(["private", "public"], s.type)])
    error_message = "The 'type' field must be either 'private' or 'public'."
  }

  validation {
    condition     = alltrue([for s in var.subnet_map : can(regex("^[a-zA-Z][a-zA-Z0-9-]{0,14}$", s.dns_label))])
    error_message = "The 'dns_label' must start with a letter, be between 1-15 characters long, and contain only letters, numbers, and hyphens."
  }
}
