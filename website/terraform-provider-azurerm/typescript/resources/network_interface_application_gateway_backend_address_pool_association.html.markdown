---
subcategory: "Network"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_network_interface_application_gateway_backend_address_pool_association"
description: |-
  Manages the association between a Network Interface and a Application Gateway's Backend Address Pool.

---

# azurermNetworkInterfaceApplicationGatewayBackendAddressPoolAssociation

Manages the association between a Network Interface and a Application Gateway's Backend Address Pool.

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
const azurermVirtualNetworkExample = new azurerm.virtualNetwork.VirtualNetwork(
  this,
  "example_1",
  {
    address_space: ["10.0.0.0/16"],
    location: azurermResourceGroupExample.location,
    name: "example-network",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualNetworkExample.overrideLogicalId("example");
const backendAddressPoolName = `\${${azurermVirtualNetworkExample.name}}-beap`;
const frontendIpConfigurationName = `\${${azurermVirtualNetworkExample.name}}-feip`;
const frontendPortName = `\${${azurermVirtualNetworkExample.name}}-feport`;
const httpSettingName = `\${${azurermVirtualNetworkExample.name}}-be-htst`;
const listenerName = `\${${azurermVirtualNetworkExample.name}}-httplstn`;
const requestRoutingRuleName = `\${${azurermVirtualNetworkExample.name}}-rqrt`;
const azurermPublicIpExample = new azurerm.publicIp.PublicIp(
  this,
  "example_2",
  {
    allocation_method: "Dynamic",
    location: azurermResourceGroupExample.location,
    name: "example-pip",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermPublicIpExample.overrideLogicalId("example");
new azurerm.subnet.Subnet(this, "backend", {
  address_prefixes: ["10.0.2.0/24"],
  name: "backend",
  resource_group_name: azurermResourceGroupExample.name,
  virtual_network_name: azurermVirtualNetworkExample.name,
});
const azurermSubnetFrontend = new azurerm.subnet.Subnet(this, "frontend", {
  address_prefixes: ["10.0.1.0/24"],
  name: "frontend",
  resource_group_name: azurermResourceGroupExample.name,
  virtual_network_name: azurermVirtualNetworkExample.name,
});
const azurermApplicationGatewayNetwork =
  new azurerm.applicationGateway.ApplicationGateway(this, "network", {
    backend_address_pool: [
      {
        name: backendAddressPoolName,
      },
    ],
    backend_http_settings: [
      {
        cookie_based_affinity: "Disabled",
        name: httpSettingName,
        port: 80,
        protocol: "Http",
        request_timeout: 1,
      },
    ],
    frontend_ip_configuration: [
      {
        name: frontendIpConfigurationName,
        public_ip_address_id: azurermPublicIpExample.id,
      },
    ],
    frontend_port: [
      {
        name: frontendPortName,
        port: 80,
      },
    ],
    gateway_ip_configuration: [
      {
        name: "my-gateway-ip-configuration",
        subnet_id: azurermSubnetFrontend.id,
      },
    ],
    http_listener: [
      {
        frontend_ip_configuration_name: frontendIpConfigurationName,
        frontend_port_name: frontendPortName,
        name: listenerName,
        protocol: "Http",
      },
    ],
    location: azurermResourceGroupExample.location,
    name: "example-appgateway",
    request_routing_rule: [
      {
        backend_address_pool_name: backendAddressPoolName,
        backend_http_settings_name: httpSettingName,
        http_listener_name: listenerName,
        name: requestRoutingRuleName,
        priority: 25,
        rule_type: "Basic",
      },
    ],
    resource_group_name: azurermResourceGroupExample.name,
    sku: [
      {
        capacity: 2,
        name: "Standard_Small",
        tier: "Standard",
      },
    ],
  });
const azurermNetworkInterfaceExample =
  new azurerm.networkInterface.NetworkInterface(this, "example_6", {
    ip_configuration: [
      {
        name: "testconfiguration1",
        private_ip_address_allocation: "Dynamic",
        subnet_id: azurermSubnetFrontend.id,
      },
    ],
    location: azurermResourceGroupExample.location,
    name: "example-nic",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkInterfaceExample.overrideLogicalId("example");
const azurermNetworkInterfaceApplicationGatewayBackendAddressPoolAssociationExample =
  new azurerm.networkInterfaceApplicationGatewayBackendAddressPoolAssociation.NetworkInterfaceApplicationGatewayBackendAddressPoolAssociation(
    this,
    "example_7",
    {
      backend_address_pool_id: `\${tolist(${azurermApplicationGatewayNetwork.backendAddressPool}).0.id}`,
      ip_configuration_name: "testconfiguration1",
      network_interface_id: azurermNetworkInterfaceExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkInterfaceApplicationGatewayBackendAddressPoolAssociationExample.overrideLogicalId(
  "example"
);

```

## Argument Reference

The following arguments are supported:

*   `networkInterfaceId` - (Required) The ID of the Network Interface. Changing this forces a new resource to be created.

*   `ipConfigurationName` - (Required) The Name of the IP Configuration within the Network Interface which should be connected to the Backend Address Pool. Changing this forces a new resource to be created.

*   `backendAddressPoolId` - (Required) The ID of the Application Gateway's Backend Address Pool which this Network Interface which should be connected to. Changing this forces a new resource to be created.

## Attributes Reference

The following attributes are exported:

* `id` - The (Terraform specific) ID of the Association between the Network Interface and the Application Gateway Backend Address Pool.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the association between the Network Interface and the Application Gateway Backend Address Pool.
* `update` - (Defaults to 30 minutes) Used when updating the association between the Network Interface and the Application Gateway Backend Address Pool.
* `read` - (Defaults to 5 minutes) Used when retrieving the association between the Network Interface and the Application Gateway Backend Address Pool.
* `delete` - (Defaults to 30 minutes) Used when deleting the association between the Network Interface and the Application Gateway Backend Address Pool.

## Import

Associations between Network Interfaces and Application Gateway Backend Address Pools can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_network_interface_application_gateway_backend_address_pool_association.association1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/networkInterfaces/nic1/ipConfigurations/example|/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Network/applicationGateways/gateway1/backendAddressPools/pool1
```

\-> **NOTE:** This ID is specific to Terraform - and is of the format `{networkInterfaceId}/ipConfigurations/{ipConfigurationName}|{backendAddressPoolId}`.
