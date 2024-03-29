---
subcategory: "Network"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_private_link_service_endpoint_connections"
description: |-
  Use this data source to access endpoint connection information about an existing Private Link Service.
---

# Data Source: azurermPrivateLinkServiceEndpointConnections

Use this data source to access endpoint connection information about an existing Private Link Service.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermPrivateLinkServiceEndpointConnectionsExample =
  new azurerm.dataAzurermPrivateLinkServiceEndpointConnections.DataAzurermPrivateLinkServiceEndpointConnections(
    this,
    "example",
    {
      resource_group_name: "${azurerm_resource_group.example.name}",
      service_id: "${azurerm_private_link_service.example.id}",
    }
  );
new cdktf.TerraformOutput(this, "private_endpoint_status", {
  value: `\${${dataAzurermPrivateLinkServiceEndpointConnectionsExample.privateEndpointConnections}.0.status}`,
});

```

## Argument Reference

The following arguments are supported:

*   `serviceId` - The resource ID of the private link service.

*   `resourceGroupName` - The name of the resource group in which the private link service resides.

## Attributes Reference

* `serviceName` - The name of the private link service.

The `privateEndpointConnections` block exports the following:

*   `connectionId` - The resource id of the private link service connection between the private link service and the private link endpoint.

*   `connectionName` - The name of the connection between the private link service and the private link endpoint.

*   `privateEndpointId` - The resource id of the private link endpoint.

*   `privateEndpointName` - The name of the private link endpoint.

*   `actionRequired` - A message indicating if changes on the service provider require any updates or not.

*   `description` -  The request for approval message or the reason for rejection message.

*   `status` - Indicates the state of the connection between the private link service and the private link endpoint, possible values are `pending`, `approved` or `rejected`.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Private Link Service.
