---
subcategory: "License Manager"
layout: "aws"
page_title: "AWS: aws_licensemanager_received_licenses"
description: |-
    Get information about a set of license manager received licenses
---

# Data Source: awsLicensemanagerReceivedLicenses

This resource can be used to get a set of license ARNs matching a filter.

## Example Usage

The following shows getting all license ARNs issued from the AWS marketplace. Providing no filter, would provide all license ARNs for the entire account.

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsLicensemanagerReceivedLicenses.DataAwsLicensemanagerReceivedLicenses(
  this,
  "test",
  {
    filter: [
      {
        name: "IssuerName",
        values: ["AWS/Marketplace"],
      },
    ],
  }
);

```

## Argument Reference

* `filter` - (Optional) Custom filter block as described below.

More complex filters can be expressed using one or more `filter` sub-blocks,
which take the following arguments:

* `name` - (Required) Name of the field to filter by, as defined by
  [the underlying AWS API](https://docs.aws.amazon.com/license-manager/latest/APIReference/API_ListReceivedLicenses.html#API_ListReceivedLicenses_RequestSyntax).
  For example, if filtering using `productSku`, use:

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsLicensemanagerReceivedLicenses.DataAwsLicensemanagerReceivedLicenses(
  this,
  "selected",
  {
    filter: [
      {
        name: "ProductSKU",
        values: [""],
      },
    ],
  }
);

```

* `values` - (Required) Set of values that are accepted for the given field.

## Attributes Reference

* `arns` - List of all the license ARNs found.
