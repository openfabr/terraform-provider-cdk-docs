---
subcategory: "Secrets Manager"
layout: "aws"
page_title: "AWS: aws_secretsmanager_random_password"
description: |-
  Generate a random password
---

# Data Source: awsSecretsmanagerRandomPassword

Generate a random password.

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.dataAwsSecretsmanagerRandomPassword.DataAwsSecretsmanagerRandomPassword(
  this,
  "test",
  {
    excludeNumbers: true,
    passwordLength: 50,
  }
);

```

## Argument Reference

* `excludeCharacters` - (Optional) String of the characters that you don't want in the password.
* `excludeLowercase` - (Optional) Specifies whether to exclude lowercase letters from the password.
* `excludeNumbers` - (Optional) Specifies whether to exclude numbers from the password.
* `excludePunctuation` - (Optional) Specifies whether to exclude the following punctuation characters from the password: ``! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ .``
* `excludeUppercase` - (Optional) Specifies whether to exclude uppercase letters from the password.
* `includeSpace` - (Optional) Specifies whether to include the space character.
* `passwordLength` - (Optional) Length of the password.
* `requireEachIncludedType` - (Optional) Specifies whether to include at least one upper and lowercase letter, one number, and one punctuation.

## Attributes Reference

* `randomPassword` - Random password.
