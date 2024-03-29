---
subcategory: "Log Analytics"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_log_analytics_cluster"
description: |-
  Manages a Log Analytics Cluster.
---

# azurermLogAnalyticsCluster

\~> **Note:** Log Analytics Clusters are subject to 14-day soft delete policy. Clusters created with the same resource group & name as a previously deleted cluster will be recovered rather than creating anew.

Manages a Log Analytics Cluster.

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
const azurermLogAnalyticsClusterExample =
  new azurerm.logAnalyticsCluster.LogAnalyticsCluster(this, "example_2", {
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

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Log Analytics Cluster. Changing this forces a new Log Analytics Cluster to be created.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Log Analytics Cluster should exist. Changing this forces a new Log Analytics Cluster to be created.

*   `location` - (Required) The Azure Region where the Log Analytics Cluster should exist. Changing this forces a new Log Analytics Cluster to be created.

*   `identity` - (Required) An `identity` block as defined below. Changing this forces a new Log Analytics Cluster to be created.

*   `sizeGb` - (Optional) The capacity of the Log Analytics Cluster is specified in GB/day. Possible values include `500`, `1000`, `2000` or `5000`. Defaults to `1000`.

\~> **NOTE:** The cluster capacity must start at 500 GB and can be set to 1000, 2000 or 5000 GB/day. For more information on cluster costs, see [Dedicated clusters](https://docs.microsoft.com/en-us/azure/azure-monitor/logs/cost-logs#dedicated-clusters). In v3.x the default value is `1000` GB, in v4.0 of the provider this will default to `500` GB.

* `tags` - (Optional) A mapping of tags which should be assigned to the Log Analytics Cluster.

***

An `identity` block supports the following:

* `type` - (Required) Specifies the type of Managed Service Identity that should be configured on this Log Analytics Cluster. The only possible value is `systemAssigned`. Changing this forces a new resource to be created.

\~> **NOTE:** The assigned `principalId` and `tenantId` can be retrieved after the identity `type` has been set to `systemAssigned` and the Log Analytics Cluster has been created. More details are available below.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Log Analytics Cluster.

*   `identity` - A `identity` block as defined below.

*   `clusterId` - The GUID of the cluster.

***

An `identity` block exports the following:

*   `principalId` - The Principal ID associated with this Managed Service Identity.

*   `tenantId` - The Tenant ID associated with this Managed Service Identity.

*   `type` - (Required) The identity type of this Managed Service Identity.

\-> You can access the Principal ID via `azurermLogAnalyticsClusterExampleIdentity0PrincipalId` and the Tenant ID via `azurermLogAnalyticsClusterExampleIdentity0TenantId`

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 6 hours) Used when creating the Log Analytics Cluster.
* `read` - (Defaults to 5 minutes) Used when retrieving the Log Analytics Cluster.
* `update` - (Defaults to 6 hours) Used when updating the Log Analytics Cluster.
* `delete` - (Defaults to 30 minutes) Used when deleting the Log Analytics Cluster.

## Import

Log Analytics Clusters can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_log_analytics_cluster.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.OperationalInsights/clusters/cluster1
```
