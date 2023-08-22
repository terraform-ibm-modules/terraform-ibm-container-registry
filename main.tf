resource "ibm_cr_namespace" "cr_namespace" {
  name              = var.name
  resource_group_id = var.resource_group_id
  tags              = var.tags
}

resource "ibm_cr_retention_policy" "cr_retention_policy" {
  count           = var.images_per_repo != 0 ? 1 : 0
  namespace       = ibm_cr_namespace.cr_namespace.name
  images_per_repo = var.images_per_repo
  retain_untagged = var.retain_untagged != null ? var.retain_untagged : false
}

# Validation ibmcloud_api_key required when registry_plan_upgrade is true
locals {
  # Validation (approach based on https://github.com/hashicorp/terraform/issues/25609#issuecomment-1057614400)
  # tflint-ignore: terraform_unused_declarations
  validate_key = var.registry_plan_upgrade && var.ibmcloud_api_key == null ? tobool("When setting var.registry_plan_upgrade to true, var.ibmcloud_api_key must be set") : true
}

resource "null_resource" "icr_plan_upgrade" {
  count = var.registry_plan_upgrade ? 1 : 0

  provisioner "local-exec" {
    command     = "${path.module}/scripts/icr_plan_upgrade.sh ${var.resource_group_id} ${var.registry_region}"
    interpreter = ["/bin/bash", "-c"]
    environment = {
      IBMCLOUD_API_KEY = var.ibmcloud_api_key
    }
  }

  triggers = {
    always_run = timestamp()
  }

}
