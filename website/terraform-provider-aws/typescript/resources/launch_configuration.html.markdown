---
subcategory: "Auto Scaling"
layout: "aws"
page_title: "AWS: aws_launch_configuration"
description: |-
  Provides a resource to create a new launch configuration, used for autoscaling groups.
---

# Resource: awsLaunchConfiguration

Provides a resource to create a new launch configuration, used for autoscaling groups.

!> **WARNING:** The use of launch configurations is discouraged in favour of launch templates. Read more in the [AWS EC2 Documentation](https://docs.aws.amazon.com/autoscaling/ec2/userguide/launch-configurations.html).

\-> **Note** When using `awsLaunchConfiguration` with `awsAutoscalingGroup`, it is recommended to use the `namePrefix` (Optional) instead of the `name` (Optional) attribute. This will allow Terraform lifecycles to detect changes to the launch configuration and update the autoscaling group correctly.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsAmiUbuntu = new aws.dataAwsAmi.DataAwsAmi(this, "ubuntu", {
  filter: [
    {
      name: "name",
      values: ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"],
    },
    {
      name: "virtualization-type",
      values: ["hvm"],
    },
  ],
  mostRecent: true,
  owners: ["099720109477"],
});
new aws.launchConfiguration.LaunchConfiguration(this, "as_conf", {
  imageId: dataAwsAmiUbuntu.id,
  instanceType: "t2.micro",
  name: "web_config",
});

```

## Using with AutoScaling Groups

Launch Configurations cannot be updated after creation with the Amazon
Web Service API. In order to update a Launch Configuration, Terraform will
destroy the existing resource and create a replacement. In order to effectively
use a Launch Configuration resource with an [AutoScaling Group resource][1],
it's recommended to specify `createBeforeDestroy` in a [lifecycle][2] block.
Either omit the Launch Configuration `name` attribute, or specify a partial name
with `namePrefix`.  Example:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsAmiUbuntu = new aws.dataAwsAmi.DataAwsAmi(this, "ubuntu", {
  filter: [
    {
      name: "name",
      values: ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"],
    },
    {
      name: "virtualization-type",
      values: ["hvm"],
    },
  ],
  mostRecent: true,
  owners: ["099720109477"],
});
const awsLaunchConfigurationAsConf =
  new aws.launchConfiguration.LaunchConfiguration(this, "as_conf", {
    imageId: dataAwsAmiUbuntu.id,
    instanceType: "t2.micro",
    namePrefix: "terraform-lc-example-",
  });
awsLaunchConfigurationAsConf.addOverride("lifecycle", [
  {
    create_before_destroy: true,
  },
]);
const awsAutoscalingGroupBar = new aws.autoscalingGroup.AutoscalingGroup(
  this,
  "bar",
  {
    launchConfiguration: awsLaunchConfigurationAsConf.name,
    maxSize: 2,
    minSize: 1,
    name: "terraform-asg-example",
  }
);
awsAutoscalingGroupBar.addOverride("lifecycle", [
  {
    create_before_destroy: true,
  },
]);

```

With this setup Terraform generates a unique name for your Launch
Configuration and can then update the AutoScaling Group without conflict before
destroying the previous Launch Configuration.

## Using with Spot Instances

Launch configurations can set the spot instance pricing to be used for the
Auto Scaling Group to reserve instances. Simply specifying the `spotPrice`
parameter will set the price on the Launch Configuration which will attempt to
reserve your instances at this price.  See the [AWS Spot Instance
documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances.html)
for more information or how to launch [Spot Instances][3] with Terraform.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsAmiUbuntu = new aws.dataAwsAmi.DataAwsAmi(this, "ubuntu", {
  filter: [
    {
      name: "name",
      values: ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"],
    },
    {
      name: "virtualization-type",
      values: ["hvm"],
    },
  ],
  mostRecent: true,
  owners: ["099720109477"],
});
const awsLaunchConfigurationAsConf =
  new aws.launchConfiguration.LaunchConfiguration(this, "as_conf", {
    imageId: dataAwsAmiUbuntu.id,
    instanceType: "m4.large",
    spotPrice: "0.001",
  });
awsLaunchConfigurationAsConf.addOverride("lifecycle", [
  {
    create_before_destroy: true,
  },
]);
new aws.autoscalingGroup.AutoscalingGroup(this, "bar", {
  launchConfiguration: awsLaunchConfigurationAsConf.name,
  name: "terraform-asg-example",
});

```

## Argument Reference

The following arguments are required:

* `imageId` - (Required) The EC2 image ID to launch.
* `instanceType` - (Required) The size of instance to launch.

The following arguments are optional:

* `associatePublicIpAddress` - (Optional) Associate a public ip address with an instance in a VPC.
* `ebsBlockDevice` - (Optional) Additional EBS block devices to attach to the instance. See [Block Devices](#block-devices) below for details.
* `ebsOptimized` - (Optional) If true, the launched EC2 instance will be EBS-optimized.
* `enableMonitoring` - (Optional) Enables/disables detailed monitoring. This is enabled by default.
* `ephemeralBlockDevice` - (Optional) Customize Ephemeral (also known as "Instance Store") volumes on the instance. See [Block Devices](#block-devices) below for details.
* `iamInstanceProfile` - (Optional) The name attribute of the IAM instance profile to associate with launched instances.
* `keyName` - (Optional) The key name that should be used for the instance.
* `metadataOptions` - The metadata options for the instance.
  * `httpEndpoint` - The state of the metadata service: `enabled`, `disabled`.
  * `httpTokens` - If session tokens are required: `optional`, `required`.
  * `httpPutResponseHopLimit` - The desired HTTP PUT response hop limit for instance metadata requests.
* `name` - (Optional) The name of the launch configuration. If you leave this blank, Terraform will auto-generate a unique name. Conflicts with `namePrefix`.
* `namePrefix` - (Optional) Creates a unique name beginning with the specified prefix. Conflicts with `name`.
* `securityGroups` - (Optional) A list of associated security group IDS.
* `placementTenancy` - (Optional) The tenancy of the instance. Valid values are `default` or `dedicated`, see [AWS's Create Launch Configuration](http://docs.aws.amazon.com/AutoScaling/latest/APIReference/API_CreateLaunchConfiguration.html) for more details.
* `rootBlockDevice` - (Optional) Customize details about the root block device of the instance. See [Block Devices](#block-devices) below for details.
* `spotPrice` - (Optional; Default: On-demand price) The maximum price to use for reserving spot instances.
* `userData` - (Optional) The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see `userDataBase64` instead.
* `userDataBase64` - (Optional) Can be used instead of `userData` to pass base64-encoded binary data directly. Use this instead of `userData` whenever the value is not a valid UTF-8 string. For example, gzip-encoded user data must be base64-encoded and passed via this argument to avoid corruption.
* `vpcClassicLinkId` - (Optional) The ID of a ClassicLink-enabled VPC. Only applies to EC2-Classic instances. (eg. `vpc2730681A`)
* `vpcClassicLinkSecurityGroups` - (Optional) The IDs of one or more security groups for the specified ClassicLink-enabled VPC (eg. `sg46Ae3D11`).

## Block devices

Each of the `*BlockDevice` attributes controls a portion of the AWS
Launch Configuration's "Block Device Mapping". It's a good idea to familiarize yourself with [AWS's Block Device
Mapping docs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html)
to understand the implications of using these attributes.

Each AWS Instance type has a different set of Instance Store block devices
available for attachment. AWS [publishes a
list](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#StorageOnInstanceTypes)
of which ephemeral devices are available on each type. The devices are always
identified by the `virtualName` in the format `ephemeral{0N}`.

\~> **NOTE:** Changes to `*BlockDevice` configuration of *existing* resources
cannot currently be detected by Terraform. After updating to block device
configuration, resource recreation can be manually triggered by using the
[`taint` command](https://www.terraform.io/docs/commands/taint.html).

### ebsBlockDevice

Modifying any of the `ebsBlockDevice` settings requires resource replacement.

* `deviceName` - (Required) The name of the device to mount.
* `snapshotId` - (Optional) The Snapshot ID to mount.
* `volumeType` - (Optional) The type of volume. Can be `standard`, `gp2`, `gp3`, `st1`, `sc1` or `io1`.
* `volumeSize` - (Optional) The size of the volume in gigabytes.
* `iops` - (Optional) The amount of provisioned
  [IOPS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-io-characteristics.html).
  This must be set with a `volumeType` of `"io1"`.
* `throughput` - (Optional) The throughput (MiBps) to provision for a `gp3` volume.
* `deleteOnTermination` - (Optional) Whether the volume should be destroyed
  on instance termination (Default: `true`).
* `encrypted` - (Optional) Whether the volume should be encrypted or not. Defaults to `false`.
* `noDevice` - (Optional) Whether the device in the block device mapping of the AMI is suppressed.

### ephemeralBlockDevice

* `deviceName` - (Required) The name of the block device to mount on the instance.
* `noDevice` - (Optional) Whether the device in the block device mapping of the AMI is suppressed.
* `virtualName` - (Optional) The [Instance Store Device Name](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#InstanceStoreDeviceNames).

### rootBlockDevice

\-> Modifying any of the `rootBlockDevice` settings requires resource replacement.

* `deleteOnTermination` - (Optional) Whether the volume should be destroyed on instance termination. Defaults to `true`.
* `encrypted` - (Optional) Whether the volume should be encrypted or not. Defaults to `false`.
* `iops` - (Optional) The amount of provisioned [IOPS](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-io-characteristics.html). This must be set with a `volumeType` of `io1`.
* `throughput` - (Optional) The throughput (MiBps) to provision for a `gp3` volume.
* `volumeSize` - (Optional) The size of the volume in gigabytes.
* `volumeType` - (Optional) The type of volume. Can be `standard`, `gp2`, `gp3`, `st1`, `sc1` or `io1`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ID of the launch configuration.
* `arn` - The Amazon Resource Name of the launch configuration.
* `name` - The name of the launch configuration.

[1]: /docs/providers/aws/r/autoscaling_group.html

[2]: https://www.terraform.io/docs/configuration/meta-arguments/lifecycle.html

[3]: /docs/providers/aws/r/spot_instance_request.html

## Import

Launch configurations can be imported using the `name`, e.g.,

```console
$ terraform import aws_launch_configuration.as_conf terraform-lg-123456
```
