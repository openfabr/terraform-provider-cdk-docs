---
subcategory: "ECR (Elastic Container Registry)"
layout: "aws"
page_title: "AWS: aws_ecr_registry_scanning_configuration"
description: |-
  Provides an Elastic Container Registry Scanning Configuration.
---

# Resource: awsEcrRegistryScanningConfiguration

Provides an Elastic Container Registry Scanning Configuration. Can't be completely deleted, instead reverts to the default `basic` scanning configuration without rules.

## Example Usage

### Basic example

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.ecrRegistryScanningConfiguration.EcrRegistryScanningConfiguration(
  this,
  "configuration",
  {
    rule: [
      {
        repositoryFilter: [
          {
            filter: "example",
            filterType: "WILDCARD",
          },
        ],
        scanFrequency: "CONTINUOUS_SCAN",
      },
    ],
    scanType: "ENHANCED",
  }
);

```

### Multiple rules

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.ecrRegistryScanningConfiguration.EcrRegistryScanningConfiguration(
  this,
  "test",
  {
    rule: [
      {
        repositoryFilter: [
          {
            filter: "*",
            filterType: "WILDCARD",
          },
        ],
        scanFrequency: "SCAN_ON_PUSH",
      },
      {
        repositoryFilter: [
          {
            filter: "example",
            filterType: "WILDCARD",
          },
        ],
        scanFrequency: "CONTINUOUS_SCAN",
      },
    ],
    scanType: "ENHANCED",
  }
);

```

## Argument Reference

The following arguments are supported:

* `scanType` - (Required) the scanning type to set for the registry. Can be either `enhanced` or `basic`.
* `rule` - (Optional) One or multiple blocks specifying scanning rules to determine which repository filters are used and at what frequency scanning will occur. See [below for schema](#rule).

### rule

* `repositoryFilter` - (Required) One or more repository filter blocks, containing a `filter` (required string filtering repositories, see pattern regex [here](https://docs.aws.amazon.com/AmazonECR/latest/APIReference/API_ScanningRepositoryFilter.html)) and a `filterType` (required string, currently only `wildcard` is supported).
* `scanFrequency` - (Required) The frequency that scans are performed at for a private registry. Can be `SCAN_ON_PUSH`, `CONTINUOUS_SCAN`, or `manual`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `registryId` - The registry ID the scanning configuration applies to.

## Import

ECR Scanning Configurations can be imported using the `registryId`, e.g.,

```console
$ terraform import aws_ecr_registry_scanning_configuration.example 012345678901
```
