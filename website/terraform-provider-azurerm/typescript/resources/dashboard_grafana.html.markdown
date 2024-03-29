---
subcategory: "Dashboard"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_dashboard_grafana"
description: |-
  Manages a Dashboard Grafana.
---

# azurermDashboardGrafana

Manages a Dashboard Grafana.

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
const azurermDashboardGrafanaExample =
  new azurerm.dashboardGrafana.DashboardGrafana(this, "example_1", {
    api_key_enabled: true,
    deterministic_outbound_ip_enabled: true,
    identity: [
      {
        type: "SystemAssigned",
      },
    ],
    location: "West Europe",
    name: "example-dg",
    public_network_access_enabled: false,
    resource_group_name: azurermResourceGroupExample.name,
    tags: {
      key: "value",
    },
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDashboardGrafanaExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name which should be used for this Dashboard Grafana. Changing this forces a new Dashboard Grafana to be created.

*   `resourceGroupName` - (Required) Specifies the name of the Resource Group where the Dashboard Grafana should exist. Changing this forces a new Dashboard Grafana to be created.

*   `location` - (Required) Specifies the Azure Region where the Dashboard Grafana should exist. Changing this forces a new Dashboard Grafana to be created.

*   `apiKeyEnabled` - (Optional) Whether to enable the api key setting of the Grafana instance. Defaults to `false`.

*   `autoGeneratedDomainNameLabelScope` - (Optional) Scope for dns deterministic name hash calculation. The only possible value is `tenantReuse`. Defaults to `tenantReuse`.

*   `deterministicOutboundIpEnabled` - (Optional) Whether to enable the Grafana instance to use deterministic outbound IPs. Defaults to `false`.

*   `azureMonitorWorkspaceIntegrations` - (Optional) A `azureMonitorWorkspaceIntegrations` block as defined below.

*   `identity` - (Optional) An `identity` block as defined below. Changing this forces a new Dashboard Grafana to be created.

*   `publicNetworkAccessEnabled` - (Optional) Whether to enable traffic over the public interface. Defaults to `true`.

*   `sku` - (Optional) The name of the SKU used for the Grafana instance. The only possible value is `standard`. Defaults to `standard`. Changing this forces a new Dashboard Grafana to be created.

*   `tags` - (Optional) A mapping of tags which should be assigned to the Dashboard Grafana.

*   `zoneRedundancyEnabled` - (Optional) Whether to enable the zone redundancy setting of the Grafana instance. Defaults to `false`. Changing this forces a new Dashboard Grafana to be created.

***

An `azureMonitorWorkspaceIntegrations` block supports the following:

* `resourceId` - (Required) Specifies the resource ID of the connected Azure Monitor Workspace.

***

An `identity` block supports the following:

* `type` - (Required) Specifies the type of Managed Service Identity. The only possible values is `systemAssigned`. Changing this forces a new resource to be created.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Dashboard Grafana.

*   `endpoint` - The endpoint of the Grafana instance.

*   `grafanaVersion` - The Grafana software version.

*   `identity` - An `identity` block as defined below.

*   `outboundIp` - List of outbound IPs if deterministicOutboundIP is enabled.

***

An `identity` block exports the following:

*   `principalId` - The Principal ID associated with this Managed Service Identity.

*   `tenantId` - The Tenant ID associated with this Managed Service Identity.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/docs/configuration/resources.html#timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Dashboard Grafana.
* `read` - (Defaults to 5 minutes) Used when retrieving the Dashboard Grafana.
* `update` - (Defaults to 30 minutes) Used when updating the Dashboard Grafana.
* `delete` - (Defaults to 30 minutes) Used when deleting the Dashboard Grafana.

## Import

Dashboard Grafana can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_dashboard_grafana.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup1/providers/Microsoft.Dashboard/grafana/workspace1
```
