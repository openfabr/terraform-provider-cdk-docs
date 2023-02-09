---
subcategory: "App Mesh"
layout: "aws"
page_title: "AWS: aws_appmesh_mesh"
description: |-
    Provides details about an App Mesh Mesh service mesh resource.
---

# Data Source: aws\_appmesh\_mesh

The App Mesh Mesh data source allows details of an App Mesh Mesh to be retrieved by its name and optionally the mesh\_owner.

## Example Usage

```hcl
data "aws_appmesh_mesh" "simple" {
  name = "simpleapp"
}
```

```hcl
data "aws_caller_identity" "current" {}

data "aws_appmesh_mesh" "simple" {
  name       = "simpleapp"
  mesh_owner = data.aws_caller_identity.current.account_id
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name of the service mesh.
* `meshOwner` - (Optional) AWS account ID of the service mesh's owner.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the service mesh.
* `createdDate` - Creation date of the service mesh.
* `lastUpdatedDate` - Last update date of the service mesh.
* `resourceOwner` - Resource owner's AWS account ID.
* `spec` - Service mesh specification.
* `tags` - Map of tags.

### Spec

* `egressFilter` - Egress filter rules for the service mesh.

### Egress Filter

* `type` - Egress filter type.
