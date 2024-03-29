---
subcategory: "Monitor"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_monitor_aad_diagnostic_setting"
description: |-
  Manages an Azure Active Directory Diagnostic Setting for Azure Monitor.
---

# azurermMonitorAadDiagnosticSetting

Manages an Azure Active Directory Diagnostic Setting for Azure Monitor.

!> **Authentication** The API for this resource does not support service principal authentication. This resource can only be used with Azure CLI authentication.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.provider.AzurermProvider(this, "azurerm", {
  features: [{}],
});
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example",
  {
    location: "west europe",
    name: "example-rg",
  }
);
const azurermStorageAccountExample = new azurerm.storageAccount.StorageAccount(
  this,
  "example_2",
  {
    account_kind: "StorageV2",
    account_replication_type: "LRS",
    account_tier: "Standard",
    location: azurermResourceGroupExample.location,
    name: "examplestorageaccount",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermStorageAccountExample.overrideLogicalId("example");
const azurermMonitorAadDiagnosticSettingExample =
  new azurerm.monitorAadDiagnosticSetting.MonitorAadDiagnosticSetting(
    this,
    "example_3",
    {
      log: [
        {
          category: "SignInLogs",
          enabled: true,
          retention_policy: [
            {
              days: 1,
              enabled: true,
            },
          ],
        },
        {
          category: "AuditLogs",
          enabled: true,
          retention_policy: [
            {
              days: 1,
              enabled: true,
            },
          ],
        },
        {
          category: "NonInteractiveUserSignInLogs",
          enabled: true,
          retention_policy: [
            {
              days: 1,
              enabled: true,
            },
          ],
        },
        {
          category: "ServicePrincipalSignInLogs",
          enabled: true,
          retention_policy: [
            {
              days: 1,
              enabled: true,
            },
          ],
        },
        {
          category: "ManagedIdentitySignInLogs",
          enabled: false,
          retention_policy: [{}],
        },
        {
          category: "ProvisioningLogs",
          enabled: false,
          retention_policy: [{}],
        },
        {
          category: "ADFSSignInLogs",
          enabled: false,
          retention_policy: [{}],
        },
      ],
      name: "setting1",
      storage_account_id: azurermStorageAccountExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermMonitorAadDiagnosticSettingExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Monitor Azure Active Directory Diagnostic Setting. Changing this forces a new Monitor Azure Active Directory Diagnostic Setting to be created.

*   `log` - (Required) One or more `log` blocks as defined below.

\~> **Note:** At least one of the `log` blocks must have the `enabled` property set to `true`.

***

* `eventhubAuthorizationRuleId` - (Optional) Specifies the ID of an Event Hub Namespace Authorization Rule used to send Diagnostics Data. Changing this forces a new resource to be created.

\-> **NOTE:** This can be sourced from [the `azurermEventhubNamespaceAuthorizationRule` resource](eventhub_namespace_authorization_rule.html) and is different from [a `azurermEventhubAuthorizationRule` resource](eventhub_authorization_rule.html).

*   `eventhubName` - (Optional) Specifies the name of the Event Hub where Diagnostics Data should be sent. If not specified, the default Event Hub will be used. Changing this forces a new resource to be created.

*   `logAnalyticsWorkspaceId` - (Optional) Specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent.

*   `storageAccountId` - (Optional) The ID of the Storage Account where logs should be sent. Changing this forces a new resource to be created.

\-> **NOTE:** One of `eventhubAuthorizationRuleId`, `logAnalyticsWorkspaceId` and `storageAccountId` must be specified.

***

A `log` block supports the following:

*   `category` - (Required) The log category for the Azure Active Directory Diagnostic.

*   `retentionPolicy` - (Required) A `retentionPolicy` block as defined below.

*   `enabled` - (Optional) Is this Diagnostic Log enabled? Defaults to `true`.

***

A `retentionPolicy` block supports the following:

*   `enabled` - (Optional) Is this Retention Policy enabled? Defaults to `false`.

*   `days` - (Optional) The number of days for which this Retention Policy should apply. Defaults to `0`.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the Monitor Azure Active Directory Diagnostic Setting.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 5 minutes) Used when creating the Monitor Azure Active Directory Diagnostic Setting.
* `read` - (Defaults to 5 minutes) Used when retrieving the Monitor Azure Active Directory Diagnostic Setting.
* `update` - (Defaults to 5 minutes) Used when updating the Monitor Azure Active Directory Diagnostic Setting.
* `delete` - (Defaults to 5 minutes) Used when deleting the Monitor Azure Active Directory Diagnostic Setting.

## Import

Monitor Azure Active Directory Diagnostic Settings can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_monitor_aad_diagnostic_setting.example /providers/Microsoft.AADIAM/diagnosticSettings/setting1
```
