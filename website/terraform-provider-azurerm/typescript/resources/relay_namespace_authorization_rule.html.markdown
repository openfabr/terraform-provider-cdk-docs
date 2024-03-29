---
subcategory: "Messaging"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_relay_namespace_authorization_rule"
description: |-
  Manages an Azure Relay Namespace Authorization Rule.
---

# azurermRelayNamespaceAuthorizationRule

Manages an Azure Relay Namespace Authorization Rule.

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
const azurermRelayNamespaceExample = new azurerm.relayNamespace.RelayNamespace(
  this,
  "example_1",
  {
    location: azurermResourceGroupExample.location,
    name: "example-relay",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "Standard",
    tags: {
      source: "terraform",
    },
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRelayNamespaceExample.overrideLogicalId("example");
const azurermRelayNamespaceAuthorizationRuleExample =
  new azurerm.relayNamespaceAuthorizationRule.RelayNamespaceAuthorizationRule(
    this,
    "example_2",
    {
      listen: true,
      manage: false,
      name: "example",
      namespace_name: azurermRelayNamespaceExample.name,
      resource_group_name: azurermResourceGroupExample.name,
      send: true,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRelayNamespaceAuthorizationRuleExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Azure Relay Namespace Authorization Rule. Changing this forces a new Azure Relay Namespace Authorization Rule to be created.

*   `namespaceName` - (Required) Name of the Azure Relay Namespace for which this Azure Relay Namespace Authorization Rule will be created. Changing this forces a new Azure Relay Namespace Authorization Rule to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Azure Relay Namespace Authorization Rule should exist. Changing this forces a new Azure Relay Namespace Authorization Rule to be created.

***

*   `listen` - (Optional) Grants listen access to this Authorization Rule. Defaults to `false`.

*   `send` - (Optional) Grants send access to this Authorization Rule. Defaults to `false`.

*   `manage` - (Optional) Grants manage access to this Authorization Rule. When this property is `true` - both `listen` and `send` must be set to `true` too. Defaults to `false`.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Azure Relay Namespace Authorization Rule.

*   `primaryKey` - The Primary Key for the Azure Relay Namespace Authorization Rule.

*   `primaryConnectionString` - The Primary Connection String for the Azure Relay Namespace Authorization Rule.

*   `secondaryKey` - The Secondary Key for the Azure Relay Namespace Authorization Rule.

*   `secondaryConnectionString` - The Secondary Connection String for the Azure Relay Namespace Authorization Rule.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Azure Relay Namespace Authorization Rule.
* `read` - (Defaults to 5 minutes) Used when retrieving the Azure Relay Namespace Authorization Rule.
* `update` - (Defaults to 30 minutes) Used when updating the Azure Relay Namespace Authorization Rule.
* `delete` - (Defaults to 30 minutes) Used when deleting the Azure Relay Namespace Authorization Rule.

## Import

Azure Relay Namespace Authorization Rules can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_relay_namespace_authorization_rule.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Relay/namespaces/namespace1/authorizationRules/rule1
```
