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
subcategory: "Game Servers"
description: |-
  A game server config resource.
---

# googleGameServicesGameServerConfig

A game server config resource. Configs are global and immutable.

To get more information about GameServerConfig, see:

* [API documentation](https://cloud.google.com/game-servers/docs/reference/rest/v1beta/projects.locations.gameServerDeployments.configs)
* How-to Guides
  * [Official Documentation](https://cloud.google.com/game-servers/docs)

<div class = "oics-button" style="float: right; margin: 0 0 -15px">
  <a href="https://console.cloud.google.com/cloudshell/open?cloudshell_git_repo=https%3A%2F%2Fgithub.com%2Fterraform-google-modules%2Fdocs-examples.git&cloudshell_working_dir=game_service_config_basic&cloudshell_image=gcr.io%2Fgraphite-cloud-shell-images%2Fterraform%3Alatest&open_in_editor=main.tf&cloudshell_print=.%2Fmotd&cloudshell_tutorial=.%2Ftutorial.md" target="_blank">
    <img alt="Open in Cloud Shell" src="//gstatic.com/cloudssh/images/open-btn.svg" style="max-height: 44px; margin: 32px auto; max-width: 100%;">
  </a>
</div>
## Example Usage - Game Service Config Basic

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as google from "./.gen/providers/google";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: google.
For a more precise conversion please use the --provider flag in convert.*/
const googleGameServicesGameServerDeploymentDefault =
  new google.gameServicesGameServerDeployment.GameServicesGameServerDeployment(
    this,
    "default",
    {
      deployment_id: "tf-test-deployment",
      description: "a deployment description",
    }
  );
const googleGameServicesGameServerConfigDefault =
  new google.gameServicesGameServerConfig.GameServicesGameServerConfig(
    this,
    "default_1",
    {
      config_id: "tf-test-config",
      deployment_id: googleGameServicesGameServerDeploymentDefault.deploymentId,
      description: "a config description",
      fleet_configs: [
        {
          fleet_spec:
            '${jsonencode({ "replicas" : 1, "scheduling" : "Packed", "template" : { "metadata" : { "name" : "tf-test-game-server-template" }, "spec" : { "ports": [{"name": "default", "portPolicy": "Dynamic", "containerPort": 7654, "protocol": "UDP"}], "template" : { "spec" : { "containers" : [{ "name" : "simple-udp-server", "image" : "gcr.io/agones-images/udp-server:0.14" }] } } } } })}',
          name: "something-unique",
        },
      ],
      scaling_configs: [
        {
          fleet_autoscaler_spec:
            '${jsonencode({"policy": {"type": "Webhook","webhook": {"service": {"name": "autoscaler-webhook-service","namespace": "default","path": "scale"}}}})}',
          name: "scaling-config-name",
          schedules: [
            {
              cron_job_duration: "3.500s",
              cron_spec: "0 0 * * 0",
            },
          ],
          selectors: [
            {
              labels: [
                {
                  one: "two",
                },
              ],
            },
          ],
        },
      ],
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
googleGameServicesGameServerConfigDefault.overrideLogicalId("default");

```

## Argument Reference

The following arguments are supported:

*   `configId` -
    (Required)
    A unique id for the deployment config.

*   `deploymentId` -
    (Required)
    A unique id for the deployment.

*   `fleetConfigs` -
    (Required)
    The fleet config contains list of fleet specs. In the Single Cloud, there
    will be only one.
    Structure is [documented below](#nested_fleet_configs).

<a name="nested_fleet_configs"></a>The `fleetConfigs` block supports:

*   `fleetSpec` -
    (Required)
    The fleet spec, which is sent to Agones to configure fleet.
    The spec can be passed as inline json but it is recommended to use a file reference
    instead. File references can contain the json or yaml format of the fleet spec. Eg:
    * fleet\_spec = jsonencode(yamldecode(file("fleet\_configs.yaml")))
    * fleet\_spec = file("fleet\_configs.json")
      The format of the spec can be found :
      `https://agonesDev/site/docs/reference/fleet/`.

*   `name` -
    (Required)
    The name of the FleetConfig.

***

*   `location` -
    (Optional)
    Location of the Deployment.

*   `description` -
    (Optional)
    The description of the game server config.

*   `labels` -
    (Optional)
    The labels associated with this game server config. Each label is a
    key-value pair.

*   `scalingConfigs` -
    (Optional)
    Optional. This contains the autoscaling settings.
    Structure is [documented below](#nested_scaling_configs).

*   `project` - (Optional) The ID of the project in which the resource belongs.
    If it is not provided, the provider project is used.

<a name="nested_scaling_configs"></a>The `scalingConfigs` block supports:

*   `name` -
    (Required)
    The name of the ScalingConfig

*   `fleetAutoscalerSpec` -
    (Required)
    Fleet autoscaler spec, which is sent to Agones.
    Example spec can be found :
    https://agones.dev/site/docs/reference/fleetautoscaler/

*   `selectors` -
    (Optional)
    Labels used to identify the clusters to which this scaling config
    applies. A cluster is subject to this scaling config if its labels match
    any of the selector entries.
    Structure is [documented below](#nested_selectors).

*   `schedules` -
    (Optional)
    The schedules to which this scaling config applies.
    Structure is [documented below](#nested_schedules).

<a name="nested_selectors"></a>The `selectors` block supports:

* `labels` -
  (Optional)
  Set of labels to group by.

<a name="nested_schedules"></a>The `schedules` block supports:

*   `startTime` -
    (Optional)
    The start time of the event.
    A timestamp in RFC3339 UTC "Zulu" format, accurate to nanoseconds. Example: "2014-10-02T15:01:23.045123456Z".

*   `endTime` -
    (Optional)
    The end time of the event.
    A timestamp in RFC3339 UTC "Zulu" format, accurate to nanoseconds. Example: "2014-10-02T15:01:23.045123456Z".

*   `cronJobDuration` -
    (Optional)
    The duration for the cron job event. The duration of the event is effective
    after the cron job's start time.
    A duration in seconds with up to nine fractional digits, terminated by 's'. Example: "3.5s".

*   `cronSpec` -
    (Optional)
    The cron definition of the scheduled event. See
    https://en.wikipedia.org/wiki/Cron. Cron spec specifies the local time as
    defined by the realm.

## Attributes Reference

In addition to the arguments listed above, the following computed attributes are exported:

*   `id` - an identifier for the resource with format `projects/{{project}}/locations/{{location}}/gameServerDeployments/{{deploymentId}}/configs/{{configId}}`

*   `name` -
    The resource name of the game server config, in the form:
    `projects/{projectId}/locations/{location}/gameServerDeployments/{deploymentId}/configs/{configId}`.

## Timeouts

This resource provides the following
[Timeouts](https://developer.hashicorp.com/terraform/plugin/sdkv2/resources/retries-and-customizable-timeouts) configuration options:

* `create` - Default is 20 minutes.
* `delete` - Default is 20 minutes.

## Import

GameServerConfig can be imported using any of these accepted formats:

```console
$ terraform import google_game_services_game_server_config.default projects/{{project}}/locations/{{location}}/gameServerDeployments/{{deployment_id}}/configs/{{config_id}}
$ terraform import google_game_services_game_server_config.default {{project}}/{{location}}/{{deployment_id}}/{{config_id}}
$ terraform import google_game_services_game_server_config.default {{location}}/{{deployment_id}}/{{config_id}}
```

## User Project Overrides

This resource supports [User Project Overrides](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#user_project_override).
