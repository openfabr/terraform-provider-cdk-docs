---
subcategory: "Bot"
layout: "azurerm"
page_title: "Azure Resource Manager: azurerm_bot_channel_slack"
description: |-
  Manages a Slack integration for a Bot Channel
---

# azurermBotChannelSlack

Manages a Slack integration for a Bot Channel

\~> **Note** A bot can only have a single Slack Channel associated with it.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as azurerm from "./.gen/providers/azurerm";
/*The following providers are missing schema information and might need manual adjustments to synthesize correctly: azurerm.
For a more precise conversion please use the --provider flag in convert.*/
const azurermResourceGroupExample = new azurerm.resourceGroup.ResourceGroup(
  this,
  "example",
  {
    location: "West Europe",
    name: "example-resources",
  }
);
const dataAzurermClientConfigCurrent =
  new azurerm.dataAzurermClientConfig.DataAzurermClientConfig(
    this,
    "current",
    {}
  );
const azurermBotChannelsRegistrationExample =
  new azurerm.botChannelsRegistration.BotChannelsRegistration(
    this,
    "example_2",
    {
      location: "global",
      microsoft_app_id: dataAzurermClientConfigCurrent.clientId,
      name: "example",
      resource_group_name: azurermResourceGroupExample.name,
      sku: "F0",
    }
  );
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermBotChannelsRegistrationExample.overrideLogicalId("example");
const azurermBotChannelSlackExample =
  new azurerm.botChannelSlack.BotChannelSlack(this, "example_3", {
    bot_name: azurermBotChannelsRegistrationExample.name,
    client_id: "exampleId",
    client_secret: "exampleSecret",
    location: azurermBotChannelsRegistrationExample.location,
    resource_group_name: azurermResourceGroupExample.name,
    verification_token: "exampleVerificationToken",
  });
/*This allows the Terraform resource name to match the original name. You can remove the call if you don't need them to match.*/
azurermBotChannelSlackExample.overrideLogicalId("example");

```

## Argument Reference

The following arguments are supported:

*   `resourceGroupName` - (Required) The name of the resource group in which to create the Bot Channel. Changing this forces a new resource to be created.

*   `location` - (Required) The supported Azure location where the resource exists. Changing this forces a new resource to be created.

*   `botName` - (Required) The name of the Bot Resource this channel will be associated with. Changing this forces a new resource to be created.

*   `clientId` - (Required) The Client ID that will be used to authenticate with Slack.

*   `clientSecret` - (Required) The Client Secret that will be used to authenticate with Slack.

*   `verificationToken` - (Required) The Verification Token that will be used to authenticate with Slack.

*   `landingPageUrl` - (Optional) The Slack Landing Page URL.

*   `signingSecret` - (Optional) The Signing Secret that will be used to sign the requests.

## Attributes Reference

The following attributes are exported:

* `id` - The ID of the Slack Integration for a Bot Channel.

## Timeouts

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

* `create` - (Defaults to 30 minutes) Used when creating the Slack Integration for a Bot Channel.
* `update` - (Defaults to 30 minutes) Used when updating the Slack Integration for a Bot Channel.
* `read` - (Defaults to 5 minutes) Used when retrieving the Slack Integration for a Bot Channel.
* `delete` - (Defaults to 30 minutes) Used when deleting the Slack Integration for a Bot Channel.

## Import

The Slack Integration for a Bot Channel can be imported using the `resourceId`, e.g.

```console
terraform import azurerm_bot_channel_slack.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/example/providers/Microsoft.BotService/botServices/example/channels/SlackChannel
```
