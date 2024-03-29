---
subcategory: "Policy"
layout: "azurerm"
page_title: "Azure Resource Manager: Data Source: azurerm_policy_assignment"
description: |-
  Gets information about an existing Policy Assignment.
---

# Data Source: azurermPolicyAssignment

Use this data source to access information about an existing Policy Assignment.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermPolicyAssignmentExample =
  new azurerm.dataAzurermPolicyAssignment.DataAzurermPolicyAssignment(
    this,
    "example",
    {
      name: "existing",
      scope_id: "${data.azurerm_resource_group.example.id}",
    }
  );
new cdktf.TerraformOutput(this, "id", {
  value: dataAzurermPolicyAssignmentExample.id,
});

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name of this Policy Assignment. Changing this forces a new Policy Assignment to be created.

*   `scopeId` - (Required) The ID of the scope this Policy Assignment is assigned to. The `scopeId` can be a subscription id, a resource group id, a management group id, or an ID of any resource that is assigned with a policy. Changing this forces a new Policy Assignment to be created.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Policy Assignment.

*   `description` - The description of this Policy Assignment.

*   `displayName` - The display name of this Policy Assignment.

*   `enforce` - Whether this Policy is enforced or not?

*   `identity` - A `identity` block as defined below.

*   `location` - The Azure Region where the Policy Assignment exists.

*   `metadata` - A JSON mapping of any Metadata for this Policy.

*   `nonComplianceMessage` - A `nonComplianceMessage` block as defined below.

*   `notScopes` - A `notScopes` block as defined below.

*   `parameters` - A JSON mapping of any Parameters for this Policy.

*   `policyDefinitionId` - The ID of the assigned Policy Definition.

***

A `identity` block exports the following:

*   `identityIds` - A `identityIds` block as defined below.

*   `principalId` - The Principal ID of the Policy Assignment for this Resource.

*   `tenantId` - The Tenant ID of the Policy Assignment for this Resource.

*   `type` - The Type of Managed Identity which is added to this Policy Assignment.

***

A `nonComplianceMessage` block exports the following:

*   `content` - The non-compliance message text.

*   `policyDefinitionReferenceId` - The ID of the Policy Definition that the non-compliance message applies to.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Policy Assignment.
