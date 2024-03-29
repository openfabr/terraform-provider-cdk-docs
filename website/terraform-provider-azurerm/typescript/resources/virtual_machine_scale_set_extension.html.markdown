---
layout: "azurerm"
subcategory: "Compute"
page_title: "Azure Resource Manager: azurerm_virtual_machine_scale_set_extension"
description: |-
  Manages an Extension for a Virtual Machine Scale Set.
---

# azurermVirtualMachineScaleSetExtension

Manages an Extension for a Virtual Machine Scale Set.

\~> **NOTE:** This resource is not intended to be used with the `azurermVirtualMachineScaleSet` resource - instead it's intended for this to be used with the `azurermLinuxVirtualMachineScaleSet` and `azurermWindowsVirtualMachineScaleSet` resources.

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
    name: "example",
  }
);
const azurermLinuxVirtualMachineScaleSetExample =
  new azurerm.linuxVirtualMachineScaleSet.LinuxVirtualMachineScaleSet(
    this,
    "example_1",
    {
      admin_username: "adminuser",
      instances: 1,
      location: azurermResourceGroupExample.location,
      name: "example",
      network_interface: [
        {
          ip_configuration: [
            {
              name: "internal",
            },
          ],
          name: "example",
        },
      ],
      os_disk: [
        {
          caching: "ReadWrite",
          storage_account_type: "Standard_LRS",
        },
      ],
      resource_group_name: azurermResourceGroupExample.name,
      sku: "Standard_F2",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLinuxVirtualMachineScaleSetExample.overrideLogicalId("example");
const azurermVirtualMachineScaleSetExtensionExample =
  new azurerm.virtualMachineScaleSetExtension.VirtualMachineScaleSetExtension(
    this,
    "example_2",
    {
      name: "example",
      publisher: "Microsoft.Azure.Extensions",
      settings:
        '${jsonencode({\n    "commandToExecute" = "echo $HOSTNAME"\n  })}',
      type: "CustomScript",
      type_handler_version: "2.0",
      virtual_machine_scale_set_id:
        azurermLinuxVirtualMachineScaleSetExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualMachineScaleSetExtensionExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name for the Virtual Machine Scale Set Extension. Changing this forces a new resource to be created.

*   `virtualMachineScaleSetId` - (Required) The ID of the Virtual Machine Scale Set. Changing this forces a new resource to be created.

\-> **NOTE:** This should be the ID from the `azurermLinuxVirtualMachineScaleSet` or `azurermWindowsVirtualMachineScaleSet` resource - when using the older `azurermVirtualMachineScaleSet` resource extensions should instead be defined inline.

*   `publisher` - (Required) Specifies the Publisher of the Extension. Changing this forces a new resource to be created.

*   `type` - (Required) Specifies the Type of the Extension. Changing this forces a new resource to be created.

*   `typeHandlerVersion` - (Required) Specifies the version of the extension to use, available versions can be found using the Azure CLI.

\~> **Note:** The `publisher` and `type` of Virtual Machine Scale Set Extensions can be found using the Azure CLI, via:

```console
az vmss extension image list --location westus -o table
```

***

*   `autoUpgradeMinorVersion` - (Optional) Should the latest version of the Extension be used at Deployment Time, if one is available? This won't auto-update the extension on existing installation. Defaults to `true`.

*   `automaticUpgradeEnabled` - (Optional) Should the Extension be automatically updated whenever the Publisher releases a new version of this VM Extension?

*   `failureSuppressionEnabled` - (Optional) Should failures from the extension be suppressed? Possible values are `true` or `false`. Defaults to `false`.

\-> **NOTE:** Operational failures such as not connecting to the VM will not be suppressed regardless of the `failureSuppressionEnabled` value.

*   `forceUpdateTag` - (Optional) A value which, when different to the previous value can be used to force-run the Extension even if the Extension Configuration hasn't changed.

*   `protectedSettings` - (Optional) A JSON String which specifies Sensitive Settings (such as Passwords) for the Extension.

\~> **NOTE:** Keys within the `protectedSettings` block are notoriously case-sensitive, where the casing required (e.g. TitleCase vs snakeCase) depends on the Extension being used. Please refer to the documentation for the specific Virtual Machine Extension you're looking to use for more information.

* `protectedSettingsFromKeyVault` - (Optional) A `protectedSettingsFromKeyVault` block as defined below.

\~> **Note:** `protectedSettingsFromKeyVault` cannot be used with `protectedSettings`

*   `provisionAfterExtensions` - (Optional) An ordered list of Extension names which this should be provisioned after.

*   `settings` - (Optional) A JSON String which specifies Settings for the Extension.

\~> **NOTE:** Keys within the `settings` block are notoriously case-sensitive, where the casing required (e.g. TitleCase vs snakeCase) depends on the Extension being used. Please refer to the documentation for the specific Virtual Machine Extension you're looking to use for more information.

***

A `protectedSettingsFromKeyVault` block supports the following:

*   `secretUrl` - (Required) The URL to the Key Vault Secret which stores the protected settings.

*   `sourceVaultId` - (Required) The ID of the source Key Vault.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the Virtual Machine Scale Set Extension.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Virtual Machine Scale Set Extension.
* `update` - (Defaults to 30 minutes) Used when updating the Virtual Machine Scale Set Extension.
* `read` - (Defaults to 5 minutes) Used when retrieving the Virtual Machine Scale Set Extension.
* `delete` - (Defaults to 30 minutes) Used when deleting the Virtual Machine Scale Set Extension.

## Import

Virtual Machine Scale Set Extensions can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_virtual_machine_scale_set_extension.test /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Compute/virtualMachineScaleSets/scaleSet1/extensions/extension1
```
