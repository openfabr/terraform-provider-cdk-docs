---
subcategory: "Attestation"
layout: "azurerm"
page_title: "Azure Resource Manager: Data Source: azurerm_attestation"
description: |-
  Gets information about an existing Attestation Provider.
---

# Data Source: azurermAttestation

Use this data source to access information about an existing Attestation Provider.

## Example Usage

```typescript
import * as cdktf from "cdktf";
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermAttestationExample =
  new azurerm.dataAzurermAttestation.DataAzurermAttestation(this, "example", {
    name: "example-attestationprovider",
    resource_group_name: "example-resource-group",
  });
new cdktf.TerraformOutput(this, "id", {
  value: dataAzurermAttestationExample.id,
});

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name of this Attestation Provider.

*   `resourceGroupName` - (Required) The name of the Resource Group where the Attestation Provider exists.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Attestation Provider.

*   `location` - The Azure Region where the Attestation Provider exists.

*   `attestationUri` - The (Endpoint|URI) of the Attestation Service.

*   `trustModel` - Trust model used for the Attestation Service.

*   `tags` - A mapping of tags assigned to the Attestation Provider.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Attestation Provider.
