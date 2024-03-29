---
subcategory: "Billing"
layout: "azurerm"
page_title: "Azure Resource Manager: Data Source: azurerm_billing_enrollment_account_scope"
description: |-
  This is a helper Data Source to provide a correctly formatted Billing Scope ID for an Enterprise Account Enrollment.
---

# Data Source: azurermBillingEnrollmentAccountScope

Use this data source to access information about an existing Enrollment Account Billing Scope.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermBillingEnrollmentAccountScopeExample =
  new azurerm.dataAzurermBillingEnrollmentAccountScope.DataAzurermBillingEnrollmentAccountScope(
    this,
    "example",
    {
      billing_account_name: "existing",
      enrollment_account_name: "existing",
    }
  );
new cdktf.TerraformOutput(this, "id", {
  value: dataAzurermBillingEnrollmentAccountScopeExample.id,
});

```

## Arguments Reference

The following arguments are supported:

*   `billingAccountName` - (Required) The Billing Account Name of the Enterprise Account.

*   `enrollmentAccountName` - (Required) The Enrollment Account Name in the above Enterprise Account.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the Enrollment Account Billing Scope.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Enrollment Account Billing Scope.
