---
subcategory: "SESv2 (Simple Email V2)"
layout: "aws"
page_title: "AWS: aws_sesv2_configuration_set"
description: |-
  Terraform resource for managing an AWS SESv2 (Simple Email V2) Configuration Set.
---

# Resource: awsSesv2ConfigurationSet

Terraform resource for managing an AWS SESv2 (Simple Email V2) Configuration Set.

## Example Usage

### Basic Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.sesv2ConfigurationSet.Sesv2ConfigurationSet(this, "example", {
  configurationSetName: "example",
  deliveryOptions: {
    tlsPolicy: "REQUIRE",
  },
  reputationOptions: {
    reputationMetricsEnabled: false,
  },
  sendingOptions: {
    sendingEnabled: true,
  },
  suppressionOptions: {
    suppressedReasons: ["BOUNCE", "COMPLAINT"],
  },
  trackingOptions: {
    customRedirectDomain: "example.com",
  },
});

```

## Argument Reference

The following arguments are supported:

* `configurationSetName` - (Required) The name of the configuration set.
* `deliveryOptions` - (Optional) An object that defines the dedicated IP pool that is used to send emails that you send using the configuration set.
* `reputationOptions` - (Optional) An object that defines whether or not Amazon SES collects reputation metrics for the emails that you send that use the configuration set.
* `sendingOptions` - (Optional) An object that defines whether or not Amazon SES can send email that you send using the configuration set.
* `suppressionOptions` - (Optional) An object that contains information about the suppression list preferences for your account.
* `tags` - (Optional) A map of tags to assign to the service. If configured with a provider [`defaultTags` configuration block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs#default_tags-configuration-block) present, tags with matching keys will overwrite those defined at the provider-level.
* `trackingOptions` - (Optional) An object that defines the open and click tracking options for emails that you send using the configuration set.
* `vdmOptions` - (Optional) An object that defines the VDM settings that apply to emails that you send using the configuration set.

### deliveryOptions

The following arguments are supported:

* `sendingPoolName` - (Optional) The name of the dedicated IP pool to associate with the configuration set.
* `tlsPolicy` - (Optional) Specifies whether messages that use the configuration set are required to use Transport Layer Security (TLS). Valid values: `require`, `optional`.

### reputationOptions

The following arguments are supported;

* `reputationMetricsEnabled` - (Optional) If `true`, tracking of reputation metrics is enabled for the configuration set. If `false`, tracking of reputation metrics is disabled for the configuration set.

### sendingOptions

The following arguments are supported:

* `sendingEnabled` - (Optional) If `true`, email sending is enabled for the configuration set. If `false`, email sending is disabled for the configuration set.

### suppressionOptions

* `suppressedReasons` - (Optional) A list that contains the reasons that email addresses are automatically added to the suppression list for your account. Valid values: `bounce`, `complaint`.

### trackingOptions

* `customRedirectDomain` - (Required) The domain to use for tracking open and click events.

### vdmOptions

* `dashboardOptions` - (Optional) Specifies additional settings for your VDM configuration as applicable to the Dashboard.
* `guardianOptions` - (Optional) Specifies additional settings for your VDM configuration as applicable to the Guardian.

### dashboardOptions

* `engagementMetrics` - (Optional) Specifies the status of your VDM engagement metrics collection. Valid values: `enabled`, `disabled`.

### guardianOptions

* `optimizedSharedDelivery` - (Optional) Specifies the status of your VDM optimized shared delivery. Valid values: `enabled`, `disabled`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - ARN of the Configuration Set.
* `reputationOptions` - An object that defines whether or not Amazon SES collects reputation metrics for the emails that you send that use the configuration set.
  * `lastFreshStart` - The date and time (in Unix time) when the reputation metrics were last given a fresh start. When your account is given a fresh start, your reputation metrics are calculated starting from the date of the fresh start.

## Import

SESv2 (Simple Email V2) Configuration Set can be imported using the `configurationSetName`, e.g.,

```console
$ terraform import aws_sesv2_configuration_set.example example
```
