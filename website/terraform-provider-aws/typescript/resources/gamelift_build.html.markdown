---
subcategory: "GameLift"
layout: "aws"
page_title: "AWS: aws_gamelift_build"
description: |-
  Provides a GameLift Build resource.
---

# Resource: awsGameliftBuild

Provides an GameLift Build resource.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.gameliftBuild.GameliftBuild(this, "test", {
  name: "example-build",
  operatingSystem: "WINDOWS_2012",
  storageLocation: {
    bucket: "${aws_s3_bucket.test.id}",
    key: "${aws_s3_object.test.key}",
    roleArn: "${aws_iam_role.test.arn}",
  },
});

```

## Argument Reference

The following arguments are supported:

* `name` - (Required) Name of the build
* `operatingSystem` - (Required) Operating system that the game server binaries are built to run onE.g., `WINDOWS_2012`, `AMAZON_LINUX` or `AMAZON_LINUX_2`.
* `storageLocation` - (Required) Information indicating where your game build files are stored. See below.
* `version` - (Optional) Version that is associated with this build.
* `tags` - (Optional) Key-value map of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Nested Fields

#### `storageLocation`

* `bucket` - (Required) Name of your S3 bucket.
* `key` - (Required) Name of the zip file containing your build files.
* `roleArn` - (Required) ARN of the access role that allows Amazon GameLift to access your S3 bucket.
* `objectVersion` - (Optional) A specific version of the file. If not set, the latest version of the file is retrieved.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - GameLift Build ID.
* `arn` - GameLift Build ARN.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

GameLift Builds can be imported using the ID, e.g.,

```console
$ terraform import aws_gamelift_build.example <build-id>
```
