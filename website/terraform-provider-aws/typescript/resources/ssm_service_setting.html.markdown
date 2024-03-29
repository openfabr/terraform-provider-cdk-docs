---
subcategory: "SSM (Systems Manager)"
layout: "aws"
page_title: "AWS: aws_ssm_service_setting"
description: |-
  Defines how a user interacts with or uses a service or a feature of a service.
---

# Resource: awsSsmServiceSetting

This setting defines how a user interacts with or uses a service or a feature of a service.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.ssmServiceSetting.SsmServiceSetting(this, "test_setting", {
  settingId:
    "arn:aws:ssm:us-east-1:123456789012:servicesetting/ssm/parameter-store/high-throughput-enabled",
  settingValue: "true",
});

```

## Argument Reference

The following arguments are supported:

* `settingId` - (Required) ID of the service setting.
* `settingValue` - (Required) Value of the service setting.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the service setting.
* `status` - Status of the service setting. Value can be `default`, `customized` or `pendingUpdate`.

## Import

AWS SSM Service Setting can be imported using the `settingId`, e.g.

```sh
$ terraform import aws_ssm_service_setting.example arn:aws:ssm:us-east-1:123456789012:servicesetting/ssm/parameter-store/high-throughput-enabled
```
