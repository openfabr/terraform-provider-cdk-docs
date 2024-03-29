---
subcategory: "CosmosDB (DocumentDB)"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_cosmosdb_cassandra_cluster"
description: |-
  Manages a Cassandra Cluster.
---

# azurermCosmosdbCassandraCluster

Manages a Cassandra Cluster.

\~> **NOTE:** In order for the `azureManagedInstancesForApacheCassandra` to work properly the product requires the `azureCosmosDb` Application ID to be present and working in your tenant. If the `azureCosmosDb` Application ID is missing in your environment you will need to have an administrator of your tenant run the following command to add the `azureCosmosDb` Application ID to your tenant:

```powershell
New-AzADServicePrincipal -ApplicationId a232010e-820c-4083-83bb-3ace5fc29d0b
```

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
import * as azuread from "./.gen/providers/azuread";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm, azuread.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.provider.AzurermProvider(this, "azurerm", {
  features: [{}],
});
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example",
  {
    location: "West Europe",
    name: "accexample-rg",
  }
);
const azurermVirtualNetworkExample = new azurerm.virtualNetwork.VirtualNetwork(
  this,
  "example_2",
  {
    address_space: ["10.0.0.0/16"],
    location: azurermResourceGroupExample.location,
    name: "example-vnet",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualNetworkExample.overrideLogicalId("example");
const dataAzureadServicePrincipalExample =
  new azuread.dataAzureadServicePrincipal.DataAzureadServicePrincipal(
    this,
    "example_3",
    {
      display_name: "Azure Cosmos DB",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAzureadServicePrincipalExample.overrideLogicalId("example");
const azurermRoleAssignmentExample = new azurerm.roleAssignment.RoleAssignment(
  this,
  "example_4",
  {
    principal_id: dataAzureadServicePrincipalExample.objectId,
    role_definition_name: "Network Contributor",
    scope: azurermVirtualNetworkExample.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRoleAssignmentExample.overrideLogicalId("example");
const azurermSubnetExample = new azurerm.subnet.Subnet(this, "example_5", {
  address_prefixes: ["10.0.1.0/24"],
  name: "example-subnet",
  resource_group_name: azurermResourceGroupExample.name,
  virtual_network_name: azurermVirtualNetworkExample.name,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetExample.overrideLogicalId("example");
const azurermCosmosdbCassandraClusterExample =
  new azurerm.cosmosdbCassandraCluster.CosmosdbCassandraCluster(
    this,
    "example_6",
    {
      default_admin_password: "Password1234",
      delegated_management_subnet_id: azurermSubnetExample.id,
      depends_on: [`\${${azurermRoleAssignmentExample.fqn}}`],
      location: azurermResourceGroupExample.location,
      name: "example-cluster",
      resource_group_name: azurermResourceGroupExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermCosmosdbCassandraClusterExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Cassandra Cluster. Changing this forces a new Cassandra Cluster to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Cassandra Cluster should exist. Changing this forces a new Cassandra Cluster to be created.

*   `location` - (Required) The Azure Region where the Cassandra Cluster should exist. Changing this forces a new Cassandra Cluster to be created.

*   `delegatedManagementSubnetId` - (Required) The ID of the delegated management subnet for this Cassandra Cluster. Changing this forces a new Cassandra Cluster to be created.

*   `defaultAdminPassword` - (Required) The initial admin password for this Cassandra Cluster. Changing this forces a new resource to be created.

*   `authenticationMethod` - (Optional) The authentication method that is used to authenticate clients. Possible values are `none` and `cassandra`. Defaults to `cassandra`.

*   `clientCertificatePems` - (Optional) A list of TLS certificates that is used to authorize client connecting to the Cassandra Cluster.

*   `externalGossipCertificatePems` - (Optional) A list of TLS certificates that is used to authorize gossip from unmanaged Cassandra Data Center.

*   `externalSeedNodeIpAddresses` - (Optional) A list of IP Addresses of the seed nodes in unmanaged the Cassandra Data Center which will be added to the seed node lists of all managed nodes.

*   `hoursBetweenBackups` - (Optional) The number of hours to wait between taking a backup of the Cassandra Cluster. Defaults to `24`.

\~> **Note:** To disable this feature, set this property to `0`.

*   `identity` - (Optional) An `identity` block as defined below.

*   `repairEnabled` - (Optional) Is the automatic repair enabled on the Cassandra Cluster? Defaults to `true`.

*   `version` - (Optional) The version of Cassandra what the Cluster converges to run. Possible values are `311` and `40`. Defaults to `311`. Changing this forces a new Cassandra Cluster to be created.

*   `tags` - (Optional) A mapping of tags assigned to the resource.

***

A `identity` block supports the following:

* `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this Cassandra Cluster. The only possible value is `systemAssigned`.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the Cassandra Cluster.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Cassandra Cluster.
* `read` - (Defaults to 5 minutes) Used when retrieving the Cassandra Cluster.
* `update` - (Defaults to 30 minutes) Used when updating the Cassandra Cluster.
* `delete` - (Defaults to 30 minutes) Used when deleting the Cassandra Cluster.

## Import

Cassandra Clusters can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_cosmosdb_cassandra_cluster.example /subscriptions/12345678-1234-9876-4563-123456789012/resourceGroups/resGroup1/providers/Microsoft.DocumentDB/cassandraClusters/cluster1
```
