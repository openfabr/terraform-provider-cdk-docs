---
subcategory: "Databricks"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_databricks_workspace_customer_managed_key"
description: |-
  Manages a Customer Managed Key for a Databricks Workspace
---

# azurermDatabricksWorkspaceCustomerManagedKey

Manages a Customer Managed Key for a Databricks Workspace

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
const dataAzurermClientConfigCurrent =
  new azurerm.dataAzurermClientConfig.DataAzurermClientConfig(
    this,
    "current",
    {}
  );
const azurermDatabricksWorkspaceExample =
  new azurerm.databricksWorkspace.DatabricksWorkspace(this, "example_2", {
    customer_managed_key_enabled: true,
    location: azurermResourceGroupExample.location,
    name: "databricks-test",
    resource_group_name: azurermResourceGroupExample.name,
    sku: "premium",
    tags: {
      Environment: "Production",
    },
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDatabricksWorkspaceExample.overrideLogicalId("example");
const azurermKeyVaultExample = new azurerm.keyVault.KeyVault(
  this,
  "example_3",
  {
    location: azurermResourceGroupExample.location,
    name: "examplekeyvault",
    purge_protection_enabled: true,
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "premium",
    tenant_id: dataAzurermClientConfigCurrent.tenantId,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermKeyVaultExample.overrideLogicalId("example");
const azurermKeyVaultAccessPolicyDatabricks =
  new azurerm.keyVaultAccessPolicy.KeyVaultAccessPolicy(this, "databricks", {
    depends_on: [`\${${azurermDatabricksWorkspaceExample.fqn}}`],
    key_permissions: [
      "Create",
      "Delete",
      "Get",
      "Purge",
      "Recover",
      "Update",
      "List",
      "Decrypt",
      "Sign",
    ],
    key_vault_id: azurermKeyVaultExample.id,
    object_id: `\${${azurermDatabricksWorkspaceExample.storageAccountIdentity}.0.principal_id}`,
    tenant_id: `\${${azurermDatabricksWorkspaceExample.storageAccountIdentity}.0.tenant_id}`,
  });
const azurermKeyVaultAccessPolicyTerraform =
  new azurerm.keyVaultAccessPolicy.KeyVaultAccessPolicy(this, "terraform", {
    key_permissions: [
      "Create",
      "Delete",
      "Get",
      "Purge",
      "Recover",
      "Update",
      "List",
      "Decrypt",
      "Sign",
      "GetRotationPolicy",
    ],
    key_vault_id: azurermKeyVaultExample.id,
    object_id: dataAzurermClientConfigCurrent.objectId,
    tenant_id: azurermKeyVaultExample.tenantId,
  });
const azurermKeyVaultKeyExample = new azurerm.keyVaultKey.KeyVaultKey(
  this,
  "example_6",
  {
    depends_on: [`\${${azurermKeyVaultAccessPolicyTerraform.fqn}}`],
    key_opts: ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"],
    key_size: 2048,
    key_type: "RSA",
    key_vault_id: azurermKeyVaultExample.id,
    name: "example-certificate",
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermKeyVaultKeyExample.overrideLogicalId("example");
const azurermDatabricksWorkspaceCustomerManagedKeyExample =
  new azurerm.databricksWorkspaceCustomerManagedKey.DatabricksWorkspaceCustomerManagedKey(
    this,
    "example_7",
    {
      depends_on: [`\${${azurermKeyVaultAccessPolicyDatabricks.fqn}}`],
      key_vault_key_id: azurermKeyVaultKeyExample.id,
      workspace_id: azurermDatabricksWorkspaceExample.id,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermDatabricksWorkspaceCustomerManagedKeyExample.overrideLogicalId(
  "example"
);

```

## Example HCL Configurations

* [Databricks Workspace with Databricks File System Customer Managed Keys](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/databricks/customer-managed-key/dbfs)
* [Databricks Workspace with Customer Managed Keys for Managed Services](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/databricks/customer-managed-key/managed-services)
* [Databricks Workspace with Private Endpoint, Customer Managed Keys for Managed Services and Databricks File System Customer Managed Keys](https://github.com/hashicorp/terraform-provider-azurerm/tree/main/examples/private-endpoint/databricks/managed-services)

## Argument Reference

The following arguments are supported:

*   `workspaceId` - (Required) The ID of the Databricks Workspace..

*   `keyVaultKeyId` - (Required) The ID of the Key Vault.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the Databricks Workspace.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Customer Managed Key for this Databricks Workspace.
* `update` - (Defaults to 30 minutes) Used when updating the Customer Managed Key for this Databricks Workspace.
* `read` - (Defaults to 5 minutes) Used when retrieving the Customer Managed Key for this Databricks Workspace.
* `delete` - (Defaults to 30 minutes) Used when deleting the Customer Managed Key for this Databricks Workspace.

## Import

Databricks Workspace Customer Managed Key can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_databricks_workspace_customer_managed_key.workspace1 /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/group1/providers/Microsoft.Databricks/workspaces/workspace1
```
