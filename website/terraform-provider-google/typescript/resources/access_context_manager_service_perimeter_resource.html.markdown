---
# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    Type: MMv1     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in
#     .github/CONTRIBUTING.md.
#
# ----------------------------------------------------------------------------
subcategory: "Access Context Manager (VPC Service Controls)"
description: |-
  Allows configuring a single GCP resource that should be inside of a service perimeter.
---

# googleAccessContextManagerServicePerimeterResource

Allows configuring a single GCP resource that should be inside of a service perimeter.
This resource is intended to be used in cases where it is not possible to compile a full list
of projects to include in a `googleAccessContextManagerServicePerimeter` resource,
to enable them to be added separately.

\~> **Note:** If this resource is used alongside a `googleAccessContextManagerServicePerimeter` resource,
the service perimeter resource must have a `lifecycle` block with `ignoreChanges = [status[0]Resources]` so
they don't fight over which resources should be in the policy.

To get more information about ServicePerimeterResource, see:

* [API documentation](https://cloud.google.com/access-context-manager/docs/reference/rest/v1/accessPolicies.servicePerimeters)
* How-to Guides
  * [Service Perimeter Quickstart](https://cloud.google.com/vpc-service-controls/docs/quickstart)

\~> **Warning:** If you are using User ADCs (Application Default Credentials) with this resource,
you must specify a `billingProject` and set `userProjectOverride` to true
in the provider configuration. Otherwise the ACM API will return a 403 error.
Your account must have the `serviceusageServicesUse` permission on the
`billingProject` you defined.

## Example Usage - Access Context Manager Service Perimeter Resource Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleAccessContextManagerAccessPolicyAccessPolicy =
  new google.accessContextManagerAccessPolicy.AccessContextManagerAccessPolicy(
    this,
    "access-policy",
    {
      parent: "organizations/123456789",
      title: "my policy",
    }
  );
const googleAccessContextManagerServicePerimeterServicePerimeterResource =
  new google.accessContextManagerServicePerimeter.AccessContextManagerServicePerimeter(
    this,
    "service-perimeter-resource",
    {
      name: `accessPolicies/\${${googleAccessContextManagerAccessPolicyAccessPolicy.name}}/servicePerimeters/restrict_all`,
      parent: `accessPolicies/\${${googleAccessContextManagerAccessPolicyAccessPolicy.name}}`,
      status: [
        {
          restricted_services: ["storage.googleapis.com"],
        },
      ],
      title: "restrict_all",
    }
  );
googleAccessContextManagerServicePerimeterServicePerimeterResource.addOverride(
  "lifecycle",
  [
    {
      ignore_changes: ["${status[0].resources}"],
    },
  ]
);
const googleAccessContextManagerServicePerimeterResourceServicePerimeterResource =
  new google.accessContextManagerServicePerimeterResource.AccessContextManagerServicePerimeterResource(
    this,
    "service-perimeter-resource_2",
    {
      perimeter_name:
        googleAccessContextManagerServicePerimeterServicePerimeterResource.name,
      resource: "projects/987654321",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
googleAccessContextManagerServicePerimeterResourceServicePerimeterResource.overrideLogicalId(
  "service-perimeter-resource"
);

```

## Argument Reference

The following arguments are supported:

*   `resource` -
    (Required)
    A GCP resource that is inside of the service perimeter.
    Currently only projects are allowed.
    Format: projects/{project\_number}

*   `perimeterName` -
    (Required)
    The name of the Service Perimeter to add this resource to.

***

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

* `id` - an identifier for the resource with format `{{perimeterName}}/{{resource}}`

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

ServicePerimeterResource can be imported using any of these accepted formats:

```console
$ terraform import google_access_context_manager_service_perimeter_resource.default {{perimeter_name}}/{{resource}}
```
