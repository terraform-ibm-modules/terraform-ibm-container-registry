# IBM Container Registry Quota

You can use this submodule to upgrade the IBM [Container Registry](https://cloud.ibm.com/docs/Registry?topic=Registry-getting-started) plan.

The submodule can be used without the root module to set the pull traffic and storage quotas.

### Usage
```
API_DATA_IS_SENSITIVE=true
```
For more information, see the [provider documentation](https://github.com/Mastercard/terraform-provider-restapi#usage) for generic REST APIs.

```hcl

# Upgrade plan:
module "upgrade-plan" {
  source  = "terraform-ibm-modules/container-registry/ibm//modules/plan"
  version = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
  container_registry_endpoint = "us.icr.io"
}
module "set_quota" {
  source  = "terraform-ibm-modules/container-registry/ibm//modules/quotas"
  version = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
  container_registry_endpoint = "us.icr.io"
  update_storage_quota        = true
  storage_megabytes           = 5 * 1024 # 5GiB
  update_traffic_quota        = true
  traffic_megabytes           = 500 # 500 MB
}
```

### Required IAM access policies

You need the following permissions to run this module.

- Account Management
    - IBM Cloud Container Registry service
        - `Manager` service access
        - `Writer` service access

[Access roles for using Container Registry](https://cloud.ibm.com/docs/Registry?topic=Registry-iam&interface=ui#access_roles_using)

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0, < 2.0.0 |
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | >= 1.18.2 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [restapi_object.container_registry_storage_quota](https://registry.terraform.io/providers/Mastercard/restapi/latest/docs/resources/object) | resource |
| [restapi_object.container_registry_traffic_quota](https://registry.terraform.io/providers/Mastercard/restapi/latest/docs/resources/object) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_registry_endpoint"></a> [container\_registry\_endpoint](#input\_container\_registry\_endpoint) | The endpoint of the ICR region, eg. https://us.icr.io or https://de.icr.io, to change to standard plan | `string` | `"us.icr.io"` | no |
| <a name="input_storage_megabytes"></a> [storage\_megabytes](#input\_storage\_megabytes) | Storage quota in megabytes. The value -1 denotes `Unlimited` | `number` | `500` | no |
| <a name="input_traffic_megabytes"></a> [traffic\_megabytes](#input\_traffic\_megabytes) | Traffic quota in megabytes. The value -1 denotes `Unlimited`. | `number` | `5120` | no |
| <a name="input_update_storage_quota"></a> [update\_storage\_quota](#input\_update\_storage\_quota) | Set to true to update storage quota of the registry. | `bool` | `true` | no |
| <a name="input_update_traffic_quota"></a> [update\_traffic\_quota](#input\_update\_traffic\_quota) | Set to true to update traffic pull quota of the registry. | `bool` | `true` | no |

### Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
