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
subcategory: "Cloud Security Scanner"
description: |-
  A ScanConfig resource contains the configurations to launch a scan.
---

# googleSecurityScannerScanConfig

A ScanConfig resource contains the configurations to launch a scan.

\~> **Warning:** This resource is in beta, and should be used with the terraform-provider-google-beta provider.
See [Provider Versions](https://terraform.io/docs/providers/google/guides/provider_versions.html) for more details on beta resources.

To get more information about ScanConfig, see:

* [API documentation](https://cloud.google.com/security-scanner/docs/reference/rest/v1beta/projects.scanConfigs)
* How-to Guides
  * [Using Cloud Security Scanner](https://cloud.google.com/security-scanner/docs/scanning)

\~> **Warning:** All arguments including `authenticationGoogleAccountPassword` and `authenticationCustomAccountPassword` will be stored in the raw
state as plain-text. [Read more about sensitive data in state](https://www.terraform.io/language/state/sensitive-data).

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=scan_config_basic&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Scan Config Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleComputeAddressScannerStaticIp =
  new google.computeAddress.ComputeAddress(this, "scanner_static_ip", {
    name: "scan-basic-static-ip",
    provider: "${google-beta}",
  });
new google.securityScannerScanConfig.SecurityScannerScanConfig(
  this,
  "scan-config",
  {
    display_name: "terraform-scan-config",
    provider: "${google-beta}",
    starting_urls: [
      `http://\${${googleComputeAddressScannerStaticIp.address}}`,
    ],
    target_platforms: ["COMPUTE"],
  }
);

```

## Argument Reference

The following arguments are supported:

*   `displayName` -
    (Required)
    The user provider display name of the ScanConfig.

*   `startingUrls` -
    (Required)
    The starting URLs from which the scanner finds site pages.

***

*   `maxQps` -
    (Optional)
    The maximum QPS during scanning. A valid value ranges from 5 to 20 inclusively.
    Defaults to 15.

*   `authentication` -
    (Optional)
    The authentication configuration.
    If specified, service will use the authentication configuration during scanning.
    Structure is [documented below](#nested_authentication).

*   `userAgent` -
    (Optional)
    Type of the user agents used for scanning
    Default value is `chromeLinux`.
    Possible values are `userAgentUnspecified`, `chromeLinux`, `chromeAndroid`, and `safariIphone`.

*   `blacklistPatterns` -
    (Optional)
    The blacklist URL patterns as described in
    https://cloud.google.com/security-scanner/docs/excluded-urls

*   `schedule` -
    (Optional)
    The schedule of the ScanConfig
    Structure is [documented below](#nested_schedule).

*   `targetPlatforms` -
    (Optional)
    Set of Cloud Platforms targeted by the scan. If empty, APP\_ENGINE will be used as a default.
    Each value may be one of `appEngine` and `compute`.

*   `exportToSecurityCommandCenter` -
    (Optional)
    Controls export of scan configurations and results to Cloud Security Command Center.
    Default value is `enabled`.
    Possible values are `enabled` and `disabled`.

*   `project` - (Optional) The ID of the project in which the resource belongs.
    If it is not provided, the provider project is used.

<a name="nested_authentication"></a>The `authentication` block supports:

*   `googleAccount` -
    (Optional)
    Describes authentication configuration that uses a Google account.
    Structure is [documented below](#nested_google_account).

*   `customAccount` -
    (Optional)
    Describes authentication configuration that uses a custom account.
    Structure is [documented below](#nested_custom_account).

<a name="nested_google_account"></a>The `googleAccount` block supports:

*   `username` -
    (Required)
    The user name of the Google account.

*   `password` -
    (Required)
    The password of the Google account. The credential is stored encrypted
    in GCP.
    **Note**: This property is sensitive and will not be displayed in the plan.

<a name="nested_custom_account"></a>The `customAccount` block supports:

*   `username` -
    (Required)
    The user name of the custom account.

*   `password` -
    (Required)
    The password of the custom account. The credential is stored encrypted
    in GCP.
    **Note**: This property is sensitive and will not be displayed in the plan.

*   `loginUrl` -
    (Required)
    The login form URL of the website.

<a name="nested_schedule"></a>The `schedule` block supports:

*   `scheduleTime` -
    (Optional)
    A timestamp indicates when the next run will be scheduled. The value is refreshed
    by the server after each run. If unspecified, it will default to current server time,
    which means the scan will be scheduled to start immediately.

*   `intervalDurationDays` -
    (Required)
    The duration of time between executions in days

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `{{name}}`

*   `name` -
    A server defined name for this index. Format:
    `projects/{{project}}/scanConfigs/{{serverGeneratedId}}`

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `update` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

ScanConfig can be imported using any of these accepted formats:

```console
$ terraform import google_security_scanner_scan_config.default projects/{{project}}/scanConfigs/{{name}}
$ terraform import google_security_scanner_scan_config.default {{project}}/{{name}}
$ terraform import google_security_scanner_scan_config.default {{name}}
```

## User Project Overrides

This resource supports [User Project Overrides](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override).
