---
subcategory: "ElastiCache"
layout: "aws"
page_title: "AWS: aws_elasticache_user"
description: |-
  Provides an ElastiCache user.
---

# Resource: awsElasticacheUser

Provides an ElastiCache user resource.

\~> **Note:** All arguments including the username and passwords will be stored in the raw state as plain-text.
[Read more about sensitive data in state](https://www.terraform.io/docs/state/sensitive-data.html).

## Example Usage

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.elasticacheUser.ElasticacheUser(this, "test", {
  accessString:
    "on ~app::* -@all +@read +@hash +@bitmap +@geo -setbit -bitfield -hset -hsetnx -hmset -hincrby -hincrbyfloat -hdel -bitop -geoadd -georadius -georadiusbymember",
  engine: "REDIS",
  passwords: ["password123456789"],
  userId: "testUserId",
  userName: "testUserName",
});

```

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.elasticacheUser.ElasticacheUser(this, "test", {
  accessString: "on ~* +@all",
  authenticationMode: {
    type: "iam",
  },
  engine: "REDIS",
  userId: "testUserId",
  userName: "testUserName",
});

```

```typescript
/*Provider bindings are generated by running cdktf get.
See https://cdk.tf/provider-generation for more details.*/
import * as aws from "./.gen/providers/aws";
new aws.elasticacheUser.ElasticacheUser(this, "test", {
  accessString: "on ~* +@all",
  authenticationMode: {
    passwords: ["password1", "password2"],
    type: "password",
  },
  engine: "REDIS",
  userId: "testUserId",
  userName: "testUserName",
});

```

## Argument Reference

The following arguments are required:

* `accessString` - (Required) Access permissions string used for this user. See [Specifying Permissions Using an Access String](https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/Clusters.RBAC.html#Access-string) for more details.
* `engine` - (Required) The current supported value is `redis`.
* `userId` - (Required) The ID of the user.
* `userName` - (Required) The username of the user.

The following arguments are optional:

* `authenticationMode` - (Optional) Denotes the user's authentication properties. Detailed below.
* `noPasswordRequired` - (Optional) Indicates a password is not required for this user.
* `passwords` - (Optional) Passwords used for this user. You can create up to two passwords for each user.
* `tags` - (Optional) A list of tags to be added to this resource. A tag is a key-value pair.

### authentication\_mode Configuration Block

* `passwords` - (Optional) Specifies the passwords to use for authentication if `type` is set to `password`.
* `type` - (Required) Specifies the authentication type. Possible options are: `password`, `noPasswordRequired` or `iam`.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `arn` - The ARN of the created ElastiCache User.

## Import

ElastiCache users can be imported using the `userId`, e.g.,

```console
$ terraform import aws_elasticache_user.my_user userId1
```
