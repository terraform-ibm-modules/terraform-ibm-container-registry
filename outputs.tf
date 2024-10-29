########################################################################################################################
# Outputs
########################################################################################################################

output "namespace_crn" {
  description = "CRN representing the namespace"
  value       = var.create_namespace ? ibm_cr_namespace.cr_namespace[0].crn : local.existing_cr_namespace[0].crn
}


output "retention_policy_id" {
  description = "ID of retentation policy"
  value       = var.images_per_repo != 0 ? ibm_cr_retention_policy.cr_retention_policy[0].id : null
}
