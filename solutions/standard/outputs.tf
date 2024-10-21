##############################################################################
# Outputs
##############################################################################

output "namespace_crn" {
  description = "CRN representing the namespace"
  value       = var.name != null ? module.namespace[0].namespace_crn : null
}
