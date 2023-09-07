<!-- Update the title -->
# Terraform Modules IBM Container Registry Project

<!--
Update status and "latest release" badges:
  1. For the status options, see https://github.ibm.com/GoldenEye/documentation/blob/master/status.md
-->
[![Graduated (Supported)](https://img.shields.io/badge/Status-Graduated%20(Supported)-brightgreen)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-container-registry?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-container-registry/releases/latest)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)

<!-- Add a description of module(s) in this repo -->

You can use this module to provision and configure an [IBM Container Registry](https://cloud.ibm.com/docs/cloud-object-storage?topic=cloud-object-storage-getting-started-cloud-object-storage) namespace and optionally, a container registry retention policy.
<!--
If this repo contains any reference architectures, uncomment the heading below and links to them.
(Usually in the `/reference-architectures` directory.)
See "Reference architecture" in Authoring Guidelines in the public documentation at
https://terraform-ibm-modules.github.io/documentation/#/implementation-guidelines?id=reference-architecture
-->
<!-- ## Reference architectures -->


<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-container-registry](#terraform-ibm-container-registry)
* [Submodules](./modules)
    * [plan](./modules/plan)
* [Examples](./examples)
    * [IBM Container Registry namespace Example](./examples/namespace)
* [Contributing](#contributing)

## terraform-ibm-container-registry
<!-- END OVERVIEW HOOK -->

### Usage

<!--
Add an example of the use of the module in the following code block.

Use real values instead of "var.<var_name>" or other placeholder values
unless real values don't help users know what to change.
-->

```hcl
module "namespace" {
  source            = "terraform-ibm-modules/icr/ibm"
  version           = "latest" # Replace "latest" with a release
  name              = "my-namespace"
  resource_group_id = module.resource_group.resource_group_id
  images_per_repo   = 2
}
```

### Required IAM access policies

<!-- PERMISSIONS REQUIRED TO RUN MODULE
If this module requires permissions, uncomment the following block and update
the sample permissions, following the format.
Replace the sample Account and IBM Cloud service names and roles with the
information in the console at
Manage > Access (IAM) > Access groups > Access policies.
-->

<!--
You need the following permissions to run this module.

- Account Management
    - **Sample Account Service** service
        - `Editor` platform access
        - `Manager` service access
    - IAM Services
        - **Sample Cloud Service** service
            - `Administrator` platform access
-->

<!-- NO PERMISSIONS FOR MODULE
If no permissions are required for the module, uncomment the following
statement instead the previous block.
-->

<!-- No permissions are needed to run this module.-->


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

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_images_per_repo"></a> [images\_per\_repo](#input\_images\_per\_repo) | (Optional, Integer) Determines how many images are retained in each repository when the retention policy is processed. The value -1 denotes Unlimited (all images are retained). The value 0 denotes no retention policy will be created (default) | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the container registry namespace | `string` | n/a | yes |
| <a name="input_resource_group_id"></a> [resource\_group\_id](#input\_resource\_group\_id) | The resource group ID where the IBM container namespace will be created. | `string` | n/a | yes |
| <a name="input_retain_untagged"></a> [retain\_untagged](#input\_retain\_untagged) | (Optional, Bool) Determines whether untagged images are retained when the retention policy is processed. Default value is false, means untagged images can be deleted when the policy runs. | `bool` | `false` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional list of tags to be added to the IBM container namespace. | `list(string)` | `[]` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace_crn"></a> [namespace\_crn](#output\_namespace\_crn) | CRN representing the namespace |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
