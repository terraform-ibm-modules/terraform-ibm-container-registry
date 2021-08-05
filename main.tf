data "ibm_resource_group" "resource_group" {
  name = var.resource_group
}

resource "ibm_cr_namespace" "cr_namespace" {
  name              = var.name
  resource_group_id = data.ibm_resource_group.resource_group.id
  tags              = var.tags != null ? var.tags : null
}

resource "ibm_cr_retention_policy" "cr_retention_policy" {
  count           = var.images_per_repo != 0 ? 1 : 0
  namespace       = ibm_cr_namespace.cr_namespace.name
  images_per_repo = var.images_per_repo
  retain_untagged = var.retain_untagged != null ? var.retain_untagged : false
}