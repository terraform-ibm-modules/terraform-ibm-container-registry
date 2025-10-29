# IBM Container Registry plan

You can use this submodule to upgrade the IBM [Container Registry](https://cloud.ibm.com/docs/Registry?topic=Registry-registry_overview#registry_plans) plan.

The submodule can used without the root module to upgrade the plan without creating any additional namespaces or retention policies.

### Usage
```
API_DATA_IS_SENSITIVE=true
```
For more information, see the [provider documentation](https://github.com/Mastercard/terraform-provider-restapi#usage) for generic REST APIs.

```hcl
provider "ibm" {
  ibmcloud_api_key = "XXXXXXXXXX" # pragma: allowlist secret
  region           = "us-south"
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

# Upgrade plan:
module "upgrade-plan" {
  source  = "terraform-ibm-modules/container-registry/ibm//modules/plan"
  version = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
  container_registry_endpoint = "us.icr.io"
}
```

### Required IAM access policies

You need the following permissions to run this module.

- Account Management
    - IBM Cloud Container Registry service
        - `Manager` service access

[Access roles for using Container Registry](https://cloud.ibm.com/docs/Registry?topic=Registry-iam&interface=ui#access_roles_using)

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.79.0, < 2.0.0 |
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | >= 2.0.1, < 3.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [restapi_object.container_registry_plan_upgrade](https://registry.terraform.io/providers/Mastercard/restapi/latest/docs/resources/object) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_registry_endpoint"></a> [container\_registry\_endpoint](#input\_container\_registry\_endpoint) | The endpoint of the ICR region, eg. `us.icr.io` or `de.icr.io`, to change to standard plan | `string` | `"us.icr.io"` | no |

### Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
