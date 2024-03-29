---
# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    Type: MMv1     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in
#     .github/CONTRIBUTING.md.
#
# ----------------------------------------------------------------------------
subcategory: "Cloud Billing"
description: |-
  Budget configuration for a billing account.
---

# googleBillingBudget

Budget configuration for a billing account.

To get more information about Budget, see:

* [API documentation](https://cloud.google.com/billing/docs/reference/budget/rest/v1/billingAccounts.budgets)
* How-to Guides
  * [Creating a budget](https://cloud.google.com/billing/docs/how-to/budgets)

\~> **Warning:** If you are using User ADCs (Application Default Credentials) with this resource,
you must specify a `billingProject` and set `userProjectOverride` to true
in the provider configuration. Otherwise the Billing Budgets API will return a 403 error.
Your account must have the `serviceusageServicesUse` permission on the
`billingProject` you defined.

## Example Usage - Billing Budget Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleBillingAccountAccount =
  new google.dataGoogleBillingAccount.DataGoogleBillingAccount(
    this,
    "account",
    {
      billing_account: "000000-0000000-0000000-000000",
    }
  );
new google.billingBudget.BillingBudget(this, "budget", {
  amount: [
    {
      specified_amount: [
        {
          currency_code: "USD",
          units: "100000",
        },
      ],
    },
  ],
  billing_account: dataGoogleBillingAccountAccount.id,
  display_name: "Example Billing Budget",
  threshold_rules: [
    {
      threshold_percent: 0.5,
    },
  ],
});

```

## Example Usage - Billing Budget Lastperiod

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleBillingAccountAccount =
  new google.dataGoogleBillingAccount.DataGoogleBillingAccount(
    this,
    "account",
    {
      billing_account: "000000-0000000-0000000-000000",
    }
  );
const dataGoogleProjectProject = new google.dataGoogleProject.DataGoogleProject(
  this,
  "project",
  {}
);
new google.billingBudget.BillingBudget(this, "budget", {
  amount: [
    {
      last_period_amount: true,
    },
  ],
  billing_account: dataGoogleBillingAccountAccount.id,
  budget_filter: [
    {
      projects: [`projects/\${${dataGoogleProjectProject.number}}`],
    },
  ],
  display_name: "Example Billing Budget",
  threshold_rules: [
    {
      threshold_percent: 10,
    },
  ],
});

```

## Example Usage - Billing Budget Filter

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleBillingAccountAccount =
  new google.dataGoogleBillingAccount.DataGoogleBillingAccount(
    this,
    "account",
    {
      billing_account: "000000-0000000-0000000-000000",
    }
  );
const dataGoogleProjectProject = new google.dataGoogleProject.DataGoogleProject(
  this,
  "project",
  {}
);
new google.billingBudget.BillingBudget(this, "budget", {
  amount: [
    {
      specified_amount: [
        {
          currency_code: "USD",
          units: "100000",
        },
      ],
    },
  ],
  billing_account: dataGoogleBillingAccountAccount.id,
  budget_filter: [
    {
      credit_types: ["PROMOTION", "FREE_TIER"],
      credit_types_treatment: "INCLUDE_SPECIFIED_CREDITS",
      projects: [`projects/\${${dataGoogleProjectProject.number}}`],
      services: ["services/24E6-581D-38E5"],
    },
  ],
  display_name: "Example Billing Budget",
  threshold_rules: [
    {
      threshold_percent: 0.5,
    },
    {
      spend_basis: "FORECASTED_SPEND",
      threshold_percent: 0.9,
    },
  ],
});

```

## Example Usage - Billing Budget Notify

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleMonitoringNotificationChannelNotificationChannel =
  new google.monitoringNotificationChannel.MonitoringNotificationChannel(
    this,
    "notification_channel",
    {
      display_name: "Example Notification Channel",
      labels: [
        {
          email_address: "address@example.com",
        },
      ],
      type: "email",
    }
  );
const dataGoogleBillingAccountAccount =
  new google.dataGoogleBillingAccount.DataGoogleBillingAccount(
    this,
    "account",
    {
      billing_account: "000000-0000000-0000000-000000",
    }
  );
const dataGoogleProjectProject = new google.dataGoogleProject.DataGoogleProject(
  this,
  "project",
  {}
);
new google.billingBudget.BillingBudget(this, "budget", {
  all_updates_rule: [
    {
      disable_default_iam_recipients: true,
      monitoring_notification_channels: [
        googleMonitoringNotificationChannelNotificationChannel.id,
      ],
    },
  ],
  amount: [
    {
      specified_amount: [
        {
          currency_code: "USD",
          units: "100000",
        },
      ],
    },
  ],
  billing_account: dataGoogleBillingAccountAccount.id,
  budget_filter: [
    {
      projects: [`projects/\${${dataGoogleProjectProject.number}}`],
    },
  ],
  display_name: "Example Billing Budget",
  threshold_rules: [
    {
      threshold_percent: 1,
    },
    {
      spend_basis: "FORECASTED_SPEND",
      threshold_percent: 1,
    },
  ],
});

```

## Example Usage - Billing Budget Customperiod

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const dataGoogleBillingAccountAccount =
  new google.dataGoogleBillingAccount.DataGoogleBillingAccount(
    this,
    "account",
    {
      billing_account: "000000-0000000-0000000-000000",
    }
  );
const dataGoogleProjectProject = new google.dataGoogleProject.DataGoogleProject(
  this,
  "project",
  {}
);
new google.billingBudget.BillingBudget(this, "budget", {
  amount: [
    {
      specified_amount: [
        {
          currency_code: "USD",
          units: "100000",
        },
      ],
    },
  ],
  billing_account: dataGoogleBillingAccountAccount.id,
  budget_filter: [
    {
      credit_types_treatment: "EXCLUDE_ALL_CREDITS",
      custom_period: [
        {
          end_date: [
            {
              day: 31,
              month: 12,
              year: 2023,
            },
          ],
          start_date: [
            {
              day: 1,
              month: 1,
              year: 2022,
            },
          ],
        },
      ],
      projects: [`projects/\${${dataGoogleProjectProject.number}}`],
      services: ["services/24E6-581D-38E5"],
    },
  ],
  display_name: "Example Billing Budget",
  threshold_rules: [
    {
      threshold_percent: 0.5,
    },
    {
      threshold_percent: 0.9,
    },
  ],
});

```

## Argument Reference

The following arguments are supported:

*   `amount` -
    (Required)
    The budgeted amount for each usage period.
    Structure is [documented below](#nested_amount).

*   `billingAccount` -
    (Required)
    ID of the billing account to set a budget on.

<a name="nested_amount"></a>The `amount` block supports:

*   `specifiedAmount` -
    (Optional)
    A specified amount to use as the budget. currencyCode is
    optional. If specified, it must match the currency of the
    billing account. The currencyCode is provided on output.
    Structure is [documented below](#nested_specified_amount).

*   `lastPeriodAmount` -
    (Optional)
    Configures a budget amount that is automatically set to 100% of
    last period's spend.
    Boolean. Set value to true to use. Do not set to false, instead
    use the `specifiedAmount` block.

<a name="nested_specified_amount"></a>The `specifiedAmount` block supports:

*   `currencyCode` -
    (Optional)
    The 3-letter currency code defined in ISO 4217.

*   `units` -
    (Optional)
    The whole units of the amount. For example if currencyCode
    is "USD", then 1 unit is one US dollar.

*   `nanos` -
    (Optional)
    Number of nano (10^-9) units of the amount.
    The value must be between -999,999,999 and +999,999,999
    inclusive. If units is positive, nanos must be positive or
    zero. If units is zero, nanos can be positive, zero, or
    negative. If units is negative, nanos must be negative or
    zero. For example $-1.75 is represented as units=-1 and
    nanos=-750,000,000.

***

*   `displayName` -
    (Optional)
    User data for display name in UI. Must be <= 60 chars.

*   `budgetFilter` -
    (Optional)
    Filters that define which resources are used to compute the actual
    spend against the budget.
    Structure is [documented below](#nested_budget_filter).

*   `thresholdRules` -
    (Optional)
    Rules that trigger alerts (notifications of thresholds being
    crossed) when spend exceeds the specified percentages of the
    budget.
    Structure is [documented below](#nested_threshold_rules).

*   `allUpdatesRule` -
    (Optional)
    Defines notifications that are sent on every update to the
    billing account's spend, regardless of the thresholds defined
    using threshold rules.
    Structure is [documented below](#nested_all_updates_rule).

<a name="nested_budget_filter"></a>The `budgetFilter` block supports:

*   `projects` -
    (Optional)
    A set of projects of the form projects/{project\_number},
    specifying that usage from only this set of projects should be
    included in the budget. If omitted, the report will include
    all usage for the billing account, regardless of which project
    the usage occurred on.

*   `creditTypesTreatment` -
    (Optional)
    Specifies how credits should be treated when determining spend
    for threshold calculations.
    Default value is `includeAllCredits`.
    Possible values are `includeAllCredits`, `excludeAllCredits`, and `includeSpecifiedCredits`.

*   `services` -
    (Optional)
    A set of services of the form services/{service\_id},
    specifying that usage from only this set of services should be
    included in the budget. If omitted, the report will include
    usage for all the services. The service names are available
    through the Catalog API:
    https://cloud.google.com/billing/v1/how-tos/catalog-api.

*   `creditTypes` -
    (Optional)
    Optional. If creditTypesTreatment is INCLUDE\_SPECIFIED\_CREDITS,
    this is a list of credit types to be subtracted from gross cost to determine the spend for threshold calculations. See a list of acceptable credit type values.
    If creditTypesTreatment is not INCLUDE\_SPECIFIED\_CREDITS, this field must be empty.
    **Note:** If the field has a value in the config and needs to be removed, the field has to be an emtpy array in the config.

*   `subaccounts` -
    (Optional)
    A set of subaccounts of the form billingAccounts/{account\_id},
    specifying that usage from only this set of subaccounts should
    be included in the budget. If a subaccount is set to the name of
    the parent account, usage from the parent account will be included.
    If the field is omitted, the report will include usage from the parent
    account and all subaccounts, if they exist.
    **Note:** If the field has a value in the config and needs to be removed, the field has to be an emtpy array in the config.

*   `labels` -
    (Optional)
    A single label and value pair specifying that usage from only
    this set of labeled resources should be included in the budget.

*   `calendarPeriod` -
    (Optional)
    A CalendarPeriod represents the abstract concept of a recurring time period that has a
    canonical start. Grammatically, "the start of the current CalendarPeriod".
    All calendar times begin at 12 AM US and Canadian Pacific Time (UTC-8).
    Exactly one of `calendarPeriod`, `customPeriod` must be provided.
    Possible values are `month`, `quarter`, `year`, and `calendarPeriodUnspecified`.

*   `customPeriod` -
    (Optional)
    Specifies to track usage from any start date (required) to any end date (optional).
    This time period is static, it does not recur.
    Exactly one of `calendarPeriod`, `customPeriod` must be provided.
    Structure is [documented below](#nested_custom_period).

<a name="nested_custom_period"></a>The `customPeriod` block supports:

*   `startDate` -
    (Required)
    A start date is required. The start date must be after January 1, 2017.
    Structure is [documented below](#nested_start_date).

*   `endDate` -
    (Optional)
    Optional. The end date of the time period. Budgets with elapsed end date won't be processed.
    If unset, specifies to track all usage incurred since the startDate.
    Structure is [documented below](#nested_end_date).

<a name="nested_start_date"></a>The `startDate` block supports:

*   `year` -
    (Required)
    Year of the date. Must be from 1 to 9999.

*   `month` -
    (Required)
    Month of a year. Must be from 1 to 12.

*   `day` -
    (Required)
    Day of a month. Must be from 1 to 31 and valid for the year and month.

<a name="nested_end_date"></a>The `endDate` block supports:

*   `year` -
    (Required)
    Year of the date. Must be from 1 to 9999.

*   `month` -
    (Required)
    Month of a year. Must be from 1 to 12.

*   `day` -
    (Required)
    Day of a month. Must be from 1 to 31 and valid for the year and month.

<a name="nested_threshold_rules"></a>The `thresholdRules` block supports:

*   `thresholdPercent` -
    (Required)
    Send an alert when this threshold is exceeded. This is a
    1.0-based percentage, so 0.5 = 50%. Must be >= 0.

*   `spendBasis` -
    (Optional)
    The type of basis used to determine if spend has passed
    the threshold.
    Default value is `currentSpend`.
    Possible values are `currentSpend` and `forecastedSpend`.

<a name="nested_all_updates_rule"></a>The `allUpdatesRule` block supports:

*   `pubsubTopic` -
    (Optional)
    The name of the Cloud Pub/Sub topic where budget related
    messages will be published, in the form
    projects/{project\_id}/topics/{topic\_id}. Updates are sent
    at regular intervals to the topic.

*   `schemaVersion` -
    (Optional)
    The schema version of the notification. Only "1.0" is
    accepted. It represents the JSON schema as defined in
    https://cloud.google.com/billing/docs/how-to/budgets#notification\_format.

*   `monitoringNotificationChannels` -
    (Optional)
    The full resource name of a monitoring notification
    channel in the form
    projects/{project\_id}/notificationChannels/{channel\_id}.
    A maximum of 5 channels are allowed.

*   `disableDefaultIamRecipients` -
    (Optional)
    Boolean. When set to true, disables default notifications sent
    when a threshold is exceeded. Default recipients are
    those with Billing Account Administrators and Billing
    Account Users IAM roles for the target account.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `billingAccounts/{{billingAccount}}/budgets/{{name}}`

*   `name` -
    Resource name of the budget. The resource name
    implies the scope of a budget. Values are of the form
    billingAccounts/{billingAccountId}/budgets/{budgetId}.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `update` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

Budget can be imported using any of these accepted formats:

```console
$ terraform import google_billing_budget.default billingAccounts/{{billing_account}}/budgets/{{name}}
$ terraform import google_billing_budget.default {{billing_account}}/{{name}}
$ terraform import google_billing_budget.default {{name}}
```
