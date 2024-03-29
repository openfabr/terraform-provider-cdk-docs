---
subcategory: "Authorization"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_role_assignment"
description: |-
  Assigns a given Principal (User or Group) to a given Role.

---

# azurermRoleAssignment

Assigns a given Principal (User or Group) to a given Role.

## Example Usage (using a built-in Role)

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermClientConfigExample =
  new azurerm.dataAzurermClientConfig.DataAzurermClientConfig(
    this,
    "example",
    {}
  );
const dataAzurermSubscriptionPrimary =
  new azurerm.dataAzurermSubscription.DataAzurermSubscription(
    this,
    "primary",
    {}
  );
const azurermRoleAssignmentExample = new azurerm.roleAssignment.RoleAssignment(
  this,
  "example_2",
  {
    principal_id: dataAzurermClientConfigExample.objectId,
    role_definition_name: "Reader",
    scope: dataAzurermSubscriptionPrimary.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRoleAssignmentExample.overrideLogicalId("example");

```

## Example Usage (Custom Role & Service Principal)

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermClientConfigExample =
  new azurerm.dataAzurermClientConfig.DataAzurermClientConfig(
    this,
    "example",
    {}
  );
const dataAzurermSubscriptionPrimary =
  new azurerm.dataAzurermSubscription.DataAzurermSubscription(
    this,
    "primary",
    {}
  );
const azurermRoleDefinitionExample = new azurerm.roleDefinition.RoleDefinition(
  this,
  "example_2",
  {
    assignable_scopes: [dataAzurermSubscriptionPrimary.id],
    name: "my-custom-role-definition",
    permissions: [
      {
        actions: ["Microsoft.Resources/subscriptions/resourceGroups/read"],
        not_actions: [],
      },
    ],
    role_definition_id: "00000000-0000-0000-0000-000000000000",
    scope: dataAzurermSubscriptionPrimary.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRoleDefinitionExample.overrideLogicalId("example");
const azurermRoleAssignmentExample = new azurerm.roleAssignment.RoleAssignment(
  this,
  "example_3",
  {
    name: "00000000-0000-0000-0000-000000000000",
    principal_id: dataAzurermClientConfigExample.objectId,
    role_definition_id: azurermRoleDefinitionExample.roleDefinitionResourceId,
    scope: dataAzurermSubscriptionPrimary.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRoleAssignmentExample.overrideLogicalId("example");

```

## Example Usage (Custom Role & User)

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermClientConfigExample =
  new azurerm.dataAzurermClientConfig.DataAzurermClientConfig(
    this,
    "example",
    {}
  );
const dataAzurermSubscriptionPrimary =
  new azurerm.dataAzurermSubscription.DataAzurermSubscription(
    this,
    "primary",
    {}
  );
const azurermRoleDefinitionExample = new azurerm.roleDefinition.RoleDefinition(
  this,
  "example_2",
  {
    assignable_scopes: [dataAzurermSubscriptionPrimary.id],
    name: "my-custom-role-definition",
    permissions: [
      {
        actions: ["Microsoft.Resources/subscriptions/resourceGroups/read"],
        not_actions: [],
      },
    ],
    role_definition_id: "00000000-0000-0000-0000-000000000000",
    scope: dataAzurermSubscriptionPrimary.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRoleDefinitionExample.overrideLogicalId("example");
const azurermRoleAssignmentExample = new azurerm.roleAssignment.RoleAssignment(
  this,
  "example_3",
  {
    name: "00000000-0000-0000-0000-000000000000",
    principal_id: dataAzurermClientConfigExample.objectId,
    role_definition_id: azurermRoleDefinitionExample.roleDefinitionResourceId,
    scope: dataAzurermSubscriptionPrimary.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRoleAssignmentExample.overrideLogicalId("example");

```

## Example Usage (Custom Role & Management Group)

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermClientConfigExample =
  new azurerm.dataAzurermClientConfig.DataAzurermClientConfig(
    this,
    "example",
    {}
  );
const dataAzurermManagementGroupExample =
  new azurerm.dataAzurermManagementGroup.DataAzurermManagementGroup(
    this,
    "example_1",
    {
      name: "00000000-0000-0000-0000-000000000000",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAzurermManagementGroupExample.overrideLogicalId("example");
const dataAzurermSubscriptionPrimary =
  new azurerm.dataAzurermSubscription.DataAzurermSubscription(
    this,
    "primary",
    {}
  );
const azurermRoleDefinitionExample = new azurerm.roleDefinition.RoleDefinition(
  this,
  "example_3",
  {
    assignable_scopes: [dataAzurermSubscriptionPrimary.id],
    name: "my-custom-role-definition",
    permissions: [
      {
        actions: ["Microsoft.Resources/subscriptions/resourceGroups/read"],
        not_actions: [],
      },
    ],
    role_definition_id: "00000000-0000-0000-0000-000000000000",
    scope: dataAzurermSubscriptionPrimary.id,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRoleDefinitionExample.overrideLogicalId("example");
const azurermRoleAssignmentExample = new azurerm.roleAssignment.RoleAssignment(
  this,
  "example_4",
  {
    name: "00000000-0000-0000-0000-000000000000",
    principal_id: dataAzurermClientConfigExample.objectId,
    role_definition_id: azurermRoleDefinitionExample.roleDefinitionResourceId,
    scope: "${data.azurerm_management_group.primary.id}",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermRoleAssignmentExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `name` - (Optional) A unique UUID/GUID for this Role Assignment - one will be generated if not specified. Changing this forces a new resource to be created.

*   `scope` - (Required) The scope at which the Role Assignment applies to, such as `/subscriptions/0B1F64711Bf04DdaAec3111122223333`, `/subscriptions/0B1F64711Bf04DdaAec3111122223333/resourceGroups/myGroup`, or `/subscriptions/0B1F64711Bf04DdaAec3111122223333/resourceGroups/myGroup/providers/microsoftCompute/virtualMachines/myVm`, or `/providers/microsoftManagement/managementGroups/myMg`. Changing this forces a new resource to be created.

*   `roleDefinitionId` - (Optional) The Scoped-ID of the Role Definition. Changing this forces a new resource to be created. Conflicts with `roleDefinitionName`.

*   `roleDefinitionName` - (Optional) The name of a built-in Role. Changing this forces a new resource to be created. Conflicts with `roleDefinitionId`.

*   `principalId` - (Required) The ID of the Principal (User, Group or Service Principal) to assign the Role Definition to. Changing this forces a new resource to be created.

\~> **NOTE:** The Principal ID is also known as the Object ID (ie not the "Application ID" for applications).

*   `condition` - (Optional) The condition that limits the resources that the role can be assigned to. Changing this forces a new resource to be created.

*   `conditionVersion` - (Optional) The version of the condition. Possible values are `10` or `20`. Changing this forces a new resource to be created.

*   `delegatedManagedIdentityResourceId` - (Optional) The delegated Azure Resource Id which contains a Managed Identity. Changing this forces a new resource to be created.

\~> **NOTE:** this field is only used in cross tenant scenario.

*   `description` - (Optional) The description for this Role Assignment. Changing this forces a new resource to be created.

*   `skipServicePrincipalAadCheck` - (Optional) If the `principalId` is a newly provisioned `servicePrincipal` set this value to `true` to skip the `azureActiveDirectory` check which may fail due to replication lag. This argument is only valid if the `principalId` is a `servicePrincipal` identity. Defaults to `false`.

\~> **NOTE:** If it is not a `servicePrincipal` identity it will cause the role assignment to fail.

## Attributes Reference

The following attributes are exported:

*   `id` - The Role Assignment ID.

*   `principalType` - The type of the `principalId`, e.g. User, Group, Service Principal, Application, etc.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Role Assignment.
* `update` - (Defaults to 30 minutes) Used when updating the Role Assignment.
* `read` - (Defaults to 5 minutes) Used when retrieving the Role Assignment.
* `delete` - (Defaults to 30 minutes) Used when deleting the Role Assignment.

## Import

Role Assignments can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_role_assignment.example /subscriptions/00000000-0000-0000-0000-000000000000/providers/Microsoft.Authorization/roleAssignments/00000000-0000-0000-0000-000000000000
```

\~> **NOTE:** The format of `resourceId` could be different for different kinds of `scope`:

* for scope `subscription`, the id format is `/subscriptions/00000000000000000000000000000000/providers/microsoftAuthorization/roleAssignments/00000000000000000000000000000000`
* for scope `resourceGroup`, the id format is `/subscriptions/00000000000000000000000000000000/resourceGroups/group1/providers/microsoftAuthorization/roleAssignments/00000000000000000000000000000000`

\~> **NOTE:** for cross tenant scenario, the format of `resourceId` is composed of Azure resource ID and tenantId. for example:

```text
/subscriptions/00000000-0000-0000-0000-000000000000/providers/Microsoft.Authorization/roleAssignments/00000000-0000-0000-0000-000000000000|00000000-0000-0000-0000-000000000000
```
