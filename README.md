# IBM Container Registry module

[![Graduated (Supported)](https://img.shields.io/badge/Status-Graduated%20(Supported)-brightgreen)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-container-registry?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-container-registry/releases/latest)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)

You can use this module to provision and configure an [IBM Container Registry](https://cloud.ibm.com/docs/Registry?topic=Registry-getting-started) namespace and optionally, a container registry retention policy.


<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-container-registry](#terraform-ibm-container-registry)
* [Submodules](./modules)
    * [plan](./modules/plan)
    * [quotas](./modules/quotas)
* [Examples](./examples)
    * [IBM Container Registry namespace example](./examples/complete)
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->

## terraform-ibm-container-registry

### Usage

```hcl
module "namespace" {
  source            = "terraform-ibm-modules/container-registry/ibm"
  version           = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
  name              = "my-namespace"
  resource_group_id = "xxXXxxXXxXxXXXXxxXxxxXXXXxXXXXX"
  images_per_repo   = 2
}

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

- Account Management
    - IBM Cloud Container Registry service
        - `Writer`, `Manager` service access

[Access roles for using Container Registry](https://cloud.ibm.com/docs/Registry?topic=Registry-iam&interface=ui#access_roles_using)

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.49.0, < 2.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_cr_namespace.cr_namespace](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cr_namespace) | resource |
| [ibm_cr_retention_policy.cr_retention_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cr_retention_policy) | resource |
| [ibm_cr_namespaces.existing_cr_namespaces](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/data-sources/cr_namespaces) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_images_per_repo"></a> [images\_per\_repo](#input\_images\_per\_repo) | (Optional, Integer) Determines how many images are retained in each repository when the retention policy is processed. The value -1 denotes Unlimited (all images are retained). The value 0 denotes no retention policy will be created (default) | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the container registry namespace, if var.create\_namespace is set to true, a new namespace will be created in a region set by provider | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | The resource group ID where the IBM container namespace will be created. | `string` | n/a | yes |
| <a name="input_retain_untagged"></a> [retain\_untagged](#input\_retain\_untagged) | (Optional, Bool) Determines whether untagged images are retained when the retention policy is processed. Default value is false, means untagged images can be deleted when the policy runs. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional list of tags to be added to the IBM container namespace. | `list(string)` | `[]` | no |
| <a name="input_use_existing_namespace"></a> [use\_existing\_namespace](#input\_use\_existing\_namespace) | Specify true to use an existing container registry namespace in the region defined by `namespace_region`; set false to create a new namespace. | `bool` | `false` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace_crn"></a> [namespace\_crn](#output\_namespace\_crn) | CRN representing the namespace |
| <a name="output_retention_policy_id"></a> [retention\_policy\_id](#output\_retention\_policy\_id) | ID of retentation policy |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
