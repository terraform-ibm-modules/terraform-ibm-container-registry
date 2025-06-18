##############################################################################
# Outputs
##############################################################################

output "namespace_crn" {
  description = "CRN representing the namespace"
  value       = var.existing_namespace_name == null ? module.namespace[0].namespace_crn : null
}

output "namespace_name" {
  description = "Name of ICR namespace"
  # var.namespace_name will be prefixed if var.prefix is not null
  value = var.existing_namespace_name == null ? module.namespace[0].namespace_name : var.existing_namespace_name
}


output "cr_retention_policy_id" {
  description = "ID of retention policy"
  value       = var.existing_namespace_name == null ? module.namespace[0].retention_policy_id : null
}
