---
subcategory: "Policy"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_subscription_policy_assignment"
description: |-
  Manages a Subscription Policy Assignment.
---

# azurermSubscriptionPolicyAssignment

Manages a Subscription Policy Assignment.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const azurermPolicyDefinitionExample =
  new azurerm.policyDefinition.PolicyDefinition(this, "example", {
    display_name: "Allowed resource types",
    mode: "All",
    name: "only-deploy-in-westeurope",
    policy_rule:
      ' {\n    "if": {\n      "not": {\n        "field": "location",\n        "equals": "westeurope"\n      }\n    },\n    "then": {\n      "effect": "Deny"\n    }\n  }\n',
    policy_type: "Custom",
  });
const dataAzurermSubscriptionCurrent =
  new azurerm.dataAzurermSubscription.DataAzurermSubscription(
    this,
    "current",
    {}
  );
const azurermSubscriptionPolicyAssignmentExample =
  new azurerm.subscriptionPolicyAssignment.SubscriptionPolicyAssignment(
    this,
    "example_2",
    {
      name: "example",
      policy_definition_id: azurermPolicyDefinitionExample.id,
      subscription_id: dataAzurermSubscriptionCurrent.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermSubscriptionPolicyAssignmentExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name which should be used for this Policy Assignment. Changing this forces a new Policy Assignment to be created.

*   `policyDefinitionId` - (Required) The ID of the Policy Definition or Policy Definition Set. Changing this forces a new Policy Assignment to be created.

*   `subscriptionId` - (Required) The ID of the Subscription where this Policy Assignment should be created. Changing this forces a new Policy Assignment to be created.

***

*   `description` - (Optional) A description which should be used for this Policy Assignment.

*   `displayName` - (Optional) The Display Name for this Policy Assignment.

*   `enforce` - (Optional) Specifies if this Policy should be enforced or not? Defaults to `true`.

*   `identity` - (Optional) An `identity` block as defined below.

\-> **Note:** The `location` field must also be specified when `identity` is specified.

*   `location` - (Optional) The Azure Region where the Policy Assignment should exist. Changing this forces a new Policy Assignment to be created.

*   `metadata` - (Optional) A JSON mapping of any Metadata for this Policy.

*   `nonComplianceMessage` - (Optional) One or more `nonComplianceMessage` blocks as defined below.

*   `notScopes` - (Optional) Specifies a list of Resource Scopes (for example a Subscription, or a Resource Group) within this Management Group which are excluded from this Policy.

*   `parameters` - (Optional) A JSON mapping of any Parameters for this Policy.

*   `overrides` - (Optional) One or more `overrides` blocks as defined below. More detail about `overrides` and `resourceSelectors` see [policy assignment structure](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/assignment-structure#resource-selectors-preview)

*   `resourceSelectors` - (Optional) One or more `resourceSelectors` blocks as defined below to filter polices by resource properties.

***

A `identity` block supports the following:

*   `type` - (Required) The Type of Managed Identity which should be added to this Policy Definition. Possible values are `systemAssigned` or `userAssigned`.

*   `identityIds` - (Optional) A list of User Managed Identity IDs which should be assigned to the Policy Definition.

\~> **NOTE:** This is required when `type` is set to `userAssigned`.

***

A `nonComplianceMessage` block supports the following:

*   `content` - (Required) The non-compliance message text. When assigning policy sets (initiatives), unless `policyDefinitionReferenceId` is specified then this message will be the default for all policies.

*   `policyDefinitionReferenceId` - (Optional) When assigning policy sets (initiatives), this is the ID of the policy definition that the non-compliance message applies to.

***

A `overrides` block supports the following:

*   `value` - (Required) Specifies the value to override the policy property. Possible values for `policyEffect` override listed [policy effects](https://learn.microsoft.com/en-us/azure/governance/policy/concepts/effects).

*   `selectors` - (Optional) One or more `overrideSelector` as defined below.

***

A `overrideSelector` block supports the following:

*   `in` - (Optional) Specify the list of policy reference id values to filter in. Cannot be used with `notIn`.

*   `notIn` - (Optional) Specify the list of policy reference id values to filter out. Cannot be used with `in`.

***

A `resourceSelectors` block supports the following:

*   `name` - (Optional) Specifies a name for the resource selector.

*   `selectors` - (Required) One or more `resourceSelector` block as defined below.

***

A `resourceSelector` block supports the following:

*   `kind` - (Required) Specifies which characteristic will narrow down the set of evaluated resources. Possible values are `resourceLocation`,  `resourceType` and `resourceWithoutLocation`.

*   `in` - (Optional) The list of allowed values for the specified kind. Cannot be used with `notIn`. Can contain up to 50 values.

*   `notIn` - (Optional) The list of not-allowed values for the specified kind. Cannot be used with `in`. Can contain up to 50 values.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the Subscription Policy Assignment.

***

The `identity` block exports the following:

*   `principalId` - The Principal ID of the Policy Assignment for this Subscription.

*   `tenantId` - The Tenant ID of the Policy Assignment for this Subscription.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Policy Assignment for this Subscription.
* `read` - (Defaults to 5 minutes) Used when retrieving the Policy Assignment for this Subscription.
* `update` - (Defaults to 30 minutes) Used when updating the Policy Assignment for this Subscription.
* `delete` - (Defaults to 30 minutes) Used when deleting the Policy Assignment for this Subscription.

## Import

Subscription Policy Assignments can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_subscription_policy_assignment.example /subscriptions/00000000-0000-0000-000000000000/providers/Microsoft.Authorization/policyAssignments/assignment1
```
