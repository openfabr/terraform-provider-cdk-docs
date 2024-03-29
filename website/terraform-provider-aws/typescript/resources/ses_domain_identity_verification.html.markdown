---
subcategory: "SES (Simple Email)"
layout: "aws"
page_title: "AWS: aws_ses_domain_identity_verification"
description: |-
  Waits for and checks successful verification of an SES domain identity.
---

# Resource: awsSesDomainIdentityVerification

Represents a successful verification of an SES domain identity.

Most commonly, this resource is used together with [`awsRoute53Record`](route53_record.html) and
[`awsSesDomainIdentity`](ses_domain_identity.html) to request an SES domain identity,
deploy the required DNS verification records, and wait for verification to complete.

\~> **WARNING:** This resource implements a part of the verification workflow. It does not represent a real-world entity in AWS, therefore changing or deleting this resource on its own has no immediate effect.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsSesDomainIdentityExample = new aws.sesDomainIdentity.SesDomainIdentity(
  this,
  "example",
  {
    domain: "example.com",
  }
);
const awsRoute53RecordExampleAmazonsesVerificationRecord =
  new aws.route53Record.Route53Record(
    this,
    "example_amazonses_verification_record",
    {
      name: `_amazonses.\${${awsSesDomainIdentityExample.id}}`,
      records: [awsSesDomainIdentityExample.verificationToken],
      ttl: "600",
      type: "TXT",
      zoneId: "${aws_route53_zone.example.zone_id}",
    }
  );
new aws.sesDomainIdentityVerification.SesDomainIdentityVerification(
  this,
  "example_verification",
  {
    depends_on: [
      `\${${awsRoute53RecordExampleAmazonsesVerificationRecord.fqn}}`,
    ],
    domain: awsSesDomainIdentityExample.id,
  }
);

```

## Argument Reference

The following arguments are supported:

* `domain` - (Required) The domain name of the SES domain identity to verify.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The domain name of the domain identity.
* `arn` - The ARN of the domain identity.

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `45M`)
