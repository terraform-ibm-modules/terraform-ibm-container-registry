# IBM Container Registry Terraform Module

This is a collection of modules that make it easier to provision a container registry namespace and configure the image retention policies on IBM Cloud Platform:

* Root module creates namespce and assign image rentention policy based on user input

## Compatibility

This module is meant for use with Terraform 0.13.

## Usage

All the examples are captured under [examples](./examples/) folder, sample to create container namespace and configuring the retention policy:

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
## NOTE:

If we want to make use of a particular version of module, then set the argument "version" to respective module version.

## Requirements

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) 0.13
- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)

## Install

### Terraform

Be sure you have the correct Terraform version (0.13), you can choose the binary here:
- https://releases.hashicorp.com/terraform/

### Terraform plugins

Be sure you have the compiled plugins on $HOME/.terraform.d/plugins/

- [terraform-provider-ibm](https://github.com/IBM-Cloud/terraform-provider-ibm)

### Pre-commit Hooks

Run the following command to execute the pre-commit hooks defined in `.pre-commit-config.yaml` file

  `pre-commit run -a`

We can install pre-coomit tool using

  `pip install pre-commit`

## How to input varaible values through a file

To review the plan for the configuration defined (no resources actually provisioned)

`terraform plan -var-file=./input.tfvars`

To execute and start building the configuration defined in the plan (provisions resources)

`terraform apply -var-file=./input.tfvars`

To destroy the VPC and all related resources

`terraform destroy -var-file=./input.tfvars`

All optional parameters by default will be set to null in respective example's varaible.tf file. If user wants to configure any optional paramter he has overwrite the default value.

## How to configure image retention policy

By default parameter `images_per_repo` is set to null, to enable the retention policy overwrite the `null` with required number of images to retain. This paramter determines how many images will be retained for each repository when the retention policy is executed. The value -1 denotes 'Unlimited' (all images are retained).If we configure `images_per_repo` to say 10 then 10 images will be retained per each repo.

## Note

All optional fields should be given value `null` in respective resource varaible.tf file. User can configure the same by overwriting with appropriate values.