---
subcategory: "Direct Connect"
layout: "aws"
page_title: "AWS: aws_dx_locations"
description: |-
  Retrieve information about the AWS Direct Connect locations in the current AWS Region.
---

# Data Source: aws\_dx\_locations

Retrieve information about the AWS Direct Connect locations in the current AWS Region.
These are the locations that can be specified when configuring [`awsDxConnection`](/docs/providers/aws/r/dx_connection.html) or [`awsDxLag`](/docs/providers/aws/r/dx_lag.html) resources.

\~> **Note:** This data source is different from the [`awsDxLocation`](/docs/providers/aws/d/dx_location.html) data source which retrieves information about a specific AWS Direct Connect location in the current AWS Region.

## Example Usage

```hcl
data "aws_dx_locations" "available" {}
```

## Argument Reference

There are no arguments available for this data source.

## Attributes Reference

* `locationCodes` - Code for the locations.
