---
subcategory: "Nginx"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_nginx_deployment"
description: |-
  Manages a Nginx Deployment.
---

# azurermNginxDeployment

Manages a Nginx Deployment.

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
    name: "example-rg",
  }
);
const azurermVirtualNetworkExample = new azurerm.virtualNetwork.VirtualNetwork(
  this,
  "example_1",
  {
    address_space: ["10.0.0.0/16"],
    location: azurermResourceGroupExample.location,
    name: "example-vnet",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualNetworkExample.overrideLogicalId("example");
const azurermPublicIpExample = new azurerm.publicIp.PublicIp(
  this,
  "example_2",
  {
    allocation_method: "Static",
    location: azurermResourceGroupExample.location,
    name: "example",
    resource_group_name: azurermResourceGroupExample.name,
    sku: "Standard",
    tags: {
      environment: "Production",
    },
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermPublicIpExample.overrideLogicalId("example");
const azurermSubnetExample = new azurerm.subnet.Subnet(this, "example_3", {
  address_prefixes: ["10.0.2.0/24"],
  delegation: [
    {
      name: "delegation",
      service_delegation: [
        {
          actions: ["Microsoft.Network/virtualNetworks/subnets/join/action"],
          name: "NGINX.NGINXPLUS/nginxDeployments",
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
const azurermNginxDeploymentExample =
  new azurerm.nginxDeployment.NginxDeployment(this, "example_4", {
    diagnose_support_enabled: true,
    frontend_public: [
      {
        ip_address: [azurermPublicIpExample.id],
      },
    ],
    location: azurermResourceGroupExample.location,
    managed_resource_group: "example",
    name: "example-nginx",
    network_interface: [
      {
        subnet_id: azurermSubnetExample.id,
      },
    ],
    resource_group_name: azurermResourceGroupExample.name,
    sku: "publicpreview_Monthly_gmz7xq9ge3py",
    tags: {
      foo: "bar",
    },
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNginxDeploymentExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `resourceGroupName` - (Required) The name of the Resource Group where the Nginx Deployment should exist. Changing this forces a new Nginx Deployment to be created.

*   `name` - (Required) The name which should be used for this Nginx Deployment. Changing this forces a new Nginx Deployment to be created.

*   `location` - (Required) The Azure Region where the Nginx Deployment should exist. Changing this forces a new Nginx Deployment to be created.

*   `sku` - (Required) Specify the Name of Nginx deployment SKU. The possible value are `publicpreviewMonthlyGmz7Xq9Ge3Py` and `standardMonthly`.

*   `managedResourceGroup` - (Optional) Specify the managed resource group to deploy VNet injection related network resources. Changing this forces a new Nginx Deployment to be created.

***

*   `diagnoseSupportEnabled` - (Optional) Should the diagnosis support be enabled?

*   `identity` - (Optional) An `identity` block as defined below.

*   `frontendPrivate` - (Optional) One or more `frontendPrivate` blocks as defined below. Changing this forces a new Nginx Deployment to be created.

*   `frontendPublic` - (Optional) A `frontendPublic` block as defined below. Changing this forces a new Nginx Deployment to be created.

*   `loggingStorageAccount` - (Optional) One or more `loggingStorageAccount` blocks as defined below.

*   `networkInterface` - (Optional) One or more `networkInterface` blocks as defined below. Changing this forces a new Nginx Deployment to be created.

*   `tags` - (Optional) A mapping of tags which should be assigned to the Nginx Deployment.

***

A `identity` block supports the following:

*   `type` - (Required) Specifies the identity type of the Nginx Deployment. Possible values is `userAssigned` where you can specify the Service Principal IDs in the `identityIds` field.

*   `identityIds` - (Optional) Specifies a list of user managed identity ids to be assigned. Required if `type` is `userAssigned`.

***

A `frontendPrivate` block supports the following:

*   `allocationMethod` - (Required) Specify the methos of allocating the private IP. Possible values are `static` and `dynamic`.

*   `ipAddress` - (Required) Specify the IP Address of this private IP.

*   `subnetId` - (Required) Specify the SubNet Resource ID to this Nginx Deployment.

***

A `frontendPublic` block supports the following:

* `ipAddress` - (Optional) Specifies a list of Public IP Resouce ID to this Nginx Deployment.

***

A `loggingStorageAccount` block supports the following:

*   `containerName` - (Optional) Specify the container name of Stoage Account for logging.

*   `name` - (Optional) The account name of the StorageAccount for Nginx Logging.

***

A `networkInterface` block supports the following:

* `subnetId` - (Required) Specify The SubNet Resource ID to this Nginx Deployment.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Nginx Deployment.

*   `ipAddress` - The IP address of the deployment.

*   `nginxVersion` - The version of deployed nginx.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Nginx Deployment.
* `read` - (Defaults to 5 minutes) Used when retrieving the Nginx Deployment.
* `update` - (Defaults to 30 minutes) Used when updating the Nginx Deployment.
* `delete` - (Defaults to 30 minutes) Used when deleting the Nginx Deployment.

## Import

Nginx Deployments can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_nginx_deployment.example /subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/group1/providers/Nginx.NginxPlus/nginxDeployments/dep1
```
