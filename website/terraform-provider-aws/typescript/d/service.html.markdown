---
subcategory: "Meta Data Sources"
layout: "aws"
page_title: "AWS: aws_service"
description: |-
  Compose and decompose AWS service DNS names
---

# Data Source: aws\_service

Use this data source to compose and decompose AWS service DNS names.

## Example Usage

### Get Service DNS Name

```hcl
data "aws_region" "current" {}

data "aws_service" "test" {
  region     = data.aws_region.current.name
  service_id = "ec2"
}
```

### Use Service Reverse DNS Name to Get Components

```hcl
data "aws_service" "s3" {
  reverse_dns_name = "cn.com.amazonaws.cn-north-1.s3"
}
```

### Determine Regional Support for a Service

```hcl
data "aws_service" "s3" {
  reverse_dns_name = "com.amazonaws.us-gov-west-1.waf"
}
```

## Argument Reference

The following arguments are optional:

* `dnsName` - (Optional) DNS name of the service (*e.g.,* `rdsUsEast1AmazonawsCom`). One of `dnsName`, `reverseDnsName`, or `serviceId` is required.
* `partition` - (Optional) Partition corresponding to the region.
* `region` - (Optional) Region of the service (*e.g.,* `usWest2`, `apNortheast1`).
* `reverseDnsName` - (Optional) Reverse DNS name of the service (*e.g.,* `comAmazonawsUsWest2S3`). One of `dnsName`, `reverseDnsName`, or `serviceId` is required.
* `reverseDnsPrefix` - (Optional) Prefix of the service (*e.g.,* `comAmazonaws` in AWS Commercial, `cnComAmazonaws` in AWS China).
* `serviceId` - (Optional) Service (*e.g.,* `s3`, `rds`, `ec2`). One of `dnsName`, `reverseDnsName`, or `serviceId` is required.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `supported` - Whether the service is supported in the region's partition. New services may not be listed immediately as supported.
