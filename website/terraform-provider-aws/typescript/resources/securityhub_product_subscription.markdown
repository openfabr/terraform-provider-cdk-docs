---
subcategory: "Security Hub"
layout: "aws"
page_title: "AWS: aws_securityhub_product_subscription"
description: |-
  Subscribes to a Security Hub product.
---

# Resource: awsSecurityhubProductSubscription

Subscribes to a Security Hub product.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsSecurityhubAccountExample =
  new aws.securityhubAccount.SecurityhubAccount(this, "example", {});
const dataAwsRegionCurrent = new aws.dataAwsRegion.DataAwsRegion(
  this,
  "current",
  {}
);
const awsSecurityhubProductSubscriptionExample =
  new aws.securityhubProductSubscription.SecurityhubProductSubscription(
    this,
    "example_2",
    {
      depends_on: [`\${${awsSecurityhubAccountExample.fqn}}`],
      productArn: `arn:aws:securityhub:\${${dataAwsRegionCurrent.name}}:733251395267:product/alertlogic/althreatmanagement`,
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsSecurityhubProductSubscriptionExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

* `productArn` - (Required) The ARN of the product that generates findings that you want to import into Security Hub - see below.

Amazon maintains a list of [Product integrations in AWS Security Hub](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-findings-providers.html) that changes over time. Any of the products on the linked [Available AWS service integrations](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-internal-providers.html) or [Available third-party partner product integrations](https://docs.aws.amazon.com/securityhub/latest/userguide/securityhub-partner-providers.html) can be configured using `awsSecurityhubProductSubscription`.

Available products can also be listed by running the AWS CLI command `awsSecurityhubDescribeProducts`.

A subset of currently available products (remember to replace `${varRegion}` as appropriate) includes:

* `arn:aws:securityhub:${varRegion}::product/aws/guardduty`
* `arn:aws:securityhub:${varRegion}::product/aws/inspector`
* `arn:aws:securityhub:${varRegion}::product/aws/macie`
* `arn:aws:securityhub:${varRegion}::product/alertlogic/althreatmanagement`
* `arn:aws:securityhub:${varRegion}::product/armordefense/armoranywhere`
* `arn:aws:securityhub:${varRegion}::product/barracuda/cloudsecurityguardian`
* `arn:aws:securityhub:${varRegion}::product/checkpoint/cloudguardIaas`
* `arn:aws:securityhub:${varRegion}::product/checkpoint/dome9Arc`
* `arn:aws:securityhub:${varRegion}::product/crowdstrike/crowdstrikeFalcon`
* `arn:aws:securityhub:${varRegion}::product/cyberark/cyberarkPta`
* `arn:aws:securityhub:${varRegion}::product/f5Networks/f5AdvancedWaf`
* `arn:aws:securityhub:${varRegion}::product/fortinet/fortigate`
* `arn:aws:securityhub:${varRegion}::product/guardicore/awsInfectionMonkey`
* `arn:aws:securityhub:${varRegion}::product/guardicore/guardicore`
* `arn:aws:securityhub:${varRegion}::product/ibm/qradarSiem`
* `arn:aws:securityhub:${varRegion}::product/imperva/impervaAttackAnalytics`
* `arn:aws:securityhub:${varRegion}::product/mcafeeSkyhigh/mcafeeMvisionCloudAws`
* `arn:aws:securityhub:${varRegion}::product/paloaltonetworks/redlock`
* `arn:aws:securityhub:${varRegion}::product/paloaltonetworks/vmSeries`
* `arn:aws:securityhub:${varRegion}::product/qualys/qualysPc`
* `arn:aws:securityhub:${varRegion}::product/qualys/qualysVm`
* `arn:aws:securityhub:${varRegion}::product/rapid7/insightvm`
* `arn:aws:securityhub:${varRegion}::product/sophos/sophosServerProtection`
* `arn:aws:securityhub:${varRegion}::product/splunk/splunkEnterprise`
* `arn:aws:securityhub:${varRegion}::product/splunk/splunkPhantom`
* `arn:aws:securityhub:${varRegion}::product/sumologicinc/sumologicMda`
* `arn:aws:securityhub:${varRegion}::product/symantecCorp/symantecCwp`
* `arn:aws:securityhub:${varRegion}::product/tenable/tenableIo`
* `arn:aws:securityhub:${varRegion}::product/trendMicro/deepSecurity`
* `arn:aws:securityhub:${varRegion}::product/turbot/turbot`
* `arn:aws:securityhub:${varRegion}::product/twistlock/twistlockEnterprise`

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The ARN of a resource that represents your subscription to the product that generates the findings that you want to import into Security Hub.

## Import

Security Hub product subscriptions can be imported in the form `productArn,arn`, e.g.,

```sh
$ terraform import aws_securityhub_product_subscription.example arn:aws:securityhub:eu-west-1:733251395267:product/alertlogic/althreatmanagement,arn:aws:securityhub:eu-west-1:123456789012:product-subscription/alertlogic/althreatmanagement
```
