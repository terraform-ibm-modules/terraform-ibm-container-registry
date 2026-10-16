########################################################################################################################
# Provider config
########################################################################################################################

provider "ibm" {
  ibmcloud_api_key      = var.ibmcloud_api_key
  visibility            = var.provider_visibility
  private_endpoint_type = (var.provider_visibility == "private" && var.namespace_region == "ca-mon") ? "vpe" : null
}

provider "ibm" {
  alias                 = "namespace"
  ibmcloud_api_key      = var.ibmcloud_api_key
  region                = var.namespace_region
  visibility            = var.provider_visibility
  private_endpoint_type = (var.provider_visibility == "private" && var.namespace_region == "ca-mon") ? "vpe" : null
}

