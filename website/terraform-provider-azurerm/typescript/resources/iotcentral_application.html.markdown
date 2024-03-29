---
subcategory: "IoT Central"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_iotcentral_application"
description: |-
  Manages an IotCentral Application
---

# azurermIotcentralApplication

Manages an IoT Central Application

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
    name: "example-resource",
  }
);
const azurermIotcentralApplicationExample =
  new azurerm.iotcentralApplication.IotcentralApplication(this, "example_1", {
    display_name: "example-iotcentral-app-display-name",
    location: azurermResourceGroupExample.location,
    name: "example-iotcentral-app",
    resource_group_name: azurermResourceGroupExample.name,
    sku: "ST1",
    sub_domain: "example-iotcentral-app-subdomain",
    tags: {
      Foo: "Bar",
    },
    template: "iotc-default@1.0.0",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermIotcentralApplicationExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name of the IotHub resource. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the resource group under which the IotHub resource has to be created. Changing this forces a new resource to be created.

*   `location` - (Required) Specifies the supported Azure location where the resource has to be create. Changing this forces a new resource to be created.

*   `subDomain` - (Required) A `subDomain` name. Subdomain for the IoT Central URL. Each application must have a unique subdomain.

*   `displayName` - (Optional) A `displayName` name. Custom display name for the IoT Central application. Default is resource name.

\~> **NOTE:** Due to a bug in the provider, the default value of `displayName` of a newly created IoT Central App will be the Resource Group Name, it will be fixed and use resource name in 4.0. For an existing IoT Central App, this could be fixed by specifying the `displayName` explicitly.

*   `identity` - (Optional) An `identity` block as defined below.

*   `publicNetworkAccessEnabled` - (Optional) Whether public network access is allowed for the IoT Central Application. Defaults to `true`.

*   `sku` - (Optional) A `sku` name. Possible values is `st0`, `st1`, `st2`, Default value is `st1`

*   `template` - (Optional) A `template` name. IoT Central application template name. Default is a custom application. Changing this forces a new resource to be created.

*   `tags` - (Optional) A mapping of tags to assign to the resource.

***

The `identity` block supports the following:

* `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this IoT Central Application. The only possible value is `systemAssigned`.

## Attributes Reference

The following attributes are exported:

*   `id` - The ID of the IoT Central Application.

*   `identity` - An `identity` block as defined below.

***

An `identity` block exports the following:

*   `principalId` - The Principal ID associated with this Managed Service Identity.

*   `tenantId` - The Tenant ID associated with this Managed Service Identity.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the IoT Central Application.
* `update` - (Defaults to 30 minutes) Used when updating the IoT Central Application.
* `read` - (Defaults to 5 minutes) Used when retrieving the IoT Central Application.
* `delete` - (Defaults to 30 minutes) Used when deleting the IoT Central Application.

## Import

The IoT Central Application can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_iotcentral_application.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.IoTCentral/iotApps/app1
```
