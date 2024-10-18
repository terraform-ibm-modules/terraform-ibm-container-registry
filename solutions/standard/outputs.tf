##############################################################################
# Outputs
##############################################################################

output "namespace_crn" {
  description = "CRN representing the namespace"
  value       = module.namespace[0].namespace_crn
}
