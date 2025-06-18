# IBM Cloud Container Registry

This architecture creates or utilizes an existing IBM Container Registry namespace, provides the ability to configure pull traffic limits and storage quotas in megabytes, and allows for upgrading the registry plan to Standard. It ensures efficient management of container image access by regulating data pull volume from the registry and setting storage capacity limits for container images within each registry.

- A resource group, if existing is not passed in.
- A Container Registry namespace.
- Option to upgrade to `Standard` plan.
- Option to set pull traffic and storage quotas.

![IBM Container Registry](../../reference-architecture/deployable-architecture-icr.svg)

:exclamation: **Important:** This solution is not intended to be called by other modules because it contains a provider configuration and is not compatible with the `for_each`, `count`, and `depends_on` arguments. For more information, see [Providers Within Modules](https://developer.hashicorp.com/terraform/language/modules/develop/providers).
