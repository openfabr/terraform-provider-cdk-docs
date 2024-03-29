---
subcategory: "Log Analytics"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_log_analytics_cluster_customer_managed_key"
description: |-
  Manages a Log Analytics Cluster Customer Managed Key.
---

# azurermLogAnalyticsClusterCustomerManagedKey

Manages a Log Analytics Cluster Customer Managed Key.

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
    location: "West Europe",
    name: "example-resources",
  }
);
const dataAzurermClientConfigCurrent =
  new azurerm.dataAzurermClientConfig.DataAzurermClientConfig(
    this,
    "current",
    {}
  );
const azurermLogAnalyticsClusterExample =
  new azurerm.logAnalyticsCluster.LogAnalyticsCluster(this, "example_3", {
    identity: [
      {
        type: "SystemAssigned",
      },
    ],
    location: azurermResourceGroupExample.location,
    name: "example-cluster",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLogAnalyticsClusterExample.overrideLogicalId("example");
const azurermKeyVaultExample = new azurerm.keyVault.KeyVault(
  this,
  "example_4",
  {
    access_policy: [
      {
        key_permissions: ["Create", "Get", "GetRotationPolicy"],
        object_id: dataAzurermClientConfigCurrent.objectId,
        secret_permissions: ["Set"],
        tenant_id: dataAzurermClientConfigCurrent.tenantId,
      },
      {
        key_permissions: ["Get", "Unwrapkey", "Wrapkey"],
        object_id: `\${${azurermLogAnalyticsClusterExample.identity}.0.principal_id}`,
        tenant_id: `\${${azurermLogAnalyticsClusterExample.identity}.0.tenant_id}`,
      },
    ],
    location: azurermResourceGroupExample.location,
    name: "keyvaultkeyexample",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "premium",
    tags: {
      environment: "Production",
    },
    tenant_id: dataAzurermClientConfigCurrent.tenantId,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermKeyVaultExample.overrideLogicalId("example");
const azurermKeyVaultKeyExample = new azurerm.keyVaultKey.KeyVaultKey(
  this,
  "example_5",
  {
    key_opts: ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"],
    key_size: 2048,
    key_type: "RSA",
    key_vault_id: azurermKeyVaultExample.id,
    name: "generated-certificate",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermKeyVaultKeyExample.overrideLogicalId("example");
const azurermLogAnalyticsClusterCustomerManagedKeyExample =
  new azurerm.logAnalyticsClusterCustomerManagedKey.LogAnalyticsClusterCustomerManagedKey(
    this,
    "example_6",
    {
      key_vault_key_id: azurermKeyVaultKeyExample.id,
      log_analytics_cluster_id: azurermLogAnalyticsClusterExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLogAnalyticsClusterCustomerManagedKeyExample.overrideLogicalId(
  "example"
);

```

## Arguments Reference

The following arguments are supported:

*   `keyVaultKeyId` - (Required) The ID of the Key Vault Key to use for encryption.

*   `logAnalyticsClusterId` - (Required) The ID of the Log Analytics Cluster. Changing this forces a new Log Analytics Cluster Customer Managed Key to be created.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the Log Analytics Cluster Customer Managed Key.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 6 hours) Used when creating the Log Analytics Cluster Customer Managed Key.
* `read` - (Defaults to 5 minutes) Used when retrieving the Log Analytics Cluster Customer Managed Key.
* `update` - (Defaults to 6 hours) Used when updating the Log Analytics Cluster Customer Managed Key.
* `delete` - (Defaults to 30 minutes) Used when deleting the Log Analytics Cluster Customer Managed Key.

## Import

Log Analytics Cluster Customer Managed Keys can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_log_analytics_cluster_customer_managed_key.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.OperationalInsights/clusters/cluster1
```
