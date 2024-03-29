---
subcategory: "Cognitive Services"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_cognitive_deployment"
description: |-
  Manages a Cognitive Services Account Deployment.
---

# azurermCognitiveDeployment

Manages a Cognitive Services Account Deployment.

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
const azurermCognitiveAccountExample =
  new azurerm.cognitiveAccount.CognitiveAccount(this, "example_1", {
    kind: "OpenAI",
    location: azurermResourceGroupExample.location,
    name: "example-ca",
    resource_group_name: azurermResourceGroupExample.name,
    sku_name: "S0",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermCognitiveAccountExample.overrideLogicalId("example");
const azurermCognitiveDeploymentExample =
  new azurerm.cognitiveDeployment.CognitiveDeployment(this, "example_2", {
    cognitive_account_id: azurermCognitiveAccountExample.id,
    model: [
      {
        format: "OpenAI",
        name: "text-curie-001",
        version: "1",
      },
    ],
    name: "example-cd",
    scale: [
      {
        type: "Standard",
      },
    ],
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermCognitiveDeploymentExample.overrideLogicalId("example");

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name of the Cognitive Services Account Deployment. Changing this forces a new resource to be created.

*   `cognitiveAccountId` - (Required) The ID of the Cognitive Services Account. Changing this forces a new resource to be created.

*   `model` - (Required) A `model` block as defined below. Changing this forces a new resource to be created.

*   `scale` - (Required) A `scale` block as defined below. Changing this forces a new resource to be created.

*   `raiPolicyName` - (Optional) The name of RAI policy. Changing this forces a new resource to be created.

***

A `model` block supports the following:

*   `format` - (Required) The format of the Cognitive Services Account Deployment model. Changing this forces a new resource to be created. Possible value is `openAi`.

*   `name` - (Required) The name of the Cognitive Services Account Deployment model. Changing this forces a new resource to be created.

*   `version` - (Required) The version of Cognitive Services Account Deployment model.

***

A `scale` block supports the following:

* `type` - (Required) Deployment scale type. Possible value is `standard`. Changing this forces a new resource to be created.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

* `id` - The ID of the Deployment for Azure Cognitive Services Account.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/docs/configuration/resources.html#timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Cognitive Services Account Deployment.
* `read` - (Defaults to 5 minutes) Used when retrieving the Cognitive Services Account Deployment.
* `update` - (Defaults to 30 minutes) Used when updating the Cognitive Services Account Deployment.
* `delete` - (Defaults to 30 minutes) Used when deleting the Cognitive Services Account Deployment.

## Import

Cognitive Services Account Deployment can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_cognitive_deployment.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/resourceGroup1/providers/Microsoft.CognitiveServices/accounts/account1/deployments/deployment1
```
