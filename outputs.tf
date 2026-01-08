# ########################################################################################################################
# Outputs
# ########################################################################################################################

output "namespace_crn" {
  description = "CRN representing the namespace"
  value       = var.existing_namespace_name != null ? local.existing_cr_namespace[0].crn : ibm_cr_namespace.cr_namespace[0].crn
}

output "namespace_name" {
  description = "Name of ICR namespace"
  value       = var.existing_namespace_name != null ? var.existing_namespace_name : var.namespace_name
}

output "retention_policy_id" {
  description = "ID of retentation policy"
  value       = var.images_per_repo != 0 ? ibm_cr_retention_policy.cr_retention_policy[0].id : null
}
