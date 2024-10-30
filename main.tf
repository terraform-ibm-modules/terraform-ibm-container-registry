data "ibm_cr_namespaces" "existing_cr_namespaces" {
  count = var.use_existing_namespace ? 1 : 0
}

locals {
  existing_cr_namespace = var.use_existing_namespace ? [
    for namespace in data.ibm_cr_namespaces.existing_cr_namespaces[0].namespaces : namespace
  ] : []
  # tflint-ignore: terraform_unused_declarations
  validate_existing_namespace = (var.use_existing_namespace && length(local.existing_cr_namespace) == 0) ? tobool("existing namespace ${var.name} not found in a region") : false
}

resource "ibm_cr_namespace" "cr_namespace" {
  count             = var.use_existing_namespace ? 0 : 1
  name              = var.name
  resource_group_id = var.resource_group_id
  tags              = var.tags
}

resource "ibm_cr_retention_policy" "cr_retention_policy" {
  count           = var.images_per_repo != 0 ? 1 : 0
  namespace       = var.name
  images_per_repo = var.images_per_repo
  retain_untagged = var.retain_untagged != null ? var.retain_untagged : false
  # Issue 128: to ensure policy fully destroyed before namespace
  depends_on = [ibm_cr_namespace.cr_namespace]
}

moved {
  from = ibm_cr_namespace.cr_namespace
  to   = ibm_cr_namespace.cr_namespace[0]
}
