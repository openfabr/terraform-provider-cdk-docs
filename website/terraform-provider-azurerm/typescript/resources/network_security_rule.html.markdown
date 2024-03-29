---
subcategory: "Network"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_network_security_rule"
description: |-
  Manages a Network Security Rule.

---

# azurermNetworkSecurityRule

Manages a Network Security Rule.

\~> **NOTE on Network Security Groups and Network Security Rules:** Terraform currently
provides both a standalone [Network Security Rule resource](network_security_rule.html), and allows for Network Security Rules to be defined in-line within the [Network Security Group resource](network_security_group.html).
At this time you cannot use a Network Security Group with in-line Network Security Rules in conjunction with any Network Security Rule resources. Doing so will cause a conflict of rule settings and will overwrite rules.

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
const azurermNetworkSecurityGroupExample =
  new azurerm.networkSecurityGroup.NetworkSecurityGroup(this, "example_1", {
    location: azurermResourceGroupExample.location,
    name: "acceptanceTestSecurityGroup1",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkSecurityGroupExample.overrideLogicalId("example");
const azurermNetworkSecurityRuleExample =
  new azurerm.networkSecurityRule.NetworkSecurityRule(this, "example_2", {
    access: "Allow",
    destination_address_prefix: "*",
    destination_port_range: "*",
    direction: "Outbound",
    name: "test123",
    network_security_group_name: azurermNetworkSecurityGroupExample.name,
    priority: 100,
    protocol: "Tcp",
    resource_group_name: azurermResourceGroupExample.name,
    source_address_prefix: "*",
    source_port_range: "*",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkSecurityRuleExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the security rule. This needs to be unique across all Rules in the Network Security Group. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the resource group in which to create the Network Security Rule. Changing this forces a new resource to be created.

*   `networkSecurityGroupName` - (Required) The name of the Network Security Group that we want to attach the rule to. Changing this forces a new resource to be created.

*   `description` - (Optional) A description for this rule. Restricted to 140 characters.

*   `protocol` - (Required) Network protocol this rule applies to. Possible values include `tcp`, `udp`, `icmp`, `esp`, `ah` or `*` (which matches all).

*   `sourcePortRange` - (Optional) Source Port or Range. Integer or range between `0` and `65535` or `*` to match any. This is required if `sourcePortRanges` is not specified.

*   `sourcePortRanges` - (Optional) List of source ports or port ranges. This is required if `sourcePortRange` is not specified.

*   `destinationPortRange` - (Optional) Destination Port or Range. Integer or range between `0` and `65535` or `*` to match any. This is required if `destinationPortRanges` is not specified.

*   `destinationPortRanges` - (Optional) List of destination ports or port ranges. This is required if `destinationPortRange` is not specified.

*   `sourceAddressPrefix` - (Optional) CIDR or source IP range or \* to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. This is required if `sourceAddressPrefixes` is not specified.

*   `sourceAddressPrefixes` - (Optional) List of source address prefixes. Tags may not be used. This is required if `sourceAddressPrefix` is not specified.

*   `sourceApplicationSecurityGroupIds` - (Optional) A List of source Application Security Group IDs

*   `destinationAddressPrefix` - (Optional) CIDR or destination IP range or \* to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. Besides, it also supports all available Service Tags like ‘Sql.WestEurope‘, ‘Storage.EastUS‘, etc. You can list the available service tags with the CLI: `shellAzNetworkListServiceTagsLocationWestcentralus`. For further information please see [Azure CLI - az network list-service-tags](https://docs.microsoft.com/cli/azure/network?view=azure-cli-latest#az-network-list-service-tags). This is required if `destinationAddressPrefixes` is not specified.

*   `destinationAddressPrefixes` - (Optional) List of destination address prefixes. Tags may not be used. This is required if `destinationAddressPrefix` is not specified.

*   `destinationApplicationSecurityGroupIds` - (Optional) A List of destination Application Security Group IDs

*   `access` - (Required) Specifies whether network traffic is allowed or denied. Possible values are `allow` and `deny`.

*   `priority` - (Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule.

*   `direction` - (Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are `inbound` and `outbound`.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the Network Security Rule.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Network Security Rule.
* `update` - (Defaults to 30 minutes) Used when updating the Network Security Rule.
* `read` - (Defaults to 5 minutes) Used when retrieving the Network Security Rule.
* `delete` - (Defaults to 30 minutes) Used when deleting the Network Security Rule.

## Import

Network Security Rules can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_network_security_rule.rule1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/networkSecurityGroups/mySecurityGroup/securityRules/rule1
```
