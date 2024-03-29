---
subcategory: "Network"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_virtual_network_gateway_connection"
description: |-
  Gets information about an existing Virtual Network Gateway Connection.
---

# Data Source: azurermVirtualNetworkGatewayConnection

Use this data source to access information about an existing Virtual Network Gateway Connection.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermVirtualNetworkGatewayConnectionExample =
  new azurerm.dataAzurermVirtualNetworkGatewayConnection.DataAzurermVirtualNetworkGatewayConnection(
    this,
    "example",
    {
      name: "production",
      resource_group_name: "networking",
    }
  );
new cdktf.TerraformOutput(this, "virtual_network_gateway_connection_id", {
  value: dataAzurermVirtualNetworkGatewayConnectionExample.id,
});

```

## Argument Reference

* `name` - Specifies the name of the Virtual Network Gateway Connection.
* `resourceGroupName` - Specifies the name of the resource group the Virtual Network Gateway Connection is located in.

## Attributes Reference

*   `id` - The ID of the Virtual Network Gateway Connection.

*   `location` - The location/region where the connection is
    located.

*   `type` - The type of connection. Valid options are `iPsec`
    (Site-to-Site), `expressRoute` (ExpressRoute), and `vnet2Vnet` (VNet-to-VNet).

*   `virtualNetworkGatewayId` - The ID of the Virtual Network Gateway
    in which the connection is created.

*   `authorizationKey` - The authorization key associated with the
    Express Route Circuit. This field is present only if the type is an
    ExpressRoute connection.

*   `dpdTimeoutSeconds` - The dead peer detection timeout of this connection in seconds.

*   `expressRouteCircuitId` - The ID of the Express Route Circuit
    (i.e. when `type` is `expressRoute`).

*   `peerVirtualNetworkGatewayId` - The ID of the peer virtual
    network gateway when a VNet-to-VNet connection (i.e. when `type`
    is `vnet2Vnet`).

*   `localAzureIpAddressEnabled` - Use private local Azure IP for the connection.

*   `localNetworkGatewayId` - The ID of the local network gateway
    when a Site-to-Site connection (i.e. when `type` is `iPsec`).

*   `routingWeight` - The routing weight.

*   `sharedKey` - The shared IPSec key.

*   `enableBgp` - If `true`, BGP (Border Gateway Protocol) is enabled
    for this connection.

*   `customBgpAddresses` - (Optional) A `customBgpAddresses` (Border Gateway Protocol custom IP Addresses) block which is documented below.
    The block can only be used on `ipSec` / `activeactive` connections,
    For details about see [the relevant section in the Azure documentation](https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-howto-aws-bgp).

*   `expressRouteGatewayBypass` - If `true`, data packets will bypass ExpressRoute Gateway for data forwarding. This is only valid for ExpressRoute connections.

*   `usePolicyBasedTrafficSelectors` - If `true`, policy-based traffic
    selectors are enabled for this connection. Enabling policy-based traffic
    selectors requires an `ipsecPolicy` block.

*   `ipsecPolicy` (Optional) A `ipsecPolicy` block which is documented below.
    Only a single policy can be defined for a connection. For details on
    custom policies refer to [the relevant section in the Azure documentation](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-ipsecikepolicy-rm-powershell).

*   `trafficSelectorPolicy` One or more `trafficSelectorPolicy` blocks which are documented below.
    A `trafficSelectorPolicy` allows to specify a traffic selector policy proposal to be used in a virtual network gateway connection.
    For details about traffic selectors refer to [the relevant section in the Azure documentation](https://docs.microsoft.com/azure/vpn-gateway/vpn-gateway-connect-multiple-policybased-rm-ps).

*   `tags` - A mapping of tags to assign to the resource.

The `customBgpAddresses` block supports:

* `primary` (Required) single IP address that is part of the `azurermVirtualNetworkGateway` ip\_configuration (first one)
* `secondary` (Required) single IP address that is part of the `azurermVirtualNetworkGateway` ip\_configuration (second one)

The `ipsecPolicy` block supports:

*   `dhGroup` - The DH group used in IKE phase 1 for initial SA. Valid
    options are `dhGroup1`, `dhGroup14`, `dhGroup2`, `dhGroup2048`, `dhGroup24`,
    `ecp256`, `ecp384`, or `none`.

*   `ikeEncryption` - The IKE encryption algorithm. Valid
    options are `aes128`, `aes192`, `aes256`, `des`, or `des3`.

*   `ikeIntegrity` - The IKE integrity algorithm. Valid
    options are `md5`, `sha1`, `sha256`, or `sha384`.

*   `ipsecEncryption` - The IPSec encryption algorithm. Valid
    options are `aes128`, `aes192`, `aes256`, `des`, `des3`, `gcmaes128`, `gcmaes192`, `gcmaes256`, or `none`.

*   `ipsecIntegrity` - The IPSec integrity algorithm. Valid
    options are `gcmaes128`, `gcmaes192`, `gcmaes256`, `md5`, `sha1`, or `sha256`.

*   `pfsGroup` - The DH group used in IKE phase 2 for new child SA.
    Valid options are `ecp256`, `ecp384`, `pfs1`, `pfs2`, `pfs2048`, `pfs24`,
    or `none`.

*   `saDatasize` - The IPSec SA payload size in KB. Must be at least
    `1024` KB.

*   `saLifetime` - The IPSec SA lifetime in seconds. Must be at least
    `300` seconds.

The `trafficSelectorPolicy` block supports:

*   `localAddressCidrs` - List of local CIDRs.

*   `remoteAddressCidrs` - List of remote CIDRs.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Virtual Network Gateway Connection.
