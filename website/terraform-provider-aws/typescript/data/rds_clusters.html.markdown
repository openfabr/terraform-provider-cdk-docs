---
subcategory: "RDS (Relational Database)"
layout: "aws"
page_title: "AWS: aws_rds_clusters"
description: |-
  Terraform data source for managing an AWS RDS (Relational Database) Clusters.
---

# Data Source: awsRdsClusters

Terraform data source for managing an AWS RDS (Relational Database) Clusters.

## Example Usage

### Basic Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsRdsClusters.DataAwsRdsClusters(this, "example", {
  filter: [
    {
      name: "engine",
      values: ["aurora-postgresql"],
    },
  ],
});

```

## Argument Reference

The following arguments are optional:

* `filter` - (Optional) Configuration block(s) for filtering. Detailed below.

### filter Configuration block

The following arguments are supported by the `filter` configuration block:

* `name` - (Required) Name of the filter field. Valid values can be found in the [RDS DescribeDBClusters API Reference](https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_DescribeDBClusters.html).
* `values` - (Required) Set of values that are accepted for the given filter field. Results will be selected if any given value matches.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `clusterArns` - Set of cluster ARNs of the matched RDS clusters.
* `clusterIdentifiers` - Set of ARNs of cluster identifiers of the matched RDS clusters.
