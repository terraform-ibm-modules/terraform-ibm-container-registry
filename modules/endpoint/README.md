# IBM Container Registry endpoint

This submodule allows you to retrieve the IBM Container Registry endpoint for a specific region.

### Usage

```hcl
module "cr_endpoint" {
  source           = "terraform-ibm-modules/container-registry/ibm//modules/endpoint"
  version          = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
  region           = "us-south"
}
```

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.79.0, < 2.0.0 |

### Modules

No modules.

### Resources

No resources.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Region used to determine the IBM Cloud Container Registry endpoint | `string` | n/a | yes |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_container_registry_endpoint"></a> [container\_registry\_endpoint](#output\_container\_registry\_endpoint) | The public IBM Cloud Container Registry endpoint for the selected region |
| <a name="output_container_registry_endpoint_private"></a> [container\_registry\_endpoint\_private](#output\_container\_registry\_endpoint\_private) | The private IBM Cloud Container Registry endpoint for the selected region |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
