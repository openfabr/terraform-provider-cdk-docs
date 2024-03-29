---
subcategory: "Network Firewall"
layout: "aws"
page_title: "AWS: aws_networkfirewall_resource_policy"
description: |-
  Provides an AWS Network Firewall Resource Policy resource.
---

# Resource: awsNetworkfirewallResourcePolicy

Provides an AWS Network Firewall Resource Policy Resource for a rule group or firewall policy.

## Example Usage

### For a Firewall Policy resource

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.networkfirewallResourcePolicy.NetworkfirewallResourcePolicy(
  this,
  "example",
  {
    policy:
      '${jsonencode({\n    Statement = [{\n      Action = [\n        "network-firewall:ListFirewallPolicies",\n        "network-firewall:CreateFirewall",\n        "network-firewall:UpdateFirewall",\n        "network-firewall:AssociateFirewallPolicy"\n      ]\n      Effect   = "Allow"\n      Resource = aws_networkfirewall_firewall_policy.example.arn\n      Principal = {\n        AWS = "arn:aws:iam::123456789012:root"\n      }\n    }]\n    Version = "2012-10-17"\n  })}',
    resourceArn: "${aws_networkfirewall_firewall_policy.example.arn}",
  }
);

```

### For a Rule Group resource

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.networkfirewallResourcePolicy.NetworkfirewallResourcePolicy(
  this,
  "example",
  {
    policy:
      '${jsonencode({\n    Statement = [{\n      Action = [\n        "network-firewall:ListRuleGroups",\n        "network-firewall:CreateFirewallPolicy",\n        "network-firewall:UpdateFirewallPolicy"\n      ]\n      Effect   = "Allow"\n      Resource = aws_networkfirewall_rule_group.example.arn\n      Principal = {\n        AWS = "arn:aws:iam::123456789012:root"\n      }\n    }]\n    Version = "2012-10-17"\n  })}',
    resourceArn: "${aws_networkfirewall_rule_group.example.arn}",
  }
);

```

## Argument Reference

The following arguments are supported:

*   `policy` - (Required) JSON formatted policy document that controls access to the Network Firewall resource. The policy must be provided **without whitespaces**.  We recommend using [jsonencode](https://www.terraform.io/docs/configuration/functions/jsonencode.html) for formatting as seen in the examples above. For more details, including available policy statement Actions, see the [Policy](https://docs.aws.amazon.com/network-firewall/latest/APIReference/API_PutResourcePolicy.html#API_PutResourcePolicy_RequestSyntax) parameter in the AWS API documentation.

*   `resourceArn` - (Required, Forces new resource) The Amazon Resource Name (ARN) of the rule group or firewall policy.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The Amazon Resource Name (ARN) of the rule group or firewall policy associated with the resource policy.

## Import

Network Firewall Resource Policies can be imported using the `resourceArn` e.g.,

```console
$ terraform import aws_networkfirewall_resource_policy.example aws_networkfirewall_rule_group.example arn:aws:network-firewall:us-west-1:123456789012:stateful-rulegroup/example
```
