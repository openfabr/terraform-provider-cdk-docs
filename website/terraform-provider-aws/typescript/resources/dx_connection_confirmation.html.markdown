---
subcategory: "Direct Connect"
layout: "aws"
page_title: "AWS: aws_dx_connection_confirmation"
description: |-
  Provides a confirmation of the creation of the specified hosted connection on an interconnect.
---

# Resource: awsDxConnectionConfirmation

Provides a confirmation of the creation of the specified hosted connection on an interconnect.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dxConnectionConfirmation.DxConnectionConfirmation(
  this,
  "confirmation",
  {
    connectionId: "dxcon-ffabc123",
  }
);

```

## Argument Reference

The following arguments are supported:

* `connectionId` - (Required) The ID of the hosted connection.

### Removing `awsDxConnectionConfirmation` from your configuration

Removing an `awsDxConnectionConfirmation` resource from your configuration will remove it
from your statefile and management, **but will not destroy the Hosted Connection.**

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ID of the connection.
