---
subcategory: "Container Apps"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_container_app_environment_certificate"
description: |-
  Gets information about a Container App Environment Certificate.
---

# Data Source: azurermContainerAppEnvironmentCertificate

Use this data source to access information about an existing Container App Environment Certificate.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const dataAzurermContainerAppEnvironmentExample =
  new azurerm.dataAzurermContainerAppEnvironment.DataAzurermContainerAppEnvironment(
    this,
    "example",
    {
      name: "example-environment",
      resource_group_name: "example-resources",
    }
  );
const dataAzurermContainerAppEnvironmentCertificateExample =
  new azurerm.dataAzurermContainerAppEnvironmentCertificate.DataAzurermContainerAppEnvironmentCertificate(
    this,
    "example_1",
    {
      container_app_environment_id:
        dataAzurermContainerAppEnvironmentExample.id,
      name: "mycertificate",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAzurermContainerAppEnvironmentCertificateExample.overrideLogicalId(
  "example"
);

```

## Arguments Reference

The following arguments are supported:

*   `name` - (Required) The name of the Container Apps Certificate. Changing this forces a new resource to be created.

*   `containerAppEnvironmentId` - (Required) The ID of the Container App Environment to configure this Certificate on. Changing this forces a new resource to be created.

## Attributes Reference

In addition to the Arguments listed above - the following Attributes are exported:

*   `id` - The ID of the Container App Environment Certificate

*   `expirationDate` - The expiration date for the Certificate.

*   `issueDate` - The date of issue for the Certificate.

*   `issuer` - The Certificate Issuer.

*   `subjectName` - The Subject Name for the Certificate.

*   `thumbprint` - The Thumbprint of the Certificate.

*   `tags` - A mapping of tags assigned to the resource.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/docs/configuration/resources.html#timeouts) for certain actions:

* `read` - (Defaults to 5 minutes) Used when retrieving the Container App Environment Certificate.
