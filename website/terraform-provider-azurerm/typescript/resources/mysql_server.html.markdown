---
subcategory: "Database"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_mysql_server"
description: |-
  Manages a MySQL Server.

---

# azurermMysqlServer

Manages a MySQL Server.

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
const azurermMysqlServerExample = new azurerm.mysqlServer.MysqlServer(
  this,
  "example_1",
  {
    administrator_login: "mysqladminun",
    administrator_login_password: "H@Sh1CoR3!",
    auto_grow_enabled: true,
    backup_retention_days: 7,
    geo_redundant_backup_enabled: false,
    infrastructure_encryption_enabled: false,
    location: azurermResourceGroupExample.location,
    name: "example-mysqlserver",
    public_network_access_enabled: true,
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "B_Gen5_2",
    ssl_enforcement_enabled: true,
    ssl_minimal_tls_version_enforced: "TLS1_2",
    storage_mb: 5120,
    version: "5.7",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermMysqlServerExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name of the MySQL Server. Changing this forces a new resource to be created. This needs to be globally unique within Azure.

*   `resourceGroupName` - (Required) The name of the resource group in which to create the MySQL Server. Changing this forces a new resource to be created.

*   `location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.

*   `skuName` - (Required) Specifies the SKU Name for this MySQL Server. The name of the SKU, follows the `tier` + `family` + `cores` pattern (e.g. `bGen41`, `gpGen58`). For more information see the [product documentation](https://docs.microsoft.com/azure/mysql/concepts-pricing-tiers). Possible values are `bGen41`, `bGen42`, `bGen51`, `bGen52`, `gpGen42`, `gpGen44`, `gpGen48`, `gpGen416`, `gpGen432`, `gpGen52`, `gpGen54`, `gpGen58`, `gpGen516`, `gpGen532`, `gpGen564`, `moGen52`, `moGen54`, `moGen58`, `moGen516` and `moGen532`.

*   `version` - (Required) Specifies the version of MySQL to use. Valid values are `57`, or `80`. Changing this forces a new resource to be created.

*   `administratorLogin` - (Optional) The Administrator login for the MySQL Server. Required when `createMode` is `default`. Changing this forces a new resource to be created.

*   `administratorLoginPassword` - (Optional) The Password associated with the `administratorLogin` for the MySQL Server. Required when `createMode` is `default`.

*   `autoGrowEnabled` - (Optional) Enable/Disable auto-growing of the storage. Storage auto-grow prevents your server from running out of storage and becoming read-only. If storage auto grow is enabled, the storage automatically grows without impacting the workload. The default value if not explicitly specified is `true`.

*   `backupRetentionDays` - (Optional) Backup retention days for the server, supported values are between `7` and `35` days.

*   `createMode` - (Optional) The creation mode. Can be used to restore or replicate existing servers. Possible values are `default`, `replica`, `geoRestore`, and `pointInTimeRestore`. Defaults to `default`.

*   `creationSourceServerId` - (Optional) For creation modes other than `default`, the source server ID to use.

*   `geoRedundantBackupEnabled` - (Optional) Turn Geo-redundant server backups on/off. This allows you to choose between locally redundant or geo-redundant backup storage in the General Purpose and Memory Optimized tiers. When the backups are stored in geo-redundant backup storage, they are not only stored within the region in which your server is hosted, but are also replicated to a paired data center. This provides better protection and ability to restore your server in a different region in the event of a disaster. This is not supported for the Basic tier.

*   `identity` - (Optional) An `identity` block as defined below.

*   `infrastructureEncryptionEnabled` - (Optional) Whether or not infrastructure is encrypted for this server. Changing this forces a new resource to be created.

*   `publicNetworkAccessEnabled` - (Optional) Whether or not public network access is allowed for this server. Defaults to `true`.

*   `restorePointInTime` - (Optional) When `createMode` is `pointInTimeRestore`, specifies the point in time to restore from `creationSourceServerId`. It should be provided in [RFC3339](https://www.rfc-editor.org/rfc/rfc3339) format, e.g. `20131108T22:00:40Z`.

*   `sslEnforcementEnabled` - (Required) Specifies if SSL should be enforced on connections. Possible values are `true` and `false`.

*   `sslMinimalTlsVersionEnforced` - (Optional) The minimum TLS version to support on the sever. Possible values are `tlsEnforcementDisabled`, `tls10`, `tls11`, and `tls12`. Defaults to `tls12`.

*   `storageMb` - (Optional) Max storage allowed for a server. Possible values are between `5120` MB(5GB) and `1048576` MB(1TB) for the Basic SKU and between `5120` MB(5GB) and `16777216` MB(16TB) for General Purpose/Memory Optimized SKUs. For more information see the [product documentation](https://docs.microsoft.com/azure/mysql/concepts-pricing-tiers).

*   `threatDetectionPolicy` - (Optional) Threat detection policy configuration, known in the API as Server Security Alerts Policy. The `threatDetectionPolicy` block supports fields documented below.

*   `tags` - (Optional) A mapping of tags to assign to the resource.

***

A `identity` block supports the following:

* `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this MySQL Server. The only possible value is `systemAssigned`.

***

a `threatDetectionPolicy` block supports the following:

*   `enabled` - (Optional) Is the policy enabled?

*   `disabledAlerts` - (Optional) Specifies a list of alerts which should be disabled. Possible values are `sqlInjection`, `sqlInjectionVulnerability`, `accessAnomaly`, `dataExfiltration` and `unsafeAction`.

*   `emailAccountAdmins` - (Optional) Should the account administrators be emailed when this alert is triggered?

*   `emailAddresses` - (Optional) A list of email addresses which alerts should be sent to.

*   `retentionDays` - (Optional) Specifies the number of days to keep in the Threat Detection audit logs.

*   `storageAccountAccessKey` - (Optional) Specifies the identifier key of the Threat Detection audit storage account.

*   `storageEndpoint` - (Optional) Specifies the blob storage endpoint (e.g. <https://example.blob.core.windows.net>). This blob storage will hold all Threat Detection audit logs.

## Attributes Reference

The following attributes are exported:

*   `id` - The ID of the MySQL Server.

*   `fqdn` - The FQDN of the MySQL Server.

***

An `identity` block exports the following:

*   `principalId` - The Principal ID associated with this Managed Service Identity.

*   `tenantId` - The Tenant ID associated with this Managed Service Identity.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 60 minutes) Used when creating the MySQL Server.
* `update` - (Defaults to 60 minutes) Used when updating the MySQL Server.
* `read` - (Defaults to 5 minutes) Used when retrieving the MySQL Server.
* `delete` - (Defaults to 60 minutes) Used when deleting the MySQL Server.

## Import

MySQL Server's can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_mysql_server.server1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.DBforMySQL/servers/server1
```
