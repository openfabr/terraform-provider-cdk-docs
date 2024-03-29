---
subcategory: "Maintenance"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_maintenance_assignment_virtual_machine_scale_set"
description: |-
  Manages a Maintenance Assignment.
---

# azurermMaintenanceAssignmentVirtualMachineScaleSet

Manages a maintenance assignment to a virtual machine scale set.

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
const azurermVirtualNetworkExample = new azurerm.virtualNetwork.VirtualNetwork(
  this,
  "example_2",
  {
    address_space: ["10.0.0.0/16"],
    location: azurermResourceGroupExample.location,
    name: "example-network",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermVirtualNetworkExample.overrideLogicalId("example");
const azurermMaintenanceConfigurationExample =
  new azurerm.maintenanceConfiguration.MaintenanceConfiguration(
    this,
    "example_3",
    {
      location: azurermResourceGroupExample.location,
      name: "example",
      resource_group_name: azurermResourceGroupExample.name,
      scope: "OSImage",
      visibility: "Custom",
      window: [
        {
          duration: "06:00",
          expiration_date_time: "9999-12-31 00:00",
          recur_every: "1Days",
          start_date_time: "2021-12-31 00:00",
          time_zone: "Pacific Standard Time",
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermMaintenanceConfigurationExample.overrideLogicalId("example");
const azurermNetworkInterfaceExample =
  new azurerm.networkInterface.NetworkInterface(this, "example_4", {
    ip_configuration: [
      {
        name: "testconfiguration1",
        private_ip_address_allocation: "Dynamic",
      },
    ],
    location: azurermResourceGroupExample.location,
    name: "sample-nic",
    resource_group_name: azurermResourceGroupExample.name,
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermNetworkInterfaceExample.overrideLogicalId("example");
const azurermPublicIpExample = new azurerm.publicIp.PublicIp(
  this,
  "example_5",
  {
    allocation_method: "Static",
    location: azurermResourceGroupExample.location,
    name: azurermResourceGroupExample.name,
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermPublicIpExample.overrideLogicalId("example");
const azurermSubnetExample = new azurerm.subnet.Subnet(this, "example_6", {
  address_prefixes: ["10.0.2.0/24"],
  name: "internal",
  resource_group_name: azurermResourceGroupExample.name,
  virtual_network_name: azurermVirtualNetworkExample.name,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubnetExample.overrideLogicalId("example");
const azurermLbExample = new azurerm.lb.Lb(this, "example_7", {
  frontend_ip_configuration: [
    {
      name: "internal",
      public_ip_address_id: azurermPublicIpExample.id,
    },
  ],
  location: azurermResourceGroupExample.location,
  name: azurermResourceGroupExample.name,
  resource_group_name: azurermResourceGroupExample.name,
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLbExample.overrideLogicalId("example");
const azurermLbBackendAddressPoolExample =
  new azurerm.lbBackendAddressPool.LbBackendAddressPool(this, "example_8", {
    loadbalancer_id: azurermLbExample.id,
    name: "example",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLbBackendAddressPoolExample.overrideLogicalId("example");
const azurermLbProbeExample = new azurerm.lbProbe.LbProbe(this, "example_9", {
  loadbalancer_id: azurermLbExample.id,
  name: "example",
  port: 22,
  protocol: "Tcp",
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLbProbeExample.overrideLogicalId("example");
const azurermLbRuleExample = new azurerm.lbRule.LbRule(this, "example_10", {
  backend_port: 22,
  frontend_ip_configuration_name: "internal",
  frontend_port: 22,
  loadbalancer_id: azurermLbExample.id,
  name: "example",
  probe_id: azurermLbProbeExample.id,
  protocol: "Tcp",
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLbRuleExample.overrideLogicalId("example");
const azurermLinuxVirtualMachineExample =
  new azurerm.linuxVirtualMachine.LinuxVirtualMachine(this, "example_11", {
    admin_username: "adminuser",
    location: azurermResourceGroupExample.location,
    name: "example-machine",
    network_interface_ids: [azurermNetworkInterfaceExample.id],
    os_disk: [
      {
        caching: "ReadWrite",
        storage_account_type: "Standard_LRS",
      },
    ],
    resource_group_name: azurermResourceGroupExample.name,
    size: "Standard_F2",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLinuxVirtualMachineExample.overrideLogicalId("example");
const azurermLinuxVirtualMachineScaleSetExample =
  new azurerm.linuxVirtualMachineScaleSet.LinuxVirtualMachineScaleSet(
    this,
    "example_12",
    {
      admin_password: "P@ssword1234!",
      admin_username: "adminuser",
      automatic_os_upgrade_policy: [
        {
          disable_automatic_rollback: true,
          enable_automatic_os_upgrade: true,
        },
      ],
      depends_on: ["azurerm_lb_rule.example"],
      disable_password_authentication: false,
      health_probe_id: azurermLbProbeExample.id,
      instances: 1,
      location: azurermResourceGroupExample.location,
      name: "example",
      network_interface: [
        {
          ip_configuration: [
            {
              load_balancer_backend_address_pool_ids: [
                azurermLbBackendAddressPoolExample.id,
              ],
              name: "internal",
              primary: true,
              subnet_id: azurermSubnetExample.id,
            },
          ],
          name: "example",
          primary: true,
        },
      ],
      os_disk: [
        {
          caching: "ReadWrite",
          storage_account_type: "Standard_LRS",
        },
      ],
      resource_group_name: azurermResourceGroupExample.name,
      rolling_upgrade_policy: [
        {
          max_batch_instance_percent: 20,
          max_unhealthy_instance_percent: 20,
          max_unhealthy_upgraded_instance_percent: 20,
          pause_time_between_batches: "PT0S",
        },
      ],
      sku: "Standard_F2",
      source_image_reference: [
        {
          offer: "UbuntuServer",
          publisher: "Canonical",
          sku: "16.04-LTS",
          version: "latest",
        },
      ],
      upgrade_mode: "Automatic",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermLinuxVirtualMachineScaleSetExample.overrideLogicalId("example");
const azurermMaintenanceAssignmentVirtualMachineScaleSetExample =
  new azurerm.maintenanceAssignmentVirtualMachineScaleSet.MaintenanceAssignmentVirtualMachineScaleSet(
    this,
    "example_13",
    {
      location: azurermResourceGroupExample.location,
      maintenance_configuration_id: azurermMaintenanceConfigurationExample.id,
      virtual_machine_scale_set_id: azurermLinuxVirtualMachineExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermMaintenanceAssignmentVirtualMachineScaleSetExample.overrideLogicalId(
  "example"
);

```

## Argument Reference

The following arguments are supported:

*   `location` - (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created.

*   `maintenanceConfigurationId` - (Required) Specifies the ID of the Maintenance Configuration Resource. Changing this forces a new resource to be created.

*   `virtualMachineScaleSetId` - (Required) Specifies the Virtual Machine Scale Set ID to which the Maintenance Configuration will be assigned. Changing this forces a new resource to be created.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the Maintenance Assignment.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Maintenance Assignment.
* `read` - (Defaults to 5 minutes) Used when retrieving the Maintenance Assignment.
* `delete` - (Defaults to 30 minutes) Used when deleting the Maintenance Assignment.

## Import

Maintenance Assignment can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_maintenance_assignment_virtual_machine_scale_set.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resGroup1/providers/Microsoft.Compute/virtualMachineScaleSets/vmss1/providers/Microsoft.Maintenance/configurationAssignments/assign1
```
