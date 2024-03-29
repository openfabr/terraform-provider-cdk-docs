---
subcategory: "Network"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_virtual_hub_route_table"
description: |-
  Manages a Virtual Hub Route Table.
---

# azurermVirtualHubRouteTable

Manages a Virtual Hub Route Table.

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
    address_space: ["10.5.0.0/16"],
    location: azurermResourceGroupExample.location,
    name: "example-vnet",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualNetworkExample.overrideLogicalId("example");
const azurermVirtualWanExample = new azurerm.virtualWan.VirtualWan(
  this,
  "example_2",
  {
    location: azurermResourceGroupExample.location,
    name: "example-vwan",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualWanExample.overrideLogicalId("example");
const azurermNetworkSecurityGroupExample =
  new azurerm.networkSecurityGroup.NetworkSecurityGroup(this, "example_3", {
    location: azurermResourceGroupExample.location,
    name: "example-nsg",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkSecurityGroupExample.overrideLogicalId("example");
const azurermSubnetExample = new azurerm.subnet.Subnet(this, "example_4", {
  address_prefixes: ["10.5.1.0/24"],
  name: "examplesubnet",
  resource_group_name: azurermResourceGroupExample.name,
  virtual_network_name: azurermVirtualNetworkExample.name,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetExample.overrideLogicalId("example");
const azurermSubnetNetworkSecurityGroupAssociationExample =
  new azurerm.subnetNetworkSecurityGroupAssociation.SubnetNetworkSecurityGroupAssociation(
    this,
    "example_5",
    {
      network_security_group_id: azurermNetworkSecurityGroupExample.id,
      subnet_id: azurermSubnetExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetNetworkSecurityGroupAssociationExample.overrideLogicalId(
  "example"
);
const azurermVirtualHubExample = new azurerm.virtualHub.VirtualHub(
  this,
  "example_6",
  {
    address_prefix: "10.0.2.0/24",
    location: azurermResourceGroupExample.location,
    name: "example-vhub",
    resource_group_name: azurermResourceGroupExample.name,
    virtual_wan_id: azurermVirtualWanExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualHubExample.overrideLogicalId("example");
const azurermVirtualHubConnectionExample =
  new azurerm.virtualHubConnection.VirtualHubConnection(this, "example_7", {
    name: "example-vhubconn",
    remote_virtual_network_id: azurermVirtualNetworkExample.id,
    virtual_hub_id: azurermVirtualHubExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualHubConnectionExample.overrideLogicalId("example");
const azurermVirtualHubRouteTableExample =
  new azurerm.virtualHubRouteTable.VirtualHubRouteTable(this, "example_8", {
    labels: ["label1"],
    name: "example-vhubroutetable",
    route: [
      {
        destinations: ["10.0.0.0/16"],
        destinations_type: "CIDR",
        name: "example-route",
        next_hop: azurermVirtualHubConnectionExample.id,
        next_hop_type: "ResourceId",
      },
    ],
    virtual_hub_id: azurermVirtualHubExample.id,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualHubRouteTableExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for Virtual Hub Route Table. Changing this forces a new resource to be created.

*   `virtualHubId` - (Required) The ID of the Virtual Hub within which this route table should be created. Changing this forces a new resource to be created.

*   `labels` - (Optional) List of labels associated with this route table.

*   `route` - (Optional) A `route` block as defined below.

***

An `route` block exports the following:

*   `name` - (Required) The name which should be used for this route.

*   `destinations` - (Required) A list of destination addresses for this route.

*   `destinationsType` - (Required) The type of destinations. Possible values are `cidr`, `resourceId` and `service`.

*   `nextHop` - (Required) The next hop's resource ID.

*   `nextHopType` - (Optional) The type of next hop. Currently the only possible value is `resourceId`. Defaults to `resourceId`.

\~> **Note:** The Routes can alternatively be created using the [virtual\_hub\_route\_table\_route](virtual_hub_route_table_route.html) resource. Using both inline and external routes is not supported and may result in unexpected configuration.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the Virtual Hub Route Table.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Virtual Hub Route Table.
* `read` - (Defaults to 5 minutes) Used when retrieving the Virtual Hub Route Table.
* `update` - (Defaults to 30 minutes) Used when updating the Virtual Hub Route Table.
* `delete` - (Defaults to 30 minutes) Used when deleting the Virtual Hub Route Table.

## Import

Virtual Hub Route Tables can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_virtual_hub_route_table.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Network/virtualHubs/virtualHub1/hubRouteTables/routeTable1
```
