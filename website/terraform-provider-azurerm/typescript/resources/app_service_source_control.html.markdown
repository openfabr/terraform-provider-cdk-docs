---
subcategory: "App Service (Web Apps)"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_app_service_source_control"
description: |-
  Manages an App Service Web App or Function App Source Control Configuration.
---

# azurermAppServiceSourceControl

Manages an App Service Web App or Function App Source Control Configuration.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.provider.AzurermProvider(this, "azurerm", {
  features: [{}],
});
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example",
  {
    location: "West Europe",
    name: "example-resources",
  }
);
const azurermServicePlanExample = new azurerm.servicePlan.ServicePlan(
  this,
  "example_2",
  {
    location: azurermResourceGroupExample.location,
    name: "example",
    os_type: "Linux",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "P1v2",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermServicePlanExample.overrideLogicalId("example");
const azurermLinuxWebAppExample = new azurerm.linuxWebApp.LinuxWebApp(
  this,
  "example_3",
  {
    location: azurermServicePlanExample.location,
    name: "example",
    resource_group_name: azurermResourceGroupExample.name,
    service_plan_id: azurermServicePlanExample.id,
    site_config: [{}],
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLinuxWebAppExample.overrideLogicalId("example");
const azurermAppServiceSourceControlExample =
  new azurerm.appServiceSourceControl.AppServiceSourceControl(
    this,
    "example_4",
    {
      app_id: azurermLinuxWebAppExample.id,
      branch: "master",
      repo_url: "https://github.com/Azure-Samples/python-docs-hello-world",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermAppServiceSourceControlExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

* `appId` - (Required) The ID of the Windows or Linux Web App. Changing this forces a new resource to be created.

\~> **NOTE:** Function apps are not supported at this time.

*   `branch` - (Optional) The branch name to use for deployments. Changing this forces a new resource to be created.

*   `repoUrl` - (Optional) The URL for the repository. Changing this forces a new resource to be created.

***

*   `githubActionConfiguration` - (Optional) A `githubActionConfiguration` block as defined below. Changing this forces a new resource to be created.

*   `useManualIntegration` - (Optional) Should code be deployed manually. Set to `false` to enable continuous integration, such as webhooks into online repos such as GitHub. Defaults to `false`. Changing this forces a new resource to be created.

*   `rollbackEnabled` - (Optional) Should the Deployment Rollback be enabled? Defaults to `false`. Changing this forces a new resource to be created.

\~> **NOTE:** Azure can typically set this value automatically based on the `repoUrl` value.

*   `useLocalGit` - (Optional) Should the App use local Git configuration. Changing this forces a new resource to be created.

*   `useMercurial` - (Optional) The repository specified is Mercurial. Defaults to `false`. Changing this forces a new resource to be created.

***

A `codeConfiguration` block supports the following:

*   `runtimeStack` - (Required) The value to use for the Runtime Stack in the workflow file content for code base apps. Possible values are `dotnetcore`, `spring`, `tomcat`, `node` and `python`. Changing this forces a new resource to be created.

*   `runtimeVersion` - (Required) The value to use for the Runtime Version in the workflow file content for code base apps. Changing this forces a new resource to be created.

***

A `containerConfiguration` block supports the following:

*   `imageName` - (Required) The image name for the build. Changing this forces a new resource to be created.

*   `registryUrl` - (Required) The server URL for the container registry where the build will be hosted. Changing this forces a new resource to be created.

*   `registryPassword` - (Optional) The password used to upload the image to the container registry. Changing this forces a new resource to be created.

*   `registryUsername` - (Optional) The username used to upload the image to the container registry. Changing this forces a new resource to be created.

***

A `githubActionConfiguration` block supports the following:

*   `codeConfiguration` - (Optional) A `codeConfiguration` block as defined above. Changing this forces a new resource to be created.

*   `containerConfiguration` - (Optional) A `containerConfiguration` block as defined above.

*   `generateWorkflowFile` - (Optional) Whether to generate the GitHub work flow file. Defaults to `true`. Changing this forces a new resource to be created.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the App Service Source Control.

*   `usesGithubAction` - Indicates if the Slot uses a GitHub action for deployment. This value is decoded by the service from the repository information supplied.

*   `scmType` - The SCM Type in use. This value is decoded by the service from the repository information supplied.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the App Service Source Control.
* `read` - (Defaults to 5 minutes) Used when retrieving the App Service Source Control.
* `update` - (Defaults to 30 minutes) Used when updating the App Service Source Control.
* `delete` - (Defaults to 30 minutes) Used when deleting the App Service Source Control.

## Import

App Service Source Controls can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_app_service_source_control.example /subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/resGroup1/providers/Microsoft.Web/sites/site1
```
