---
subcategory: "Roles Anywhere"
layout: "aws"
page_title: "AWS: aws_rolesanywhere_trust_anchor"
description: |-
  Provides a Roles Anywhere Trust Anchor resource
---

# Resource: awsRolesanywhereTrustAnchor

Terraform resource for managing a Roles Anywhere Trust Anchor.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsAcmpcaCertificateAuthorityExample =
  new aws.acmpcaCertificateAuthority.AcmpcaCertificateAuthority(
    this,
    "example",
    {
      certificateAuthorityConfiguration: {
        keyAlgorithm: "RSA_4096",
        signingAlgorithm: "SHA512WITHRSA",
        subject: {
          commonName: "example.com",
        },
      },
      permanentDeletionTimeInDays: 7,
      type: "ROOT",
    }
  );
const awsAcmpcaCertificateAuthorityCertificateExample =
  new aws.acmpcaCertificateAuthorityCertificate.AcmpcaCertificateAuthorityCertificate(
    this,
    "example_1",
    {
      certificate: "${aws_acmpca_certificate.example.certificate}",
      certificateAuthorityArn: awsAcmpcaCertificateAuthorityExample.arn,
      certificateChain: "${aws_acmpca_certificate.example.certificate_chain}",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsAcmpcaCertificateAuthorityCertificateExample.overrideLogicalId("example");
new aws.rolesanywhereTrustAnchor.RolesanywhereTrustAnchor(this, "test", {
  depends_on: [`\${${awsAcmpcaCertificateAuthorityCertificateExample.fqn}}`],
  name: "example",
  source: {
    sourceData: {
      acmPcaArn: awsAcmpcaCertificateAuthorityExample.arn,
    },
    sourceType: "AWS_ACM_PCA",
  },
});
const dataAwsPartitionCurrent = new aws.dataAwsPartition.DataAwsPartition(
  this,
  "current",
  {}
);
const awsAcmpcaCertificateTest = new aws.acmpcaCertificate.AcmpcaCertificate(
  this,
  "test_4",
  {
    certificateAuthorityArn: awsAcmpcaCertificateAuthorityExample.arn,
    certificateSigningRequest:
      awsAcmpcaCertificateAuthorityExample.certificateSigningRequest,
    signingAlgorithm: "SHA512WITHRSA",
    templateArn: `arn:\${${dataAwsPartitionCurrent.partition}}:acm-pca:::template/RootCACertificate/V1`,
    validity: {
      type: "YEARS",
      value: 1,
    },
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsAcmpcaCertificateTest.overrideLogicalId("test");

```

## Argument Reference

The following arguments are supported:

* `enabled` - (Optional) Whether or not the Trust Anchor should be enabled.
* `name` - (Required) The name of the Trust Anchor.
* `source` - (Required) The source of trust, documented below
* `tags` - (Optional) A map of tags to assign to the resource. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### Nested Blocks

#### `source`

* `sourceData` - (Required) The data denoting the source of trust, documented below
* `sourceType` - (Required) The type of the source of trust. Must be either `AWS_ACM_PCA` or `CERTIFICATE_BUNDLE`.

#### `sourceData`

* `acmPcaArn` - (Optional, required when `sourceType` is `AWS_ACM_PCA`) The ARN of an ACM Private Certificate Authority.
* `x509CertificateData` - (Optional, required when `sourceType` is `CERTIFICATE_BUNDLE`)

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - Amazon Resource Name (ARN) of the Trust Anchor
* `id` - The Trust Anchor ID.
* `tagsAll` - A map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

`awsRolesanywhereTrustAnchor` can be imported using its `id`, e.g.

```console
$ terraform import aws_rolesanywhere_trust_anchor.example 92b2fbbb-984d-41a3-a765-e3cbdb69ebb1
```
