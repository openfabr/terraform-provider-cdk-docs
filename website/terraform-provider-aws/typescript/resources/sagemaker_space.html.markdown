---
subcategory: "SageMaker"
layout: "aws"
page_title: "AWS: aws_sagemaker_space"
description: |-
  Provides a SageMaker Space resource.
---

# Resource: awsSagemakerSpace

Provides a SageMaker Space resource.

## Example Usage

### Basic usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.sagemakerSpace.SagemakerSpace(this, "example", {
  domainId: "${aws_sagemaker_domain.test.id}",
  spaceName: "example",
});

```

## Argument Reference

The following arguments are supported:

* `spaceName` - (Required) The name of the space.
* `domainId` - (Required) The ID of the associated Domain.
* `spaceSettings` - (Required) A collection of space settings. See [Space Settings](#space-settings) below.
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Space Settings

* `jupyterServerAppSettings` - (Optional) The Jupyter server's app settings. See [Jupyter Server App Settings](#jupyter-server-app-settings) below.
* `kernelGatewayAppSettings` - (Optional) The kernel gateway app settings. See [Kernel Gateway App Settings](#kernel-gateway-app-settings) below.

#### Kernel Gateway App Settings

* `defaultResourceSpec` - (Optional) The default instance type and the Amazon Resource Name (ARN) of the SageMaker image created on the instance. see [Default Resource Spec](#default-resource-spec) below.
* `customImage` - (Optional) A list of custom SageMaker images that are configured to run as a KernelGateway app. see [Custom Image](#custom-image) below.
* `lifecycleConfigArns` - (Optional) The Amazon Resource Name (ARN) of the Lifecycle Configurations.

#### Jupyter Server App Settings

* `codeRepository` - (Optional) A list of Git repositories that SageMaker automatically displays to users for cloning in the JupyterServer application. see [Code Repository](#code-repository) below.
* `defaultResourceSpec` - (Optional) The default instance type and the Amazon Resource Name (ARN) of the SageMaker image created on the instance. see [Default Resource Spec](#default-resource-spec) below.
* `lifecycleConfigArns` - (Optional) The Amazon Resource Name (ARN) of the Lifecycle Configurations.

##### Code Repository

* `repositoryUrl` - (Optional) The URL of the Git repository.

##### Default Resource Spec

* `instanceType` - (Optional) The instance type.
* `lifecycleConfigArn` - (Optional) The Amazon Resource Name (ARN) of the Lifecycle Configuration attached to the Resource.
* `sagemakerImageArn` - (Optional) The Amazon Resource Name (ARN) of the SageMaker image created on the instance.
* `sagemakerImageVersionArn` - (Optional) The ARN of the image version created on the instance.

##### Custom Image

* `appImageConfigName` - (Required) The name of the App Image Config.
* `imageName` - (Required) The name of the Custom Image.
* `imageVersionNumber` - (Optional) The version number of the Custom Image.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The space's Amazon Resource Name (ARN).
* `arn` - The space's Amazon Resource Name (ARN).
* `homeEfsFileSystemUid` - The ID of the space's profile in the Amazon Elastic File System volume.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

SageMaker Spaces can be imported using the `id`, e.g.,

```console
$ terraform import aws_sagemaker_space.test_space arn:aws:sagemaker:us-west-2:123456789012:space/domain-id/space-name
```
