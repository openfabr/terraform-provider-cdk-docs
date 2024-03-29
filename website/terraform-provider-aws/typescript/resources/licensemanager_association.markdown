---
subcategory: "License Manager"
layout: "aws"
page_title: "AWS: aws_licensemanager_association"
description: |-
  Provides a License Manager association resource.
---

# Resource: awsLicensemanagerAssociation

Provides a License Manager association.

\~> **Note:** License configurations can also be associated with launch templates by specifying the `licenseSpecifications` block for an `awsLaunchTemplate`.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsLicensemanagerLicenseConfigurationExample =
  new aws.licensemanagerLicenseConfiguration.LicensemanagerLicenseConfiguration(
    this,
    "example",
    {
      licenseCountingType: "Instance",
      name: "Example",
    }
  );
const dataAwsAmiExample = new aws.dataAwsAmi.DataAwsAmi(this, "example_1", {
  filter: [
    {
      name: "name",
      values: ["amzn-ami-vpc-nat*"],
    },
  ],
  mostRecent: true,
  owners: ["amazon"],
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
dataAwsAmiExample.overrideLogicalId("example");
const awsInstanceExample = new aws.instance.Instance(this, "example_2", {
  ami: dataAwsAmiExample.id,
  instanceType: "t2.micro",
});
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsInstanceExample.overrideLogicalId("example");
const awsLicensemanagerAssociationExample =
  new aws.licensemanagerAssociation.LicensemanagerAssociation(
    this,
    "example_3",
    {
      licenseConfigurationArn: awsLicensemanagerLicenseConfigurationExample.arn,
      resourceArn: awsInstanceExample.arn,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsLicensemanagerAssociationExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `licenseConfigurationArn` - (Required) ARN of the license configuration.
* `resourceArn` - (Required) ARN of the resource associated with the license configuration.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The license configuration ARN.

## Import

License configurations can be imported in the form `resourceArn,licenseConfigurationArn`, e.g.,

```console
$ terraform import aws_licensemanager_association.example arn:aws:ec2:eu-west-1:123456789012:image/ami-123456789abcdef01,arn:aws:license-manager:eu-west-1:123456789012:license-configuration:lic-0123456789abcdef0123456789abcdef
```
