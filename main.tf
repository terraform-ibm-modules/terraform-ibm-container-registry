data "ibm_cr_namespaces" "existing_cr_namespaces" {
}

locals {
  existing_cr_namespace = var.existing_namespace_name != null ? [
    for namespace in data.ibm_cr_namespaces.existing_cr_namespaces.namespaces :
    namespace if namespace.name == var.existing_namespace_name
  ] : []

  default_operations = [{
    api_types = [{
      api_type_id = "crn:v1:bluemix:public:context-based-restrictions::::api-type:"
    }]
  }]
}

# *Note- Tags are managed locally and not stored on the IBM Cloud service endpoint.
resource "ibm_cr_namespace" "cr_namespace" {
  count             = var.existing_namespace_name != null ? 0 : 1
  name              = var.namespace_name
  resource_group_id = var.resource_group_id
  tags              = var.tags
}

# workaround for https://github.com/IBM-Cloud/terraform-provider-ibm/issues/6614
resource "time_sleep" "wait_for_namespace" {
  count      = var.existing_namespace_name != null ? 0 : 1
  depends_on = [ibm_cr_namespace.cr_namespace]

  create_duration = "10s"
}

# In addition to locally managed tags on the ibm_cr_namespace resource because https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/cr_namespace#tags-5
resource "ibm_resource_tag" "resource_tag" {
  count       = var.existing_namespace_name != null || length(var.tags) == 0 ? 0 : 1
  resource_id = ibm_cr_namespace.cr_namespace[0].crn
  tags        = var.tags
  tag_type    = "user"
  depends_on  = [time_sleep.wait_for_namespace]
}

resource "ibm_resource_tag" "access_tag" {
  count       = var.existing_namespace_name != null || length(var.access_tags) == 0 ? 0 : 1
  resource_id = ibm_cr_namespace.cr_namespace[0].crn
  tags        = var.access_tags
  tag_type    = "access"
  depends_on  = [time_sleep.wait_for_namespace]
}

resource "ibm_cr_retention_policy" "cr_retention_policy" {
  count           = var.images_per_repo != 0 ? 1 : 0
  namespace       = var.namespace_name
  images_per_repo = var.images_per_repo
  retain_untagged = var.retain_untagged != null ? var.retain_untagged : false
  # Issue 128: to ensure policy fully destroyed before namespace
  depends_on = [ibm_cr_namespace.cr_namespace]
}

moved {
  from = ibm_cr_namespace.cr_namespace
  to   = ibm_cr_namespace.cr_namespace[0]
}


module "namespace_cbr_rules" {
  count            = length(var.cbr_rules)
  source           = "terraform-ibm-modules/cbr/ibm//modules/cbr-rule-module"
  version          = "1.35.8"
  rule_description = var.cbr_rules[count.index].description
  enforcement_mode = var.cbr_rules[count.index].enforcement_mode
  rule_contexts    = var.cbr_rules[count.index].rule_contexts
  resources = [{
    attributes = [
      {
        name     = "accountId"
        value    = var.cbr_rules[count.index].account_id
        operator = "stringEquals"
      },
      {
        name     = "resourceType"
        value    = "namespace"
        operator = "stringEquals"
      },
      {
        name     = "serviceName"
        value    = "container-registry"
        operator = "stringEquals"
      },
      {
        name     = "resource"
        value    = var.namespace_name
        operator = "stringEquals"
      }
    ],
    tags = var.cbr_rules[count.index].tags
  }]
  operations = var.cbr_rules[count.index].operations == null ? local.default_operations : var.cbr_rules[count.index].operations
}
