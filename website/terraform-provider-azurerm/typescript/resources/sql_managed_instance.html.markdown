---
subcategory: "Database"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_sql_managed_instance"
description: |-
  Manages a SQL Azure Managed Instance.
---

# azurermSqlManagedInstance

Manages a SQL Azure Managed Instance.

\-> **Note:** The `azurermSqlManagedInstance` resource is deprecated in version 3.0 of the AzureRM provider and will be removed in version 4.0. Please use the [`azurermMssqlManagedInstance`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_managed_instance) resource instead.

\~> **Note:** All arguments including the administrator login and password will be stored in the raw state as plain-text. [Read more about sensitive data in state](https://www.terraform.io/language/state/sensitive-data).

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
    name: "database-rg",
  }
);
const azurermVirtualNetworkExample = new azurerm.virtualNetwork.VirtualNetwork(
  this,
  "example_1",
  {
    address_space: ["10.0.0.0/16"],
    location: azurermResourceGroupExample.location,
    name: "vnet-mi",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualNetworkExample.overrideLogicalId("example");
const azurermNetworkSecurityGroupExample =
  new azurerm.networkSecurityGroup.NetworkSecurityGroup(this, "example_2", {
    location: azurermResourceGroupExample.location,
    name: "mi-security-group",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkSecurityGroupExample.overrideLogicalId("example");
new azurerm.networkSecurityRule.NetworkSecurityRule(
  this,
  "allow_health_probe_inbound",
  {
    access: "Allow",
    destination_address_prefix: "*",
    destination_port_range: "*",
    direction: "Inbound",
    name: "allow_health_probe_inbound",
    network_security_group_name: azurermNetworkSecurityGroupExample.name,
    priority: 300,
    protocol: "*",
    resource_group_name: azurermResourceGroupExample.name,
    source_address_prefix: "AzureLoadBalancer",
    source_port_range: "*",
  }
);
new azurerm.networkSecurityRule.NetworkSecurityRule(
  this,
  "allow_management_inbound",
  {
    access: "Allow",
    destination_address_prefix: "*",
    destination_port_ranges: ["9000", "9003", "1438", "1440", "1452"],
    direction: "Inbound",
    name: "allow_management_inbound",
    network_security_group_name: azurermNetworkSecurityGroupExample.name,
    priority: 106,
    protocol: "Tcp",
    resource_group_name: azurermResourceGroupExample.name,
    source_address_prefix: "*",
    source_port_range: "*",
  }
);
new azurerm.networkSecurityRule.NetworkSecurityRule(
  this,
  "allow_management_outbound",
  {
    access: "Allow",
    destination_address_prefix: "*",
    destination_port_ranges: ["80", "443", "12000"],
    direction: "Outbound",
    name: "allow_management_outbound",
    network_security_group_name: azurermNetworkSecurityGroupExample.name,
    priority: 102,
    protocol: "Tcp",
    resource_group_name: azurermResourceGroupExample.name,
    source_address_prefix: "*",
    source_port_range: "*",
  }
);
new azurerm.networkSecurityRule.NetworkSecurityRule(
  this,
  "allow_misubnet_inbound",
  {
    access: "Allow",
    destination_address_prefix: "*",
    destination_port_range: "*",
    direction: "Inbound",
    name: "allow_misubnet_inbound",
    network_security_group_name: azurermNetworkSecurityGroupExample.name,
    priority: 200,
    protocol: "*",
    resource_group_name: azurermResourceGroupExample.name,
    source_address_prefix: "10.0.0.0/24",
    source_port_range: "*",
  }
);
new azurerm.networkSecurityRule.NetworkSecurityRule(
  this,
  "allow_misubnet_outbound",
  {
    access: "Allow",
    destination_address_prefix: "*",
    destination_port_range: "*",
    direction: "Outbound",
    name: "allow_misubnet_outbound",
    network_security_group_name: azurermNetworkSecurityGroupExample.name,
    priority: 200,
    protocol: "*",
    resource_group_name: azurermResourceGroupExample.name,
    source_address_prefix: "10.0.0.0/24",
    source_port_range: "*",
  }
);
new azurerm.networkSecurityRule.NetworkSecurityRule(this, "allow_tds_inbound", {
  access: "Allow",
  destination_address_prefix: "*",
  destination_port_range: "1433",
  direction: "Inbound",
  name: "allow_tds_inbound",
  network_security_group_name: azurermNetworkSecurityGroupExample.name,
  priority: 1000,
  protocol: "Tcp",
  resource_group_name: azurermResourceGroupExample.name,
  source_address_prefix: "VirtualNetwork",
  source_port_range: "*",
});
new azurerm.networkSecurityRule.NetworkSecurityRule(this, "deny_all_inbound", {
  access: "Deny",
  destination_address_prefix: "*",
  destination_port_range: "*",
  direction: "Inbound",
  name: "deny_all_inbound",
  network_security_group_name: azurermNetworkSecurityGroupExample.name,
  priority: 4096,
  protocol: "*",
  resource_group_name: azurermResourceGroupExample.name,
  source_address_prefix: "*",
  source_port_range: "*",
});
new azurerm.networkSecurityRule.NetworkSecurityRule(this, "deny_all_outbound", {
  access: "Deny",
  destination_address_prefix: "*",
  destination_port_range: "*",
  direction: "Outbound",
  name: "deny_all_outbound",
  network_security_group_name: azurermNetworkSecurityGroupExample.name,
  priority: 4096,
  protocol: "*",
  resource_group_name: azurermResourceGroupExample.name,
  source_address_prefix: "*",
  source_port_range: "*",
});
const azurermSubnetExample = new azurerm.subnet.Subnet(this, "example_11", {
  address_prefixes: ["10.0.0.0/24"],
  delegation: [
    {
      name: "managedinstancedelegation",
      service_delegation: [
        {
          actions: [
            "Microsoft.Network/virtualNetworks/subnets/join/action",
            "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
            "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
          ],
          name: "Microsoft.Sql/managedInstances",
        },
      ],
    },
  ],
  name: "subnet-mi",
  resource_group_name: azurermResourceGroupExample.name,
  virtual_network_name: azurermVirtualNetworkExample.name,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetExample.overrideLogicalId("example");
const azurermSubnetNetworkSecurityGroupAssociationExample =
  new azurerm.subnetNetworkSecurityGroupAssociation.SubnetNetworkSecurityGroupAssociation(
    this,
    "example_12",
    {
      network_security_group_id: azurermNetworkSecurityGroupExample.id,
      subnet_id: azurermSubnetExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetNetworkSecurityGroupAssociationExample.overrideLogicalId(
  "example"
);
const azurermRouteTableExample = new azurerm.routeTable.RouteTable(
  this,
  "example_13",
  {
    depends_on: [`\${${azurermSubnetExample.fqn}}`],
    disable_bgp_route_propagation: false,
    location: azurermResourceGroupExample.location,
    name: "routetable-mi",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRouteTableExample.overrideLogicalId("example");
const azurermSubnetRouteTableAssociationExample =
  new azurerm.subnetRouteTableAssociation.SubnetRouteTableAssociation(
    this,
    "example_14",
    {
      route_table_id: azurermRouteTableExample.id,
      subnet_id: azurermSubnetExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetRouteTableAssociationExample.overrideLogicalId("example");
const azurermSqlManagedInstanceExample =
  new azurerm.sqlManagedInstance.SqlManagedInstance(this, "example_15", {
    administrator_login: "mradministrator",
    administrator_login_password: "thisIsDog11",
    depends_on: [
      `\${${azurermSubnetNetworkSecurityGroupAssociationExample.fqn}}`,
      `\${${azurermSubnetRouteTableAssociationExample.fqn}}`,
    ],
    license_type: "BasePrice",
    location: azurermResourceGroupExample.location,
    name: "managedsqlinstance",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "GP_Gen5",
    storage_size_in_gb: 32,
    subnet_id: azurermSubnetExample.id,
    vcores: 4,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSqlManagedInstanceExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the SQL Managed Instance. This needs to be globally unique within Azure. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the resource group in which to create the SQL Server. Changing this forces a new resource to be created.

*   `location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.

*   `skuName` - (Required) Specifies the SKU Name for the SQL Managed Instance. Valid values include `gpGen4`, `gpGen5`, `bcGen4`, `bcGen5`.

*   `vcores` - (Required) Number of cores that should be assigned to your instance. Values can be `8`, `16`, or `24` if `skuName` is `gpGen4`, or `8`, `16`, `24`, `32`, or `40` if `skuName` is `gpGen5`.

*   `storageSizeInGb` - (Required) Maximum storage space for your instance. It should be a multiple of 32GB.

*   `licenseType` - (Required) What type of license the Managed Instance will use. Valid values include can be `licenseIncluded` or `basePrice`.

*   `administratorLogin` - (Required) The administrator login name for the new server. Changing this forces a new resource to be created.

*   `administratorLoginPassword` - (Required) The password associated with the `administratorLogin` user. Needs to comply with Azure's [Password Policy](https://msdn.microsoft.com/library/ms161959.aspx)

*   `subnetId` - (Required) The subnet resource id that the SQL Managed Instance will be associated with. Changing this forces a new resource to be created.

*   `collation` - (Optional) Specifies how the SQL Managed Instance will be collated. Default value is `sqlLatin1GeneralCp1CiAs`. Changing this forces a new resource to be created.

*   `publicDataEndpointEnabled` - (Optional) Is the public data endpoint enabled? Default value is `false`.

*   `minimumTlsVersion` - (Optional) The Minimum TLS Version. Default value is `12` Valid values include `10`, `11`, `12`.

*   `proxyOverride` - (Optional) Specifies how the SQL Managed Instance will be accessed. Default value is `default`. Valid values include `default`, `proxy`, and `redirect`.

*   `timezoneId` - (Optional) The TimeZone ID that the SQL Managed Instance will be operating in. Default value is `utc`. Changing this forces a new resource to be created.

*   `dnsZonePartnerId` - (Optional) The ID of the Managed Instance which will share the DNS zone. This is a prerequisite for creating a `azurermSqlManagedInstanceFailoverGroup`. Setting this after creation forces a new resource to be created.

*   `identity` - (Optional) An `identity` block as defined below.

*   `storageAccountType` - (Optional) Specifies the storage account type used to store backups for this database. Changing this forces a new resource to be created. Possible values are `grs`, `lrs` and `zrs`. The default value is `grs`.

*   `tags` - (Optional) A mapping of tags to assign to the resource.

***

An `identity` block supports the following:

* `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this SQL Managed Instance. The only possible value is `systemAssigned`.

## Attributes Reference

The following attributes are exported:

*   `id` - The SQL Managed Instance ID.

*   `fqdn` - The fully qualified domain name of the Azure Managed SQL Instance

*   `identity` - An `identity` block as defined below.

***

The `identity` block exports the following:

*   `principalId` - The Principal ID for the Service Principal associated with the Identity of this SQL Managed Instance.

*   `tenantId` - The Tenant ID for the Service Principal associated with the Identity of this SQL Managed Instance.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Sql Managed Instance.
* `create` - (Defaults to 24 hours) Used when creating the Sql Managed Instance.
* `update` - (Defaults to 24 hours) Used when updating the Sql Managed Instance.
* `delete` - (Defaults to 24 hours) Used when deleting the Sql Managed Instance.

## Import

SQL Servers can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_sql_managed_instance.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myresourcegroup/providers/Microsoft.Sql/managedInstances/myserver
```
