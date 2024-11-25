##############################################################################
# Outputs
##############################################################################

output "namespace_crn" {
  description = "CRN representing the namespace"
  value       = ibm_cr_namespace.cr_namespace.crn
}

output "namespace_name" {
  description = "Namespace name"
  value       = ibm_cr_namespace.cr_namespace.name
}

output "resource_group_name" {
  description = "Resource group name"
  value       = module.resource_group.resource_group_name
}
