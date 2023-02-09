---
subcategory: "App Mesh"
layout: "aws"
page_title: "AWS: aws_appmesh_virtual_service"
description: |-
    Provides an AWS App Mesh virtual service resource.
---

# Data Source: aws\_appmesh\_virtual\_service

The App Mesh Virtual Service data source allows details of an App Mesh Virtual Service to be retrieved by its name, mesh\_name, and optionally the mesh\_owner.

## Example Usage

```hcl
data "aws_appmesh_virtual_service" "test" {
  name      = "example.mesh.local"
  mesh_name = "example-mesh"
}
```

```hcl
data "aws_caller_identity" "current" {}

data "aws_appmesh_virtual_service" "test" {
  name       = "example.mesh.local"
  mesh_name  = "example-mesh"
  mesh_owner = data.aws_caller_identity.current.account_id
}
```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name of the virtual service.
* `meshName` - (Required) Name of the service mesh in which the virtual service exists.
* `meshOwner` - (Optional) AWS account ID of the service mesh's owner.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the virtual service.
* `createdDate` - Creation date of the virtual service.
* `lastUpdatedDate` - Last update date of the virtual service.
* `resourceOwner` - Resource owner's AWS account ID.
* `spec` - Virtual service specification
* `tags` - Map of tags.

### Spec

* `provider` - App Mesh object that is acting as the provider for a virtual service.

### Provider

* `virtualNode` - Virtual node associated with the virtual service.
* `virtualRouter` - Virtual router associated with the virtual service.

### Virtual Node

* `virtualNodeName` - Name of the virtual node that is acting as a service provider.

### Virtual Router

* `virtualRouterName` - Name of the virtual router that is acting as a service provider.
