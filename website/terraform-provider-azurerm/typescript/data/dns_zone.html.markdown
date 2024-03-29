---
subcategory: "DNS"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_dns_zone"
description: |-
  Gets information about an existing DNS Zone.

---

# Data Source: azurermDnsZone

Use this data source to access information about an existing DNS Zone.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermDnsZoneExample =
  new azurerm.dataAzurermDnsZone.DataAzurermDnsZone(this, "example", {
    name: "search-eventhubns",
    resource_group_name: "search-service",
  });
new cdktf.TerraformOutput(this, "dns_zone_id", {
  value: dataAzurermDnsZoneExample.id,
});

```

## Argument Reference

*   `name` - The name of the DNS Zone.

*   `resourceGroupName` - (Optional) The Name of the Resource Group where the DNS Zone exists.
    If the Name of the Resource Group is not provided, the first DNS Zone from the list of DNS Zones
    in your subscription that matches `name` will be returned.

## Attributes Reference

*   `id` - The ID of the DNS Zone.

*   `maxNumberOfRecordSets` - Maximum number of Records in the zone.

*   `numberOfRecordSets` - The number of records already in the zone.

*   `nameServers` - A list of values that make up the NS record for the zone.

*   `tags` - A mapping of tags assigned to the DNS Zone.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the DNS Zone.
