# IBM Container Registry Quota

You can use this submodule to set the [Container Registry](https://cloud.ibm.com/docs/Registry?topic=Registry-getting-started) pull traffic and storage quotas.

The submodule can be used without the root module to set the pull traffic and storage quotas.

### Usage

```hcl

# Upgrade plan:
module "upgrade-plan" {
  source  = "terraform-ibm-modules/container-registry/ibm//modules/plan"
  version = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
  container_registry_endpoint = "us.icr.io"
}

# Set quota:
module "set_quota" {
  source  = "terraform-ibm-modules/container-registry/ibm//modules/quotas"
  version = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
  container_registry_endpoint = "us.icr.io"
  storage_megabytes           = 5 * 1024 # 5GiB
  traffic_megabytes           = 500 # 500 MB
  # Issue 324: Upgrade plan before setting quota
  depends_on                  = [module.upgrade_plan]
}
```

### Upgrading from a version that used the restapi provider

Earlier versions of this submodule used the `Mastercard/restapi` provider. This version uses the IBM provider instead and removes the old `restapi_object` resources from state without destroying them, so the plan and the quotas on the account are not touched.

Terraform still needs the restapi provider to be configured during the apply that removes the old objects. Keep a minimal provider block for that one apply, then delete it:

```hcl
provider "restapi" {
  uri = "https:"
}
```

The old token and account settings data sources are not needed and can be removed right away.

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
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.14.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 2.9.0, < 3.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
| ---- | ---- |
| [ibm_cr_quota.quota](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cr_quota) | resource |

### Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_container_registry_endpoint"></a> [container\_registry\_endpoint](#input\_container\_registry\_endpoint) | The endpoint of the IBM Container Registry, eg. us.icr.io or de.icr.io, to change quotas | `string` | `"us.icr.io"` | no |
| <a name="input_storage_megabytes"></a> [storage\_megabytes](#input\_storage\_megabytes) | Storage quota in megabytes. The value -1 denotes `Unlimited` | `number` | `null` | no |
| <a name="input_traffic_megabytes"></a> [traffic\_megabytes](#input\_traffic\_megabytes) | Traffic quota in megabytes. The value -1 denotes `Unlimited`. | `number` | `null` | no |

### Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
