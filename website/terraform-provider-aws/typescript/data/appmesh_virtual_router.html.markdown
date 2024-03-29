---
subcategory: "App Mesh"
layout: "aws"
page_title: "AWS: aws_appmesh_virtual_router"
description: |-
    Terraform data source for managing an AWS App Mesh Virtual Router.
---

# Data Source: awsAppmeshVirtualRouter

The App Mesh Virtual Router data source allows details of an App Mesh Virtual Service to be retrieved by its name and mesh\_name.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsAppmeshVirtualRouter.DataAwsAppmeshVirtualRouter(this, "test", {
  mesh_name: "example-mesh-name",
  name: "example-router-name",
});

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name of the virtual router.
* `meshName` - (Required) Name of the mesh in which the virtual router exists

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the virtual router.
* `createdDate` - Creation date of the virtual router.
* `lastUpdatedDate` - Last update date of the virtual router.
* `resourceOwner` - Resource owner's AWS account ID.
* `spec` - Virtual routers specification. See the [`awsAppmeshVirtualRouter`](/docs/providers/aws/r/appmesh_virtual_router.html#spec) resource for details.
* `tags` - Map of tags.
