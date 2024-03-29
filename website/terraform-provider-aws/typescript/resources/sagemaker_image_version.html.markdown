---
subcategory: "SageMaker"
layout: "aws"
page_title: "AWS: aws_sagemaker_image_version"
description: |-
  Provides a SageMaker Image Version resource.
---

# Resource: awsSagemakerImageVersion

Provides a SageMaker Image Version resource.

## Example Usage

### Basic usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.sagemakerImageVersion.SagemakerImageVersion(this, "test", {
  baseImage: "012345678912.dkr.ecr.us-west-2.amazonaws.com/image:latest",
  imageName: "${aws_sagemaker_image.test.id}",
});

```

## Argument Reference

The following arguments are supported:

* `imageName` - (Required) The name of the image. Must be unique to your account.
* `baseImage` - (Required) The registry path of the container image on which this image version is based.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The name of the Image.
* `arn` - The Amazon Resource Name (ARN) assigned by AWS to this Image Version.
* `imageArn`- The Amazon Resource Name (ARN) of the image the version is based on.
* `containerImage` - The registry path of the container image that contains this image version.

## Import

SageMaker Image Versions can be imported using the `name`, e.g.,

```console
$ terraform import aws_sagemaker_image_version.test_image my-code-repo
```
