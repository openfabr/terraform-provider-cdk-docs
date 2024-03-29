---
subcategory: "Logic App"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_logic_app_integration_account_session"
description: |-
  Manages a Logic App Integration Account Session.
---

# azurermLogicAppIntegrationAccountSession

Manages a Logic App Integration Account Session.

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
const azurermLogicAppIntegrationAccountExample =
  new azurerm.logicAppIntegrationAccount.LogicAppIntegrationAccount(
    this,
    "example_1",
    {
      location: azurermResourceGroupExample.location,
      name: "example-ia",
      resource_group_name: azurermResourceGroupExample.name,
      sku_name: "Basic",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLogicAppIntegrationAccountExample.overrideLogicalId("example");
const azurermLogicAppIntegrationAccountSessionExample =
  new azurerm.logicAppIntegrationAccountSession.LogicAppIntegrationAccountSession(
    this,
    "example_2",
    {
      content: ' {\n       "controlNumber": "1234"\n    }\n',
      integration_account_name: azurermLogicAppIntegrationAccountExample.name,
      name: "example-ias",
      resource_group_name: azurermResourceGroupExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLogicAppIntegrationAccountSessionExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Logic App Integration Account Session. Changing this forces a new Logic App Integration Account Session to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Logic App Integration Account Session should exist. Changing this forces a new Logic App Integration Account Session to be created.

*   `integrationAccountName` - (Required) The name of the Logic App Integration Account. Changing this forces a new Logic App Integration Account Session to be created.

*   `content` - (Required) The content of the Logic App Integration Account Session.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the Logic App Integration Account Session.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Logic App Integration Account Session.
* `read` - (Defaults to 5 minutes) Used when retrieving the Logic App Integration Account Session.
* `update` - (Defaults to 30 minutes) Used when updating the Logic App Integration Account Session.
* `delete` - (Defaults to 30 minutes) Used when deleting the Logic App Integration Account Session.

## Import

Logic App Integration Account Sessions can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_logic_app_integration_account_session.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Logic/integrationAccounts/account1/sessions/session1
```
