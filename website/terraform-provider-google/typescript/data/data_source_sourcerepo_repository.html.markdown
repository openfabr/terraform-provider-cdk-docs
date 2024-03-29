---
subcategory: "Cloud Source Repositories"
description: |-
  Get information about a Google Cloud Source Repository.
---

# googleSourcerepoRepository

Get infomation about an existing Google Cloud Source Repository.
For more information see [the official documentation](https://cloud.google.com/source-repositories)
and
[API](https://cloud.google.com/source-repositories/docs/reference/rest/v1/projects.repos).

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
new google.dataGoogleSourcerepoRepository.DataGoogleSourcerepoRepository(
  this,
  "my-repo",
  {
    name: "my-repository",
  }
);

```

## Argument Reference

The following arguments are supported:

*   `name` - (Required) Resource name of the repository. The repo name may contain slashes. eg, `name/with/slash`

*   `project` - (Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used.

## Attributes Reference

See [google\_sourcerepo\_repository](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sourcerepo_repository#argument-reference) resource for details of the available attributes.
