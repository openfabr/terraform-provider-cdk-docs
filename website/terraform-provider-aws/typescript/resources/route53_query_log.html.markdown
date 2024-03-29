---
subcategory: "Route 53"
layout: "aws"
page_title: "AWS: aws_route53_query_log"
description: |-
  Provides a Route53 query logging configuration resource.
---

# Resource: awsRoute53QueryLog

Provides a Route53 query logging configuration resource.

\~> **NOTE:** There are restrictions on the configuration of query logging. Notably,
the CloudWatch log group must be in the `usEast1` region,
a permissive CloudWatch log resource policy must be in place, and
the Route53 hosted zone must be public.
See [Configuring Logging for DNS Queries](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/query-logs.html?console_help=true#query-logs-configuring) for additional details.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsUsEast1 = new aws.provider.AwsProvider(this, "aws", {
  alias: "us-east-1",
  region: "us-east-1",
});
const awsRoute53ZoneExampleCom = new aws.route53Zone.Route53Zone(
  this,
  "example_com",
  {
    name: "example.com",
  }
);
const dataAwsIamPolicyDocumentRoute53QueryLoggingPolicy =
  new aws.dataAwsIamPolicyDocument.DataAwsIamPolicyDocument(
    this,
    "route53-query-logging-policy",
    {
      statement: [
        {
          actions: ["logs:CreateLogStream", "logs:PutLogEvents"],
          principals: [
            {
              identifiers: ["route53.amazonaws.com"],
              type: "Service",
            },
          ],
          resources: ["arn:aws:logs:*:*:log-group:/aws/route53/*"],
        },
      ],
    }
  );
const awsCloudwatchLogGroupAwsRoute53ExampleCom =
  new aws.cloudwatchLogGroup.CloudwatchLogGroup(
    this,
    "aws_route53_example_com",
    {
      name: `/aws/route53/\${${awsRoute53ZoneExampleCom.name}}`,
      provider: `\${${awsUsEast1.fqn}}`,
      retentionInDays: 30,
    }
  );
const awsCloudwatchLogResourcePolicyRoute53QueryLoggingPolicy =
  new aws.cloudwatchLogResourcePolicy.CloudwatchLogResourcePolicy(
    this,
    "route53-query-logging-policy_4",
    {
      policyDocument: dataAwsIamPolicyDocumentRoute53QueryLoggingPolicy.json,
      policyName: "route53-query-logging-policy",
      provider: `\${${awsUsEast1.fqn}}`,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsCloudwatchLogResourcePolicyRoute53QueryLoggingPolicy.overrideLogicalId(
  "route53-query-logging-policy"
);
const awsRoute53QueryLogExampleCom = new aws.route53QueryLog.Route53QueryLog(
  this,
  "example_com_5",
  {
    cloudwatchLogGroupArn: awsCloudwatchLogGroupAwsRoute53ExampleCom.arn,
    depends_on: [
      `\${${awsCloudwatchLogResourcePolicyRoute53QueryLoggingPolicy.fqn}}`,
    ],
    zoneId: awsRoute53ZoneExampleCom.zoneId,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsRoute53QueryLogExampleCom.overrideLogicalId("example_com");

```

## Argument Reference

The following arguments are supported:

* `cloudwatchLogGroupArn` - (Required) CloudWatch log group ARN to send query logs.
* `zoneId` - (Required) Route53 hosted zone ID to enable query logs.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The Amazon Resource Name (ARN) of the Query Logging Config.
* `id` - The query logging configuration ID

## Import

Route53 query logging configurations can be imported using their ID, e.g.,

```console
$ terraform import aws_route53_query_log.example_com xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
```
