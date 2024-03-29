---
subcategory: "Lambda"
layout: "aws"
page_title: "AWS: aws_lambda_layer_version_permission"
description: |-
  Provides a Lambda Layer Version Permission resource.
---

# Resource: awsLambdaLayerVersionPermission

Provides a Lambda Layer Version Permission resource. It allows you to share you own Lambda Layers to another account by account ID, to all accounts in AWS organization or even to all AWS accounts.

For information about Lambda Layer Permissions and how to use them, see [Using Resource-based Policies for AWS Lambda][1]

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.lambdaLayerVersionPermission.LambdaLayerVersionPermission(
  this,
  "lambda_layer_permission",
  {
    action: "lambda:GetLayerVersion",
    layerName: "arn:aws:lambda:us-west-2:123456654321:layer:test_layer1",
    principal: "111111111111",
    statementId: "dev-account",
    versionNumber: 1,
  }
);

```

## Argument Reference

The following arguments are supported:

* `action` - (Required) Action, which will be allowed. `lambda:getLayerVersion` value is suggested by AWS documantation.
* `layerName` (Required) The name or ARN of the Lambda Layer, which you want to grant access to.
* `organizationId` - (Optional) An identifier of AWS Organization, which should be able to use your Lambda Layer. `principal` should be equal to `*` if `organizationId` provided.
* `principal` - (Required) AWS account ID which should be able to use your Lambda Layer. `*` can be used here, if you want to share your Lambda Layer widely.
* `statementId` - (Required) The name of Lambda Layer Permission, for example `devAccount` - human readable note about what is this permission for.
* `versionNumber` (Required) Version of Lambda Layer, which you want to grant access to. Note: permissions only apply to a single version of a layer.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The `layerName` and `versionNumber`, separated by a comma (`,`).
* `revisionId` - A unique identifier for the current revision of the policy.
* `policy` - Full Lambda Layer Permission policy.

## Import

Lambda Layer Permissions can be imported using `layerName` and `versionNumber`, separated by a comma (`,`).

```sh
$ terraform import aws_lambda_layer_version_permission.example arn:aws:lambda:us-west-2:123456654321:layer:test_layer1,1
```

[1]: https://docs.aws.amazon.com/lambda/latest/dg/access-control-resource-based.html#permissions-resource-xaccountlayer
