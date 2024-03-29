---
subcategory: "Lex Model Building"
layout: "aws"
page_title: "AWS: aws_lex_bot_alias"
description: |-
  Provides details about a specific Lex Bot Alias
---

# Data Source: awsLexBotAlias

Provides details about a specific Amazon Lex Bot Alias.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsLexBotAlias.DataAwsLexBotAlias(this, "order_flowers_prod", {
  botName: "OrderFlowers",
  name: "OrderFlowersProd",
});

```

## Argument Reference

The following arguments are supported:

* `botName` - (Required) Name of the bot.
* `name` - (Required) Name of the bot alias. The name is case sensitive.

## Attributes Reference

The following attributes are exported.

* `arn` - ARN of the bot alias.
* `botName` - Name of the bot.
* `botVersion` - Version of the bot that the alias points to.
* `checksum` - Checksum of the bot alias.
* `createdDate` - Date that the bot alias was created.
* `description` - Description of the alias.
* `lastUpdatedDate` - Date that the bot alias was updated. When you create a resource, the creation date and the last updated date are the same.
* `name` - Name of the alias. The name is not case sensitive.
