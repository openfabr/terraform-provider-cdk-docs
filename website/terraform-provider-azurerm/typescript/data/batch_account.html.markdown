---
subcategory: "Batch"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_batch_account"
description: |-
  Get information about an existing Batch Account

---

# Data Source: azurermBatchAccount

Use this data source to access information about an existing Batch Account.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermBatchAccountExample =
  new azurerm.dataAzurermBatchAccount.DataAzurermBatchAccount(this, "example", {
    name: "testbatchaccount",
    resource_group_name: "test",
  });
new cdktf.TerraformOutput(this, "pool_allocation_mode", {
  value: dataAzurermBatchAccountExample.poolAllocationMode,
});

```

## Argument Reference

*   `name` - The name of the Batch account.

*   `resourceGroupName` - The Name of the Resource Group where this Batch account exists.

## Attributes Reference

The following attributes are exported:

*   `id` - The Batch account ID.

*   `name` - The Batch account name.

*   `location` - The Azure Region in which this Batch account exists.

*   `poolAllocationMode` - The pool allocation mode configured for this Batch account.

*   `storageAccountId` - The ID of the Storage Account used for this Batch account.

*   `primaryAccessKey` - The Batch account primary access key.

*   `secondaryAccessKey` - The Batch account secondary access key.

*   `accountEndpoint` - The account endpoint used to interact with the Batch service.

*   `keyVaultReference` - The `keyVaultReference` block that describes the Azure KeyVault reference to use when deploying the Azure Batch account using the `userSubscription` pool allocation mode.

*   `tags` - A map of tags assigned to the Batch account.

\~> **Note:** Primary and secondary access keys are only available when `poolAllocationMode` is set to `batchService`. See [documentation](https://docs.microsoft.com/azure/batch/batch-api-basics) for more information.

***

A `keyVaultReference` block have the following properties:

*   `id` - The Azure identifier of the Azure KeyVault reference.

*   `url` - The HTTPS URL of the Azure KeyVault reference.

***

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Batch Account.
