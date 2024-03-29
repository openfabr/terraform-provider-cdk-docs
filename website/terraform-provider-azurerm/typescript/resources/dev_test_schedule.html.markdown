---
subcategory: "Dev Test"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_dev_test_schedule"
description: |-
    Manages automated startup and shutdown schedules for Azure Dev Test Lab.
---

# azurermDevTestSchedule

Manages automated startup and shutdown schedules for Azure Dev Test Lab.

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
const azurermDevTestLabExample = new azurerm.devTestLab.DevTestLab(
  this,
  "example_1",
  {
    location: azurermResourceGroupExample.location,
    name: "YourDevTestLab",
    resource_group_name: azurermResourceGroupExample.name,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDevTestLabExample.overrideLogicalId("example");
const azurermDevTestScheduleExample =
  new azurerm.devTestSchedule.DevTestSchedule(this, "example_2", {
    lab_name: azurermDevTestLabExample.name,
    location: azurermResourceGroupExample.location,
    name: "LabVmAutoStart",
    notification_settings: [{}],
    resource_group_name: azurermResourceGroupExample.name,
    tags: {
      environment: "Production",
    },
    task_type: "LabVmsStartupTask",
    time_zone_id: "Pacific Standard Time",
    weekly_recurrence: [
      {
        time: "1100",
        week_days: ["Monday", "Tuesday"],
      },
    ],
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDevTestScheduleExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) The name of the dev test lab schedule. Valid value for name depends on the `taskType`. For instance for task\_type `labVmsStartupTask` the name needs to be `labVmAutoStart`. Changing this forces a new resource to be created.

*   `location` - (Required) The location where the schedule is created. Changing this forces a new resource to be created.

*   `resourceGroupName` - (Required) The name of the resource group in which to create the dev test lab schedule. Changing this forces a new resource to be created.

*   `labName` - (Required) The name of the dev test lab. Changing this forces a new resource to be created.

*   `status` - (Optional) The status of this schedule. Possible values are `enabled` and `disabled`. Defaults to `disabled`.

*   `taskType` - (Required) The task type of the schedule. Possible values include `labVmsShutdownTask` and `labVmAutoStart`.

*   `timeZoneId` - (Required) The time zone ID (e.g. Pacific Standard time).

*   `tags` - (Optional) A mapping of tags to assign to the resource.

*   `notificationSettings` - (Required) The notification setting of a schedule. A `notificationSettings` as defined below.

*   `weeklyRecurrence` - (Optional) The properties of a weekly schedule. If the schedule occurs only some days of the week, specify the weekly recurrence. A `weeklyRecurrence` block as defined below.

*   `dailyRecurrence` - (Optional) The properties of a daily schedule. If the schedule occurs once each day of the week, specify the daily recurrence. A `dailyRecurrence` block as defined below.

*   `hourlyRecurrence` - (Optional) The properties of an hourly schedule. If the schedule occurs multiple times a day, specify the hourly recurrence. A `hourlyRecurrence` block as defined below.

***

A `weeklyRecurrence` block supports the following:

*   `time` - (Required) The time when the schedule takes effect.

*   `weekDays` - (Optional) A list of days that this schedule takes effect . Possible values include `monday`, `tuesday`, `wednesday`, `thursday`, `friday`, `saturday` and `sunday`.

***

A `dailyRecurrence` block supports the following:

* `time` - (Required) The time each day when the schedule takes effect.

***

A `hourlyRecurrence` block supports the following:

* `minute` - (Required) Minutes of the hour the schedule will run.

***

A `notificationSettings` block supports the following:

*   `status` - (Optional) The status of the notification. Possible values are `enabled` and `disabled`. Defaults to `disabled`

*   `timeInMinutes` - (Optional) Time in minutes before event at which notification will be sent.

*   `webhookUrl` - (Optional) The webhook URL to which the notification will be sent.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the DevTest Schedule.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the DevTest Schedule.
* `update` - (Defaults to 30 minutes) Used when updating the DevTest Schedule.
* `read` - (Defaults to 5 minutes) Used when retrieving the DevTest Schedule.
* `delete` - (Defaults to 30 minutes) Used when deleting the DevTest Schedule.

## Import

DevTest Schedule's can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_dev_test_schedule.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.DevTestLab/labs/myDevTestLab/schedules/labvmautostart
```
