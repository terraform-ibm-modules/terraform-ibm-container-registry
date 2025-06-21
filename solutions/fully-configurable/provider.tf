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

# Data source to retrieve token details
data "ibm_iam_auth_token" "token_data" {
}

# Data source to account settings
data "ibm_iam_account_settings" "iam_account_settings" {
}

provider "restapi" {
  uri                   = "https:"
  write_returns_object  = false
  create_returns_object = false
  debug                 = false # set to true to show detailed logs, but use carefully as it might print sensitive values.
  headers = {
    Account       = data.ibm_iam_account_settings.iam_account_settings.account_id
    Authorization = data.ibm_iam_auth_token.token_data.iam_access_token
    Content-Type  = "application/json"
  }
}
