locals {
  subnet_maps = {
    for idx, subnet in var.subnet_map :
    "${subnet.type}_sub${idx + 1}" => {
      name       = subnet.name
      cidr_block = subnet.cidr_block
      type       = subnet.type
      dns_label  = subnet.dns_label
    }
  }
}
