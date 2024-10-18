# IBM Cloud Container Registry

This architecture creates IBM Container Registry namespaces and provides the ability to configure pull traffic limits and storage quotas, both in megabytes. It ensures efficient management of container image access by regulating the volume of data that can be pulled from the registry and by setting specific storage capacity limits for container images within each registry:

- A resource group, if existing is not passed in.
- A Container Registry namespace.
- Option to upgrade to `Standard` plan.
- Option to set pull traffic and storage quotas.

![IBM Container Registry](../../reference-architecture/deployable-architecture-icr.svg)

:exclamation: **Important:** This solution is not intended to be called by other modules because it contains a provider configuration and is not compatible with the `for_each`, `count`, and `depends_on` arguments. For more information, see [Providers Within Modules](https://developer.hashicorp.com/terraform/language/modules/develop/providers).
