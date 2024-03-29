---
subcategory: "Data Explorer"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_kusto_cluster_principal_assignment"
description: |-
  Manages a Kusto Cluster Principal Assignment.
---

# azurermKustoClusterPrincipalAssignment

Manages a Kusto Cluster Principal Assignment.

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
    name: "KustoRG",
  }
);
const dataAzurermClientConfigCurrent =
  new azurerm.dataAzurermClientConfig.DataAzurermClientConfig(
    this,
    "current",
    {}
  );
const azurermKustoClusterExample = new azurerm.kustoCluster.KustoCluster(
  this,
  "example_2",
  {
    location: azurermResourceGroupExample.location,
    name: "kustocluster",
    resource_group_name: azurermResourceGroupExample.name,
    sku: [
      {
        capacity: 2,
        name: "Standard_D13_v2",
      },
    ],
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermKustoClusterExample.overrideLogicalId("example");
const azurermKustoClusterPrincipalAssignmentExample =
  new azurerm.kustoClusterPrincipalAssignment.KustoClusterPrincipalAssignment(
    this,
    "example_3",
    {
      cluster_name: azurermKustoClusterExample.name,
      name: "KustoPrincipalAssignment",
      principal_id: dataAzurermClientConfigCurrent.clientId,
      principal_type: "App",
      resource_group_name: azurermResourceGroupExample.name,
      role: "AllDatabasesAdmin",
      tenant_id: dataAzurermClientConfigCurrent.tenantId,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermKustoClusterPrincipalAssignmentExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name of the Kusto cluster principal assignment. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created.

*   `clusterName` - (Required) The name of the cluster in which to create the resource. Changing this forces a new resource to be created.

*   `principalId` - (Required) The object id of the principal. Changing this forces a new resource to be created.

*   `principalType` - (Required) The type of the principal. Valid values include `app`, `group`, `user`. Changing this forces a new resource to be created.

*   `role` - (Required) The cluster role assigned to the principal. Valid values include `allDatabasesAdmin` and `allDatabasesViewer`. Changing this forces a new resource to be created.

*   `tenantId` - (Required) The tenant id in which the principal resides. Changing this forces a new resource to be created.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Kusto Cluster Principal Assignment.

*   `principalName` - The name of the principal.

*   `tenantName` - The name of the tenant.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 1 hour) Used when creating the Data Explorer Cluster Principal Assignment.
* `read` - (Defaults to 5 minutes) Used when retrieving the Data Explorer Cluster Principal Assignment.
* `update` - (Defaults to 1 hour) Used when updating the Data Explorer Cluster Principal Assignment.
* `delete` - (Defaults to 1 hour) Used when deleting the Data Explorer Cluster Principal Assignment.

## Import

Data Explorer Cluster Principal Assignments can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_kusto_cluster_principal_assignment.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Kusto/clusters/cluster1/principalAssignments/assignment1
```
