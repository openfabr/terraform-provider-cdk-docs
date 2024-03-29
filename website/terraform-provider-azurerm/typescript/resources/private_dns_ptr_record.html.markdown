---
subcategory: "Private DNS"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_private_dns_ptr_record"
description: |-
  Manages a Private DNS PTR Record.
---

# azurermPrivateDnsPtrRecord

Enables you to manage DNS PTR Records within Azure Private DNS.

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
const azurermPrivateDnsZoneExample = new azurerm.privateDnsZone.PrivateDnsZone(
  this,
  "example_1",
  {
    name: "2.0.192.in-addr.arpa",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermPrivateDnsZoneExample.overrideLogicalId("example");
const azurermPrivateDnsPtrRecordExample =
  new azurerm.privateDnsPtrRecord.PrivateDnsPtrRecord(this, "example_2", {
    name: "15",
    records: ["test.example.com"],
    resource_group_name: azurermResourceGroupExample.name,
    ttl: 300,
    zone_name: azurermPrivateDnsZoneExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermPrivateDnsPtrRecordExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the DNS PTR Record. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created.

*   `zoneName` - (Required) Specifies the Private DNS Zone where the resource exists. Changing this forces a new resource to be created.

*   `ttl` - (Required) The Time To Live (TTL) of the DNS record in seconds.

*   `records` - (Required) List of Fully Qualified Domain Names.

*   `tags` - (Optional) A mapping of tags to assign to the resource.

## Attributes Reference

The following attributes are exported:

*   `id` - The Private DNS PTR Record ID.

*   `fqdn` - The FQDN of the DNS PTR Record.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Private DNS PTR Record.
* `update` - (Defaults to 30 minutes) Used when updating the Private DNS PTR Record.
* `read` - (Defaults to 5 minutes) Used when retrieving the Private DNS PTR Record.
* `delete` - (Defaults to 30 minutes) Used when deleting the Private DNS PTR Record.

## Import

Private DNS PTR Records can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_private_dns_ptr_record.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/privateDnsZones/2.0.192.in-addr.arpa/PTR/15
```
