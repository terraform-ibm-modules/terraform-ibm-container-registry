##############################################################################
# Outputs
##############################################################################

output "namespace_crn" {
  description = "CRN representing the namespace"
  value       = var.namespace_name != null ? module.namespace[0].namespace_crn : null
}


output "cr_retention_policy_id" {
  description = "ID of retention policy"
  value       = var.namespace_name != null ? module.namespace[0].retention_policy_id : null
}
