---
subcategory: "Template"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_resource_deployment_script_azure_cli"
description: |-
  Manages a Resource Deployment Script of Azure Cli.
---

# azurermResourceDeploymentScriptAzureCli

Manages a Resource Deployment Script of Azure Cli.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example",
  {
    location: "West Europe",
    name: "example-resources",
  }
);
const azurermUserAssignedIdentityExample =
  new azurerm.userAssignedIdentity.UserAssignedIdentity(this, "example_1", {
    location: azurermResourceGroupExample.location,
    name: "example-uai",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermUserAssignedIdentityExample.overrideLogicalId("example");
const azurermResourceDeploymentScriptAzureCliExample =
  new azurerm.resourceDeploymentScriptAzureCli.ResourceDeploymentScriptAzureCli(
    this,
    "example_2",
    {
      cleanup_preference: "OnSuccess",
      command_line: "'foo' 'bar'",
      force_update_tag: "1",
      identity: [
        {
          identity_ids: [azurermUserAssignedIdentityExample.id],
          type: "UserAssigned",
        },
      ],
      location: "West Europe",
      name: "example-rdsac",
      resource_group_name: azurermResourceGroupExample.name,
      retention_interval: "P1D",
      script_content:
        '            echo "{\\"name\\":{\\"displayName\\":\\"$1 $2\\"}}" > $AZ_SCRIPTS_OUTPUT_PATH\n',
      tags: {
        key: "value",
      },
      timeout: "PT30M",
      version: "2.40.0",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermResourceDeploymentScriptAzureCliExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name which should be used for this Resource Deployment Script. The name length must be from 1 to 260 characters. The name can only contain alphanumeric, underscore, parentheses, hyphen and period, and it cannot end with a period. Changing this forces a new Resource Deployment Script to be created.

*   `resourceGroupName` - (Required) Specifies the name of the Resource Group where the Resource Deployment Script should exist. Changing this forces a new Resource Deployment Script to be created.

*   `location` - (Required) Specifies the Azure Region where the Resource Deployment Script should exist. Changing this forces a new Resource Deployment Script to be created.

*   `version` - (Required) Azure CLI module version to be used. The supported versions are `2077`, `2078`, `2079`, `2080`, `2081`, `210`, `2100`, `2101`, `2110`, `2111`, `2120`, `2121`, `2130`, `2140`, `2141`, `2142`, `2150`, `2151`, `2160`, `2170`, `2171`, `2180`, `2190`, `2191`, `220`, `2200`, `2210`, `2220`, `2221`, `2230`, `2240`, `2241`, `2242`, `2250`, `2260`, `2261`, `2270`, `2271`, `2272`, `2280`, `2290`, `2291`, `2292`, `230`, `231`, `2300`, `2310`, `2320`, `2330`, `2331`, `2340`, `2341`, `2350`, `2360`, `2370`, `2380`, `2390`, `240`, `2400`, `2410`, `250`, `251`, `260`, `270`, `280`, `290`, `291`. Changing this forces a new Resource Deployment Script to be created.

*   `retentionInterval` - (Required) Interval for which the service retains the script resource after it reaches a terminal state. Resource will be deleted when this duration expires. The time duration should be between `1` hour and `26` hours (inclusive) and should be specified in ISO 8601 format. Changing this forces a new Resource Deployment Script to be created.

*   `commandLine` - (Optional) Command line arguments to pass to the script. Changing this forces a new Resource Deployment Script to be created.

*   `cleanupPreference` - (Optional) Specifies the cleanup preference when the script execution gets in a terminal state. Possible values are `always`, `onExpiration`, `onSuccess`. Defaults to `always`. Changing this forces a new Resource Deployment Script to be created.

*   `container` - (Optional) A `container` block as defined below. Changing this forces a new Resource Deployment Script to be created.

*   `environmentVariable` - (Optional) An `environmentVariable` block as defined below. Changing this forces a new Resource Deployment Script to be created.

*   `forceUpdateTag` - (Optional) Gets or sets how the deployment script should be forced to execute even if the script resource has not changed. Can be current time stamp or a GUID. Changing this forces a new Resource Deployment Script to be created.

*   `identity` - (Optional) An `identity` block as defined below. Changing this forces a new Resource Deployment Script to be created.

*   `primaryScriptUri` - (Optional) Uri for the script. This is the entry point for the external script. Changing this forces a new Resource Deployment Script to be created.

*   `scriptContent` - (Optional) Script body. Changing this forces a new Resource Deployment Script to be created.

*   `storageAccount` - (Optional) A `storageAccount` block as defined below. Changing this forces a new Resource Deployment Script to be created.

*   `supportingScriptUris` - (Optional) Supporting files for the external script. Changing this forces a new Resource Deployment Script to be created.

*   `timeout` - (Optional) Maximum allowed script execution time specified in ISO 8601 format. Needs to be greater than 0 and smaller than 1 day. Defaults to `p1D`. Changing this forces a new Resource Deployment Script to be created.

*   `tags` - (Optional) A mapping of tags which should be assigned to the Resource Deployment Script.

***

A `container` block supports the following:

* `containerGroupName` - (Optional) Container group name, if not specified then the name will get auto-generated. For more information, please refer to the [Container Configuration](https://learn.microsoft.com/en-us/rest/api/resources/deployment-scripts/create?tabs=HTTP#containerconfiguration) documentation.

***

An `environmentVariable` block supports the following:

*   `name` - (Required) Specifies the name of the environment variable.

*   `secureValue` - (Optional) Specifies the value of the secure environment variable.

*   `value` - (Optional) Specifies the value of the environment variable.

***

An `identity` block supports the following:

*   `type` - (Required) Type of the managed identity. The only possible value is `userAssigned`. Changing this forces a new resource to be created.

*   `identityIds` - (Required) Specifies the list of user-assigned managed identity IDs associated with the resource. Changing this forces a new resource to be created.

***

A `storageAccount` block supports the following:

*   `key` - (Required) Specifies the storage account access key.

*   `name` - (Required) Specifies the storage account name.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Resource Deployment Script.

*   `outputs` - List of script outputs.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/docs/configuration/resources.html#timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Resource Deployment Script.
* `read` - (Defaults to 5 minutes) Used when retrieving the Resource Deployment Script.
* `update` - (Defaults to 30 minutes) Used when updating the Resource Deployment Script.
* `delete` - (Defaults to 30 minutes) Used when deleting the Resource Deployment Script.

## Import

Resource Deployment Script can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_resource_deployment_script_azure_cli.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup1/providers/Microsoft.Resources/deploymentScripts/script1
```
