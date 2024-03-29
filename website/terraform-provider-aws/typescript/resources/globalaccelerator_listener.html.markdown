---
subcategory: "Global Accelerator"
layout: "aws"
page_title: "AWS: aws_globalaccelerator_listener"
description: |-
  Provides a Global Accelerator listener.
---

# Resource: awsGlobalacceleratorListener

Provides a Global Accelerator listener.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsGlobalacceleratorAcceleratorExample =
  new aws.globalacceleratorAccelerator.GlobalacceleratorAccelerator(
    this,
    "example",
    {
      attributes: {
        flowLogsEnabled: true,
        flowLogsS3Bucket: "example-bucket",
        flowLogsS3Prefix: "flow-logs/",
      },
      enabled: true,
      ipAddressType: "IPV4",
      name: "Example",
    }
  );
const awsGlobalacceleratorListenerExample =
  new aws.globalacceleratorListener.GlobalacceleratorListener(
    this,
    "example_1",
    {
      acceleratorArn: awsGlobalacceleratorAcceleratorExample.id,
      clientAffinity: "SOURCE_IP",
      portRange: [
        {
          fromPort: 80,
          toPort: 80,
        },
      ],
      protocol: "TCP",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsGlobalacceleratorListenerExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `acceleratorArn` - (Required) The Amazon Resource Name (ARN) of your accelerator.
* `clientAffinity` - (Optional) Direct all requests from a user to the same endpoint. Valid values are `none`, `SOURCE_IP`. Default: `none`. If `none`, Global Accelerator uses the "five-tuple" properties of source IP address, source port, destination IP address, destination port, and protocol to select the hash value. If `SOURCE_IP`, Global Accelerator uses the "two-tuple" properties of source (client) IP address and destination IP address to select the hash value.
* `protocol` - (Optional) The protocol for the connections from clients to the accelerator. Valid values are `tcp`, `udp`.
* `portRange` - (Optional) The list of port ranges for the connections from clients to the accelerator. Fields documented below.

**port\_range** supports the following attributes:

* `fromPort` - (Optional) The first port in the range of ports, inclusive.
* `toPort` - (Optional) The last port in the range of ports, inclusive.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The Amazon Resource Name (ARN) of the listener.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `30M`)
* `update` - (Default `30M`)
* `delete` - (Default `30M`)

## Import

Global Accelerator listeners can be imported using the `id`, e.g.,

```console
$ terraform import aws_globalaccelerator_listener.example arn:aws:globalaccelerator::111111111111:accelerator/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/listener/xxxxxxxx
```
