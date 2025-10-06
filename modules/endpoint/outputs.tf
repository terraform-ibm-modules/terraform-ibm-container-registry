##############################################################################
# Outputs
##############################################################################
output "container_registry_endpoint" {
  description = "The public IBM Cloud Container Registry endpoint for the selected region"
  value       = local.endpoints[var.region]
}

output "container_registry_endpoint_private" {
  description = "The private IBM Cloud Container Registry endpoint for the selected region"
  value       = "private.${local.endpoints[var.region]}"
}
