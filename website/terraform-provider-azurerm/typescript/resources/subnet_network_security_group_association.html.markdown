---
subcategory: "Network"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_subnet_network_security_group_association"
description: |-
  Associates a [Network Security Group](network_security_group.html) with a [Subnet](subnet.html) within a [Virtual Network](virtual_network.html).

---

# azurermSubnetNetworkSecurityGroupAssociation

Associates a [Network Security Group](network_security_group.html) with a [Subnet](subnet.html) within a [Virtual Network](virtual_network.html).

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
const azurermNetworkSecurityGroupExample =
  new azurerm.networkSecurityGroup.NetworkSecurityGroup(this, "example_2", {
    location: azurermResourceGroupExample.location,
    name: "example-nsg",
    resource_group_name: azurermResourceGroupExample.name,
    security_rule: [
      {
        access: "Allow",
        destination_address_prefix: "*",
        destination_port_range: "*",
        direction: "Inbound",
        name: "test123",
        priority: 100,
        protocol: "Tcp",
        source_address_prefix: "*",
        source_port_range: "*",
      },
    ],
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkSecurityGroupExample.overrideLogicalId("example");
const azurermSubnetExample = new azurerm.subnet.Subnet(this, "example_3", {
  address_prefixes: ["10.0.2.0/24"],
  name: "frontend",
  resource_group_name: azurermResourceGroupExample.name,
  virtual_network_name: azurermVirtualNetworkExample.name,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetExample.overrideLogicalId("example");
const azurermSubnetNetworkSecurityGroupAssociationExample =
  new azurerm.subnetNetworkSecurityGroupAssociation.SubnetNetworkSecurityGroupAssociation(
    this,
    "example_4",
    {
      network_security_group_id: azurermNetworkSecurityGroupExample.id,
      subnet_id: azurermSubnetExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetNetworkSecurityGroupAssociationExample.overrideLogicalId(
  "example"
);

```

## Argument Reference

The following arguments are supported:

*   `networkSecurityGroupId` - (Required) The ID of the Network Security Group which should be associated with the Subnet. Changing this forces a new resource to be created.

*   `subnetId` - (Required) The ID of the Subnet. Changing this forces a new resource to be created.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the Subnet.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Subnet Network Security Group Association.
* `update` - (Defaults to 30 minutes) Used when updating the Subnet Network Security Group Association.
* `read` - (Defaults to 5 minutes) Used when retrieving the Subnet Network Security Group Association.
* `delete` - (Defaults to 30 minutes) Used when deleting the Subnet Network Security Group Association.

## Import

Subnet `<->` Network Security Group Associations can be imported using the `resourceId` of the Subnet, e.g.

```console
terraform import azurerm_subnet_network_security_group_association.association1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/virtualNetworks/myvnet1/subnets/mysubnet1
```
