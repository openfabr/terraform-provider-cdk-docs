---
subcategory: "EBS (EC2)"
layout: "aws"
page_title: "AWS: aws_ebs_default_kms_key"
description: |-
  Provides metadata about the KMS key set for EBS default encryption
---

# Data Source: awsEbsDefaultKmsKey

Use this data source to get the default EBS encryption KMS key in the current region.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const dataAwsEbsDefaultKmsKeyCurrent =
  new aws.dataAwsEbsDefaultKmsKey.DataAwsEbsDefaultKmsKey(this, "current", {});
new aws.ebsVolume.EbsVolume(this, "example", {
  availabilityZone: "us-west-2a",
  encrypted: true,
  kmsKeyId: dataAwsEbsDefaultKmsKeyCurrent.keyArn,
});

```

## Attributes Reference

The following attributes are exported:

* `keyArn` - ARN of the default KMS key uses to encrypt an EBS volume in this region when no key is specified in an API call that creates the volume and encryption by default is enabled.
* `id` - Region of the default KMS Key.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `read` - (Default `20M`)
