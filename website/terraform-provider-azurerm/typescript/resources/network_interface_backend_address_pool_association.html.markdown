---
subcategory: "Network"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_network_interface_backend_address_pool_association"
description: |-
  Manages the association between a Network Interface and a Load Balancer's Backend Address Pool.

---

# azurermNetworkInterfaceBackendAddressPoolAssociation

Manages the association between a Network Interface and a Load Balancer's Backend Address Pool.

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
const azurermVirtualNetworkExample = new azurerm.virtualNetwork.VirtualNetwork(
  this,
  "example_1",
  {
    address_space: ["10.0.0.0/16"],
    location: azurermResourceGroupExample.location,
    name: "example-network",
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
    name: "example-pip",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermPublicIpExample.overrideLogicalId("example");
const azurermSubnetExample = new azurerm.subnet.Subnet(this, "example_3", {
  address_prefixes: ["10.0.2.0/24"],
  name: "internal",
  resource_group_name: azurermResourceGroupExample.name,
  virtual_network_name: azurermVirtualNetworkExample.name,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetExample.overrideLogicalId("example");
const azurermLbExample = new azurerm.lb.Lb(this, "example_4", {
  frontend_ip_configuration: [
    {
      name: "primary",
      public_ip_address_id: azurermPublicIpExample.id,
    },
  ],
  location: azurermResourceGroupExample.location,
  name: "example-lb",
  resource_group_name: azurermResourceGroupExample.name,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLbExample.overrideLogicalId("example");
const azurermLbBackendAddressPoolExample =
  new azurerm.lbBackendAddressPool.LbBackendAddressPool(this, "example_5", {
    loadbalancer_id: azurermLbExample.id,
    name: "acctestpool",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLbBackendAddressPoolExample.overrideLogicalId("example");
const azurermNetworkInterfaceExample =
  new azurerm.networkInterface.NetworkInterface(this, "example_6", {
    ip_configuration: [
      {
        name: "testconfiguration1",
        private_ip_address_allocation: "Dynamic",
        subnet_id: azurermSubnetExample.id,
      },
    ],
    location: azurermResourceGroupExample.location,
    name: "example-nic",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkInterfaceExample.overrideLogicalId("example");
const azurermNetworkInterfaceBackendAddressPoolAssociationExample =
  new azurerm.networkInterfaceBackendAddressPoolAssociation.NetworkInterfaceBackendAddressPoolAssociation(
    this,
    "example_7",
    {
      backend_address_pool_id: azurermLbBackendAddressPoolExample.id,
      ip_configuration_name: "testconfiguration1",
      network_interface_id: azurermNetworkInterfaceExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkInterfaceBackendAddressPoolAssociationExample.overrideLogicalId(
  "example"
);

```

## Argument Reference

The following arguments are supported:

*   `networkInterfaceId` - (Required) The ID of the Network Interface. Changing this forces a new resource to be created.

*   `ipConfigurationName` - (Required) The Name of the IP Configuration within the Network Interface which should be connected to the Backend Address Pool. Changing this forces a new resource to be created.

*   `backendAddressPoolId` - (Required) The ID of the Load Balancer Backend Address Pool which this Network Interface should be connected to. Changing this forces a new resource to be created.

## Attributes Reference

The following attributes are exported:

* `id` - The (Terraform specific) ID of the Association between the Network Interface and the Load Balancers Backend Address Pool.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the association between the Network Interface and the Load Balancers Backend Address Pool.
* `update` - (Defaults to 30 minutes) Used when updating the association between the Network Interface and the Load Balancers Backend Address Pool.
* `read` - (Defaults to 5 minutes) Used when retrieving the association between the Network Interface and the Load Balancers Backend Address Pool.
* `delete` - (Defaults to 30 minutes) Used when deleting the association between the Network Interface and the Load Balancers Backend Address Pool.

## Import

Associations between Network Interfaces and Load Balancer Backend Address Pools can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_network_interface_backend_address_pool_association.association1 "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/networkInterfaces/nic1/ipConfigurations/example|/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Network/loadBalancers/lb1/backendAddressPools/pool1"
```

\-> **NOTE:** This ID is specific to Terraform - and is of the format `{networkInterfaceId}/ipConfigurations/{ipConfigurationName}|{backendAddressPoolId}`.
