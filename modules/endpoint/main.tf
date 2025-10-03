##############################################################################
# terraform-ibm-container-registry
#
# Returns the IBM Cloud Container Registry
##############################################################################

locals {
  registry_region_result = data.external.container_registry_region.result
  registry               = lookup(local.registry_region_result, "registry", null)
  registry_region_error  = lookup(local.registry_region_result, "error", null)

  # This will cause Terraform to fail if "error" is present in the external script output executed as a part of container_registry_region
  # tflint-ignore: terraform_unused_declarations
  fail_if_registry_region_error = local.registry_region_error != null ? tobool("Registry region script failed: ${local.registry_region_error}") : null
}

data "external" "container_registry_region" {
  program = ["bash", "../../scripts/get-cr-endpoint.sh"]
  query = {
    REGION           = var.region
    IBMCLOUD_API_KEY = var.ibmcloud_api_key
  }
}
