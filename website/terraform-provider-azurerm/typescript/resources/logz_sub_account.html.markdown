---
subcategory: "Logz"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_logz_sub_account"
description: |-
  Manages a logz Sub Account.
---

# azurermLogzSubAccount

Manages a logz Sub Account.

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
    name: "example-logz",
  }
);
const azurermLogzMonitorExample = new azurerm.logzMonitor.LogzMonitor(
  this,
  "example_1",
  {
    location: azurermResourceGroupExample.location,
    name: "example-monitor",
    plan: [
      {
        billing_cycle: "MONTHLY",
        effective_date: "2022-06-06T00:00:00Z",
        usage_type: "COMMITTED",
      },
    ],
    resource_group_name: azurermResourceGroupExample.name,
    user: [
      {
        email: "user@example.com",
        first_name: "Example",
        last_name: "User",
        phone_number: "+12313803556",
      },
    ],
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLogzMonitorExample.overrideLogicalId("example");
const azurermLogzSubAccountExample = new azurerm.logzSubAccount.LogzSubAccount(
  this,
  "example_2",
  {
    logz_monitor_id: azurermLogzMonitorExample.id,
    name: "example-subaccount",
    user: [
      {
        email: `\${${azurermLogzMonitorExample.user.fqn}[0].email}`,
        first_name: `\${${azurermLogzMonitorExample.user.fqn}[0].first_name}`,
        last_name: `\${${azurermLogzMonitorExample.user.fqn}[0].last_name}`,
        phone_number: `\${${azurermLogzMonitorExample.user.fqn}[0].phone_number}`,
      },
    ],
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLogzSubAccountExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this logz Sub Account. Possible values must be between 1 and 32 characters in length and may contain only letters, numbers, hyphens and underscores. Changing this forces a new logz Sub Account to be created.

*   `logzMonitorId` - (Required) The ID of the Logz Monitor. Changing this forces a new logz Sub Account to be created.

*   `user` - (Required) A `user` block as defined below. Changing this forces a new resource to be created.

***

*   `enabled` - (Optional) Whether the resource monitoring is enabled? Defaults to `true`.

*   `tags` - (Optional) A mapping of tags which should be assigned to the logz Sub Account.

***

An `user` block exports the following:

* `email` - (Required) Email of the user used by Logz for contacting them if needed. A valid email address consists of an email prefix and an email domain. The prefix and domain may contain only letters, numbers, underscores, periods and dashes. Changing this forces a new logz Sub Account to be created.

\~> **NOTE** If you use the Azure CLI to authenticate to Azure, the Email of your Azure account needs to be granted the admin permission in your Logz.io account. Otherwise, you may not be able to delete this resource. There is no such limitation for the Service Principal authentication.

*   `firstName` - (Required) First Name of the user. Possible values must be between 1 and 50 characters in length. Changing this forces a new logz Sub Account to be created.

*   `lastName` - (Required) Last Name of the user. Possible values must be between 1 and 50 characters in length. Changing this forces a new logz Sub Account to be created.

*   `phoneNumber` - (Required) Phone number of the user used by Logz for contacting them if needed. Possible values must be between 1 and 40 characters in length. Changing this forces a new logz Sub Account to be created.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the logz Sub Account.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the logz Sub Account.
* `read` - (Defaults to 5 minutes) Used when retrieving the logz Sub Account.
* `update` - (Defaults to 30 minutes) Used when updating the logz Sub Account.
* `delete` - (Defaults to 30 minutes) Used when deleting the logz Sub Account.

## Import

logz SubAccounts can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_logz_sub_account.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Logz/monitors/monitor1/accounts/subAccount1
```
