---
subcategory: "IoT Hub"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_iothub_dps_shared_access_policy"
description: |-
  Manages an IotHub Device Provisioning Service Shared Access Policy
---

# azurermIothubDpsSharedAccessPolicy

Manages an IotHub Device Provisioning Service Shared Access Policy

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
const azurermIothubDpsExample = new azurerm.iothubDps.IothubDps(
  this,
  "example_1",
  {
    location: azurermResourceGroupExample.location,
    name: "example",
    resource_group_name: azurermResourceGroupExample.name,
    sku: [
      {
        capacity: "1",
        name: "S1",
      },
    ],
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermIothubDpsExample.overrideLogicalId("example");
const azurermIothubDpsSharedAccessPolicyExample =
  new azurerm.iothubDpsSharedAccessPolicy.IothubDpsSharedAccessPolicy(
    this,
    "example_2",
    {
      enrollment_read: true,
      enrollment_write: true,
      iothub_dps_name: azurermIothubDpsExample.name,
      name: "example",
      resource_group_name: azurermResourceGroupExample.name,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermIothubDpsSharedAccessPolicyExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name of the IotHub Shared Access Policy resource. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the resource group under which the IotHub Shared Access Policy resource has to be created. Changing this forces a new resource to be created.

*   `iothubDpsName` - (Required) The name of the IoT Hub Device Provisioning service to which this Shared Access Policy belongs. Changing this forces a new resource to be created.

*   `enrollmentRead` - (Optional) Adds `enrollmentRead` permission to this Shared Access Account. It allows read access to enrollment data.

\-> **NOTE** When `enrollmentRead` is set to `true`, `registrationRead` must also be set to true. This is a limitation of the Azure REST API

* `enrollmentWrite` - (Optional) Adds `enrollmentWrite` permission to this Shared Access Account. It allows write access to enrollment data.

\-> **NOTE** When `registrationWrite` is set to `true`, `enrollmentRead`, `registrationRead`, and `registrationWrite` must also be set to true. This is a requirement of the Azure API.

*   `registrationRead` - (Optional) Adds `registrationStatusRead` permission to this Shared Access Account. It allows read access to device registrations.

*   `registrationWrite` - (Optional) Adds `registrationStatusWrite` permission to this Shared Access Account. It allows write access to device registrations.

\-> **NOTE** When `registrationWrite` is set to `true`, `registrationRead` must also be set to true. This is a requirement of the Azure API.

* `serviceConfig` - (Optional) Adds `serviceConfig` permission to this Shared Access Account. It allows configuration of the Device Provisioning Service.

\-> **NOTE** At least one of `registrationRead`, `registrationWrite`, `serviceConfig`, `enrollmentRead`, `enrollmentWrite` permissions must be set to `true`.

## Attributes Reference

The following attributes are exported:

*   `id` - The ID of the IoTHub Device Provisioning Service Shared Access Policy.

*   `primaryKey` - The primary key used to create the authentication token.

*   `primaryConnectionString` - The primary connection string of the Shared Access Policy.

*   `secondaryKey` - The secondary key used to create the authentication token.

*   `secondaryConnectionString` - The secondary connection string of the Shared Access Policy.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the IotHub Device Provisioning Service Shared Access Policy.
* `update` - (Defaults to 30 minutes) Used when updating the IotHub Device Provisioning Service Shared Access Policy.
* `read` - (Defaults to 5 minutes) Used when retrieving the IotHub Device Provisioning Service Shared Access Policy.
* `delete` - (Defaults to 30 minutes) Used when deleting the IotHub Device Provisioning Service Shared Access Policy.

## Import

IoTHub Device Provisioning Service Shared Access Policies can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_iothub_dps_shared_access_policy.shared_access_policy1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Devices/provisioningServices/dps1/keys/shared_access_policy1
```
