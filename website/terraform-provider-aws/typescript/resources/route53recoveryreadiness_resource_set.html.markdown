---
subcategory: "Route 53 Recovery Readiness"
layout: "aws"
page_title: "AWS: aws_route53recoveryreadiness_resource_set"
description: |-
  Provides an AWS Route 53 Recovery Readiness Resource Set
---

# Resource: awsRoute53RecoveryreadinessResourceSet

Provides an AWS Route 53 Recovery Readiness Resource Set.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.route53RecoveryreadinessResourceSet.Route53RecoveryreadinessResourceSet(
  this,
  "example",
  {
    resourceSetName: "${my-cw-alarm-set}",
    resourceSetType: "AWS::CloudWatch::Alarm",
    resources: [
      {
        resourceArn: "${aws_cloudwatch_metric_alarm.example.arn}",
      },
    ],
  }
);

```

## Argument Reference

The following arguments are supported:

* `resourceSetName` - (Required) Unique name describing the resource set.
* `resourceSetType` - (Required) Type of the resources in the resource set.
* `resources` - (Required) List of resources to add to this resource set. See below.

The following arguments are optional:

* `tags` - (Optional) Key-value mapping of resource tags. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.

### resources

* `dnsTargetResource` - (Required if `resourceArn` is not set) Component for DNS/Routing Control Readiness Checks.
* `readinessScopes` - (Optional) Recovery group ARN or cell ARN that contains this resource set.
* `resourceArn` - (Required if `dnsTargetResource` is not set) ARN of the resource.

### dnsTargetResource

* `domainName` - (Optional) DNS Name that acts as the ingress point to a portion of application.
* `hostedZoneArn` - (Optional) Hosted Zone ARN that contains the DNS record with the provided name of target resource.
* `recordSetId` - (Optional) Route53 record set id to uniquely identify a record given a `domainName` and a `recordType`.
* `recordType` - (Optional) Type of DNS Record of target resource.
* `targetResource` - (Optional) Target resource the R53 record specified with the above params points to.

### targetResource

* `nlbResource` - (Optional) NLB resource a DNS Target Resource points to. Required if `r53Resource` is not set.
* `r53Resource` - (Optional) Route53 resource a DNS Target Resource record points to.

### nlbResource

* `arn` - (Required) NLB resource ARN.

### r53Resource

* `domainName` - (Optional) Domain name that is targeted.
* `recordSetId` - (Optional) Resource record set ID that is targeted.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the resource set
* `resources.#ComponentId` - Unique identified for DNS Target Resources, use for readiness checks.
* `tagsAll` - Map of tags assigned to the resource, including those inherited from the provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block).

## Import

Route53 Recovery Readiness resource set name can be imported via the resource set name, e.g.,

```console
$ terraform import aws_route53recoveryreadiness_resource_set.my-cw-alarm-set
```

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `delete` - (Default `5M`)
