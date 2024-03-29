---
subcategory: "NetApp"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_netapp_pool"
description: |-
  Gets information about an existing NetApp Pool
---

# Data Source: azurermNetappPool

Uses this data source to access information about an existing NetApp Pool.

## NetApp Pool Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermNetappPoolExample =
  new azurerm.dataAzurermNetappPool.DataAzurermNetappPool(this, "example", {
    account_name: "acctestnetappaccount",
    name: "acctestnetapppool",
    resource_group_name: "acctestRG",
  });
new cdktf.TerraformOutput(this, "netapp_pool_id", {
  value: dataAzurermNetappPoolExample.id,
});

```

## Argument Reference

The following arguments are supported:

*   `name` - The name of the NetApp Pool.

*   `accountName` - The name of the NetApp account where the NetApp pool exists.

*   `resourceGroupName` - The Name of the Resource Group where the NetApp Pool exists.

## Attributes Reference

The following attributes are exported:

*   `location` - The Azure Region where the NetApp Pool exists.

*   `serviceLevel` - The service level of the file system.

*   `sizeInTb` - Provisioned size of the pool in TB.

***

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the NetApp Pool.
