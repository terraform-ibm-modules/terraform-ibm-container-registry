#####################################################
# Module Example
# Copyright 2020 IBM
#####################################################

provider "ibm" {
}

module "namespace" {
  // Uncommnet the following line to point the source to registry level
  //source = "terraform-ibm-modules/container-registry/ibm"

  source          = "./../.."
  name            = var.name
  resource_group  = var.resource_group
  tags            = var.tags
  images_per_repo = var.images_per_repo
  retain_untagged = var.retain_untagged
}