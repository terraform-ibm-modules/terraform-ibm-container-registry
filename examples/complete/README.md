# IBM Container Registry namespace example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=container-registry-complete-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-container-registry/tree/main/examples/complete"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom;"></a>
<!-- END SCHEMATICS DEPLOY HOOK -->


This example creates the following infrastructure:

- A new resource group, if one is not passed in.
- A new IBM Container Registry namespace.
- Optionally, a new retention policy for the namespace.
- A sample VPC for applying CBR rules on it to get registry access.
- Create a CBR rule that allows the registry namespace to be accessed only by the Toolchain service and the VPC created in the example. This ensures that clusters within the VPC can pull images from the registry namespace, while the Toolchain service can push images to it as part of pipelines. The rule also allows the Schematics service to access the container registry namespace so that Terraform operations on the container registry resources are not affected once the CBR rules are enforced after the initial apply.

<!-- BEGIN SCHEMATICS DEPLOY TIP HOOK -->
:information_source: Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab
<!-- END SCHEMATICS DEPLOY TIP HOOK -->
