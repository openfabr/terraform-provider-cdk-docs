---
subcategory: "Security Center"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_security_center_setting"
description: |-
    Manages the Data Access Settings for Azure Security Center.
---

# azurermSecurityCenterSetting

Manages the Data Access Settings for Azure Security Center.

\~> **NOTE:** This resource requires the `owner` permission on the Subscription.

\~> **NOTE:** Deletion of this resource disables the setting.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
new azurerm.securityCenterSetting.SecurityCenterSetting(this, "example", {
  enabled: true,
  setting_name: "MCAS",
});

```

## Argument Reference

The following arguments are supported:

* `settingName` - (Required) The setting to manage. Possible values are `mcas` , `wdatp` and `sentinel`. Changing this forces a new resource to be created.
* `enabled` - (Required) Boolean flag to enable/disable data access.

## Attributes Reference

The following attributes are exported:

* `id` - The subscription security center setting id.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 10 minutes) Used when creating the Security Center Setting.
* `update` - (Defaults to 10 minutes) Used when updating the Security Center Setting.
* `read` - (Defaults to 5 minutes) Used when retrieving the Security Center Setting.
* `delete` - (Defaults to 10 minutes) Used when deleting the Security Center Setting.

## Import

The setting can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_security_center_setting.example /subscriptions/00000000-0000-0000-0000-000000000000/providers/Microsoft.Security/settings/<setting_name>
```
