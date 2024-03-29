---
subcategory: "GuardDuty"
layout: "aws"
page_title: "AWS: aws_guardduty_member"
description: |-
  Provides a resource to manage a GuardDuty member
---

# Resource: awsGuarddutyMember

Provides a resource to manage a GuardDuty member. To accept invitations in member accounts, see the [`awsGuarddutyInviteAccepter` resource](/docs/providers/aws/r/guardduty_invite_accepter.html).

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
const awsGuarddutyDetectorMember = new aws.guarddutyDetector.GuarddutyDetector(
  this,
  "member",
  {
    enable: true,
    provider: "${aws.dev}",
  }
);
const awsGuarddutyDetectorPrimary = new aws.guarddutyDetector.GuarddutyDetector(
  this,
  "primary",
  {
    enable: true,
  }
);
const awsGuarddutyMemberMember = new aws.guarddutyMember.GuarddutyMember(
  this,
  "member_2",
  {
    accountId: awsGuarddutyDetectorMember.accountId,
    detectorId: awsGuarddutyDetectorPrimary.id,
    email: "required@example.com",
    invitationMessage: "please accept guardduty invitation",
    invite: true,
  }
);
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
awsGuarddutyMemberMember.overrideLogicalId("member");

```

## Argument Reference

The following arguments are supported:

* `accountId` - (Required) AWS account ID for member account.
* `detectorId` - (Required) The detector ID of the GuardDuty account where you want to create member accounts.
* `email` - (Required) Email address for member account.
* `invite` - (Optional) Boolean whether to invite the account to GuardDuty as a member. Defaults to `false`. To detect if an invitation needs to be (re-)sent, the Terraform state value is `true` based on a `relationshipStatus` of `disabled`, `enabled`, `invited`, or `emailVerificationInProgress`.
* `invitationMessage` - (Optional) Message for invitation.
* `disableEmailNotification` - (Optional) Boolean whether an email notification is sent to the accounts. Defaults to `false`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `id` - The ID of the GuardDuty member
* `relationshipStatus` - The status of the relationship between the member account and its primary account. More information can be found in [Amazon GuardDuty API Reference](https://docs.aws.amazon.com/guardduty/latest/ug/get-members.html).

## Timeouts

[Configuration options](https://developer.hashicorp.com/terraform/language/resources/syntax#operation-timeouts):

* `create` - (Default `1M`)
* `update` - (Default `1M`)

## Import

GuardDuty members can be imported using the primary GuardDuty detector ID and member AWS account ID, e.g.,

```console
$ terraform import aws_guardduty_member.MyMember 00b00fd5aecc0ab60a708659477e9617:123456789012
```
