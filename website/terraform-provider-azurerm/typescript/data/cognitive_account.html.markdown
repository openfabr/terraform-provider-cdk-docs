---
subcategory: "Cognitive Services"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_cognitive_account"
description: |-
  Gets information about an existing Cognitive Services Account.
---

# Data Source: azurermCognitiveAccount

Use this data source to access information about an existing Cognitive Services Account.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermCognitiveAccountTest =
  new azurerm.dataAzurermCognitiveAccount.DataAzurermCognitiveAccount(
    this,
    "test",
    {
      name: "example-account",
      resource_group_name: "cognitive_account_rg",
    }
  );
new cdktf.TerraformOutput(this, "primary_access_key", {
  value: dataAzurermCognitiveAccountTest.primaryAccessKey,
});

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Specifies the name of the Cognitive Services Account.

*   `resourceGroupName` - (Required) Specifies the name of the resource group where the Cognitive Services Account resides.

## Attributes Reference

The following attributes are exported:

*   `location` - The Azure location where the Cognitive Services Account exists

*   `kind` - The kind of the Cognitive Services Account

*   `skuName` - The SKU name of the Cognitive Services Account

*   `endpoint` - The endpoint of the Cognitive Services Account

*   `qnaRuntimeEndpoint` - If `kind` is `qnAMaker` the link to the QNA runtime.

*   `primaryAccessKey` - The primary access key of the Cognitive Services Account

*   `secondaryAccessKey` - The secondary access key of the Cognitive Services Account

*   `tags` - A mapping of tags to assigned to the resource.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Cognitive Services Account.
