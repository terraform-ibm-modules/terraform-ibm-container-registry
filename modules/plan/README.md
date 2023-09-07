<!-- BEGIN MODULE HOOK -->
# IBM Container Registry plan

You can use this submodule to upgrade the IBM [Container Registry](https://cloud.ibm.com/docs/Registry?topic=Registry-getting-started) plan.

The submodule extends the root module by including support for multiple buckets. When multiple buckets are required, you keep all the bucket definitions in one place and the deployment information is available in a map that can be iterated over.

## Usage
```hcl
provider "ibm" {
  ibmcloud_api_key = "XXXXXXXXXX" # pragma: allowlist secret
  region           = "us-south"
}

provider "restapi" {

}

# Create:
# - COS buckets, one with encryption and another with versioning
module "upgrade-plan" {
  source  = "terraform-ibm-modules/icr/ibm//modules/plan"
  version = "latest" # Replace "latest" with a release version to lock into a specific release
  resource_group_id = "xxXXxxXXxXxXXXXxxXxxxXXXXxXXXXX"

}
```

## Required IAM access policies

You need the following permissions to run this module.


TODO: validate
- Account Management
    - **Resource Group** service
        - `Viewer` platform access
- IAM Services
    - **IBM Cloud Object Storage** service
        - `Editor` platform access
        - `Manager` service access


## Examples

- [ Basic Example](../../examples/basic)
- [ Cloud Object Storage buckets example](../../examples/existing-resources)
- [ Financial Services Cloud Profile example](../../examples/fscloud)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.51.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_buckets"></a> [buckets](#module\_buckets) | ../../ | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_configs"></a> [bucket\_configs](#input\_bucket\_configs) | Cloud Object Storage bucket configurations | <pre>list(object({<br>    access_tags            = optional(list(string), [])<br>    bucket_name            = string<br>    kms_encryption_enabled = optional(bool, true)<br>    kms_key_crn            = optional(string, null)<br>    cross_region_location  = optional(string, null)<br>    storage_class          = optional(string, "smart")<br>    region_location        = optional(string, null)<br>    resource_group_id      = string<br>    resource_instance_id   = optional(string, null)<br><br>    activity_tracking = optional(object({<br>      read_data_events     = optional(bool, true)<br>      write_data_events    = optional(bool, true)<br>      activity_tracker_crn = optional(string, null)<br>    }))<br>    archive_rule = optional(object({<br>      enable = optional(bool, false)<br>      days   = optional(number, 20)<br>      type   = optional(string, "Glacier")<br>    }))<br>    expire_rule = optional(object({<br>      enable = optional(bool, false)<br>      days   = optional(number, 365)<br>    }))<br>    metrics_monitoring = optional(object({<br>      usage_metrics_enabled   = optional(bool, true)<br>      request_metrics_enabled = optional(bool, true)<br>      metrics_monitoring_crn  = optional(string, null)<br>    }))<br>    object_versioning = optional(object({<br>      enable = optional(bool, false)<br>    }))<br>    retention_rule = optional(object({<br>      default   = optional(number, 90)<br>      maximum   = optional(number, 350)<br>      minimum   = optional(number, 90)<br>      permanent = optional(bool, false)<br>    }))<br>    cbr_rules = optional(list(object({<br>      description = string<br>      account_id  = string<br>      rule_contexts = list(object({<br>        attributes = optional(list(object({<br>          name  = string<br>          value = string<br>      }))) }))<br>      enforcement_mode = string<br>      tags = optional(list(object({<br>        name  = string<br>        value = string<br>      })), [])<br>      operations = optional(list(object({<br>        api_types = list(object({<br>          api_type_id = string<br>        }))<br>      })))<br>    })), [])<br><br>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_configs"></a> [bucket\_configs](#output\_bucket\_configs) | List of bucket config definitions |
| <a name="output_buckets"></a> [buckets](#output\_buckets) | Map of buckets created in the Cloud Object Storage Instance |
