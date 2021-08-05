# Container registry namespace Example

This module is used to provision a container registry namespace and configure the image retention policies on IBM Cloud Platform:

## Example Usage

```
provider "ibm" {
}

module "namespace" {
  // Uncommnet the following line to point the source to registry level
  //source = "terraform-ibm-modules/container-registry/ibm"

  source              = "./../.."
  name                = var.name
  resource_group_name = var.resource_group_name
  tags                = var.tags
  images_per_repo     = var.images_per_repo
  retain_untagged     = var.retain_untagged
}

```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name                              | Description                                                  | Type         | Default | Required |
|-----------------------------------|--------------------------------------------------------------|--------------|---------|----------|
| name                              | Name of namespace.                                           | string       | n/a     | yes      |
| resource_group                    | Name of the resource group, namespace will be created within | string       | Default | no       |
| tags                              | Tags that should be applied to namespace.                    | list(string) | n/a     | no       |
| images_per_repo                   | Number of images to be retained per each repository          | number       | n/a     | yes      |
| retain_untagged                   | Determines if untagged images to be retained or not .        | bool         | false   | no       |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## How to input variable values through a file

To review the plan for the configuration defined (no resources actually provisioned)

`terraform plan -var-file=./input.tfvars`

To execute and start building the configuration defined in the plan (provisions resources)

`terraform apply -var-file=./input.tfvars`

To destroy the VPC and all related resources

`terraform destroy -var-file=./input.tfvars`

All optional parameters by default will be set to null in respective example's variable.tf file. If user wants to configure any optional paramter he has overwrite the default value.

## How to configure image retention policy

By default parameter `images_per_repo` is set to null, to enable the retention policy overwrite the `null` with required number of images to retain. This paramter determines how many images will be retained for each repository when the retention policy is executed. The value -1 denotes 'Unlimited' (all images are retained).If we configure `images_per_repo` to say 10 then 10 images will be retained per each repo.

## Note

* Resource group name is by default set to `Default`, can be overwritten to different resource group.

* For all optional fields, default values (Eg: `null`) are given in variable.tf file. User can configure the same by overwriting with appropriate values.