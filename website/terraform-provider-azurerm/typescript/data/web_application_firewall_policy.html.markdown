---
subcategory: "Network"
layout: "azurerm"
page_title: "Azure Resource Manager: Data Source: azurerm_web_application_firewall_policy"
description: |-
  Gets information about an existing Web Application Firewall Policy.
---

# Data Source: azurermWebApplicationFirewallPolicy

Use this data source to access information about an existing Web Application Firewall Policy.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermWebApplicationFirewallPolicyExample =
  new azurerm.dataAzurermWebApplicationFirewallPolicy.DataAzurermWebApplicationFirewallPolicy(
    this,
    "example",
    {
      name: "existing",
      resource_group_name: "existing",
    }
  );
new cdktf.TerraformOutput(this, "id", {
  value: dataAzurermWebApplicationFirewallPolicyExample.id,
});

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name of the Web Application Firewall Policy

*   `resourceGroupName` - (Required) The name of the Resource Group where the Web Application Firewall Policy exists.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the Web Application Firewall Policy.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Web Application Firewall Policy.
