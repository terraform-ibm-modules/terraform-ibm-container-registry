data "ibm_cr_namespaces" "existing_cr_namespaces" {
}

locals {
  existing_cr_namespace = var.existing_namespace_name != null ? [
    for namespace in data.ibm_cr_namespaces.existing_cr_namespaces.namespaces :
    namespace if namespace.name == var.existing_namespace_name
  ] : []
}

resource "ibm_cr_namespace" "cr_namespace" {
  count             = var.existing_namespace_name != null ? 0 : 1
  name              = var.namespace_name
  resource_group_id = var.resource_group_id
  tags              = var.tags
}

resource "ibm_resource_tag" "resource_tag" {
  count       = var.existing_namespace_name != null || length(var.tags) == 0 ? 0 : 1
  resource_id = ibm_cr_namespace.cr_namespace[0].crn
  tags        = var.tags
  tag_type    = "user"
}

resource "ibm_resource_tag" "access_tag" {
  count       = var.existing_namespace_name != null || length(var.access_tags) == 0 ? 0 : 1
  resource_id = ibm_cr_namespace.cr_namespace[0].crn
  tags        = var.access_tags
  tag_type    = "access"
}

resource "ibm_cr_retention_policy" "cr_retention_policy" {
  count           = var.images_per_repo != 0 ? 1 : 0
  namespace       = var.namespace_name
  images_per_repo = var.images_per_repo
  retain_untagged = var.retain_untagged != null ? var.retain_untagged : false
  # Issue 128: to ensure policy fully destroyed before namespace
  depends_on = [ibm_cr_namespace.cr_namespace]
}

moved {
  from = ibm_cr_namespace.cr_namespace
  to   = ibm_cr_namespace.cr_namespace[0]
}
