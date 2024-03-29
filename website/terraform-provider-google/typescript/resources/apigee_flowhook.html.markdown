---
subcategory: "Apigee"
description: |-
  Represents a sharedflow attachment to a flowhook point.
---

# googleApigeeFlowhook

Represents a sharedflow attachment to a flowhook point.

To get more information about Flowhook, see:

* [API documentation](https://cloud.google.com/apigee/docs/reference/apis/apigee/rest/v1/organizations.environments.flowhooks#FlowHook)
* How-to Guides
  * [organizations.environments.flowhooks](https://cloud.google.com/apigee/docs/reference/apis/apigee/rest/v1/organizations.environments.flowhooks#FlowHook)

## Argument Reference

The following arguments are supported:

*   `orgId` -
    (Required)
    The Apigee Organization associated with the environment

*   `environment` -
    (Required)
    The resource ID of the environment.

*   `flowHookPoint` -
    (Required)
    Where in the API call flow the flow hook is invoked. Must be one of PreProxyFlowHook, PostProxyFlowHook, PreTargetFlowHook, or PostTargetFlowHook.

*   `description` -
    (Optional)
    Description of the flow hook.

*   `sharedflow` -
    (Required)
    Id of the Sharedflow attaching to a flowhook point.

*   `continueOnError` -
    (Optional)
    Flag that specifies whether execution should continue if the flow hook throws an exception. Set to true to continue execution. Set to false to stop execution if the flow hook throws an exception. Defaults to true.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

* `id` - an identifier for the resource with format `organizations/{{orgId}}/environments/{{environment}}/flowhooks/{{flowHookPoint}}`

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

Flowhook can be imported using any of these accepted formats:

```console
$ terraform import google_apigee_flowhook.default organizations/{{org_id}}/environments/{{environment}}/flowhooks/{{flow_hook_point}}
$ terraform import google_apigee_flowhook.default {{org_id}}/{{environment}}/{{flow_hook_point}}
```
