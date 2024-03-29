---
subcategory: "App Service (Web Apps)"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_app_service_virtual_network_swift_connection"
description: |-
  Manages an App Service Virtual Network Association.

---

# azurermAppServiceVirtualNetworkSwiftConnection

Manages an App Service Virtual Network Association for [Regional VNet Integration](https://docs.microsoft.com/azure/app-service/web-sites-integrate-with-vnet#regional-vnet-integration).

This resource can be used for both App Services and Function Apps.

\~> **Note:** The following resources support associating the vNet for Regional vNet Integration directly on the resource and via the `azurermAppServiceVirtualNetworkSwiftConnection` resource. You can't use both simultaneously.

* [azurerm\_linux\_function\_app](linux_function_app.html)
* [azurerm\_linux\_function\_app\_slot](linux_function_app_slot.html)
* [azurerm\_linux\_web\_app](linux_web_app.html)
* [azurerm\_linux\_web\_app\_slot](linux_web_app_slot.html)
* [azurerm\_logic\_app\_standard](logic_app_standard.html)
* [azurerm\_windows\_function\_app](windows_function_app.html)
* [azurerm\_windows\_function\_app\_slot](windows_function_app_slot.html)
* [azurerm\_windows\_web\_app](windows_web_app.html)
* [azurerm\_windows\_web\_app\_slot](windows_web_app_slot.html)

This resource requires the `microsoftNetwork/virtualNetworks/subnets/write` permission scope on the subnet.

The resource specific vNet integration requires the `microsoftNetwork/virtualNetworks/subnets/join/action` permission scope.

There is a hard limit of [one VNet integration per App Service Plan](https://docs.microsoft.com/azure/app-service/web-sites-integrate-with-vnet#regional-vnet-integration).
Multiple apps in the same App Service plan can use the same VNet.

## Example Usage (with App Service)

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
const azurermVirtualNetworkExample = new azurerm.virtualNetwork.VirtualNetwork(
  this,
  "example_1",
  {
    address_space: ["10.0.0.0/16"],
    location: azurermResourceGroupExample.location,
    name: "example-virtual-network",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualNetworkExample.overrideLogicalId("example");
const azurermAppServicePlanExample = new azurerm.appServicePlan.AppServicePlan(
  this,
  "example_2",
  {
    location: azurermResourceGroupExample.location,
    name: "example-app-service-plan",
    resource_group_name: azurermResourceGroupExample.name,
    sku: [
      {
        size: "S1",
        tier: "Standard",
      },
    ],
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermAppServicePlanExample.overrideLogicalId("example");
const azurermSubnetExample = new azurerm.subnet.Subnet(this, "example_3", {
  address_prefixes: ["10.0.1.0/24"],
  delegation: [
    {
      name: "example-delegation",
      service_delegation: [
        {
          actions: ["Microsoft.Network/virtualNetworks/subnets/action"],
          name: "Microsoft.Web/serverFarms",
        },
      ],
    },
  ],
  name: "example-subnet",
  resource_group_name: azurermResourceGroupExample.name,
  virtual_network_name: azurermVirtualNetworkExample.name,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetExample.overrideLogicalId("example");
const azurermAppServiceExample = new azurerm.appService.AppService(
  this,
  "example_4",
  {
    app_service_plan_id: azurermAppServicePlanExample.id,
    location: azurermResourceGroupExample.location,
    name: "example-app-service",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermAppServiceExample.overrideLogicalId("example");
const azurermAppServiceVirtualNetworkSwiftConnectionExample =
  new azurerm.appServiceVirtualNetworkSwiftConnection.AppServiceVirtualNetworkSwiftConnection(
    this,
    "example_5",
    {
      app_service_id: azurermAppServiceExample.id,
      subnet_id: azurermSubnetExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermAppServiceVirtualNetworkSwiftConnectionExample.overrideLogicalId(
  "example"
);

```

## Example Usage (with Function App)

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
const azurermStorageAccountExample = new azurerm.storageAccount.StorageAccount(
  this,
  "example_1",
  {
    account_replication_type: "LRS",
    account_tier: "Standard",
    location: azurermResourceGroupExample.location,
    name: "functionsappexamplesa",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermVirtualNetworkExample = new azurerm.virtualNetwork.VirtualNetwork(
  this,
  "example_2",
  {
    address_space: ["10.0.0.0/16"],
    location: azurermResourceGroupExample.location,
    name: "example-virtual-network",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualNetworkExample.overrideLogicalId("example");
const azurermAppServicePlanExample = new azurerm.appServicePlan.AppServicePlan(
  this,
  "example_3",
  {
    location: azurermResourceGroupExample.location,
    name: "example-app-service-plan",
    resource_group_name: azurermResourceGroupExample.name,
    sku: [
      {
        size: "S1",
        tier: "Standard",
      },
    ],
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermAppServicePlanExample.overrideLogicalId("example");
const azurermFunctionAppExample = new azurerm.functionApp.FunctionApp(
  this,
  "example_4",
  {
    app_service_plan_id: azurermAppServicePlanExample.id,
    location: azurermResourceGroupExample.location,
    name: "example-function-app",
    resource_group_name: azurermResourceGroupExample.name,
    storage_account_access_key: azurermStorageAccountExample.primaryAccessKey,
    storage_account_name: azurermStorageAccountExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermFunctionAppExample.overrideLogicalId("example");
const azurermSubnetExample = new azurerm.subnet.Subnet(this, "example_5", {
  address_prefixes: ["10.0.1.0/24"],
  delegation: [
    {
      name: "example-delegation",
      service_delegation: [
        {
          actions: ["Microsoft.Network/virtualNetworks/subnets/action"],
          name: "Microsoft.Web/serverFarms",
        },
      ],
    },
  ],
  name: "example-subnet",
  resource_group_name: azurermResourceGroupExample.name,
  virtual_network_name: azurermVirtualNetworkExample.name,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetExample.overrideLogicalId("example");
const azurermAppServiceVirtualNetworkSwiftConnectionExample =
  new azurerm.appServiceVirtualNetworkSwiftConnection.AppServiceVirtualNetworkSwiftConnection(
    this,
    "example_6",
    {
      app_service_id: azurermFunctionAppExample.id,
      subnet_id: azurermSubnetExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermAppServiceVirtualNetworkSwiftConnectionExample.overrideLogicalId(
  "example"
);

```

## Argument Reference

The following arguments are supported:

*   `appServiceId` - (Required) The ID of the App Service or Function App to associate to the VNet. Changing this forces a new resource to be created.

*   `subnetId` - (Required) The ID of the subnet the app service will be associated to (the subnet must have a `serviceDelegation` configured for `microsoftWeb/serverFarms`).

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the App Service Virtual Network Association

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the App Service Virtual Network Association.
* `update` - (Defaults to 30 minutes) Used when updating the App Service Virtual Network Association.
* `read` - (Defaults to 5 minutes) Used when retrieving the App Service Virtual Network Association.
* `delete` - (Defaults to 30 minutes) Used when deleting the App Service Virtual Network Association.

## Import

App Service Virtual Network Associations can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_app_service_virtual_network_swift_connection.myassociation /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Web/sites/instance1/config/virtualNetwork
```
