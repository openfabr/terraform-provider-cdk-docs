---
subcategory: "Direct Connect"
layout: "aws"
page_title: "AWS: aws_dx_location"
description: |-
  Retrieve information about a specific AWS Direct Connect location in the current AWS Region.
---

# Data Source: aws\_dx\_location

Retrieve information about a specific AWS Direct Connect location in the current AWS Region.
These are the locations that can be specified when configuring [`awsDxConnection`](/docs/providers/aws/r/dx_connection.html) or [`awsDxLag`](/docs/providers/aws/r/dx_lag.html) resources.

\~> **Note:** This data source is different from the [`awsDxLocations`](/docs/providers/aws/d/dx_locations.html) data source which retrieves information about all the AWS Direct Connect locations in the current AWS Region.

## Example Usage

```hcl
data "aws_dx_location" "example" {
  location_code = "CS32A-24FL"
}
```

## Argument Reference

* `locationCode` - (Required) Code for the location to retrieve.

## Attributes Reference

In addition to all arguments above, the following attributes are exported:

* `availableMacsecPortSpeeds` - The available MAC Security (MACsec) port speeds for the location.
* `availablePortSpeeds` - The available port speeds for the location.
* `availableProviders` - Names of the service providers for the location.
* `locationName` - Name of the location. This includes the name of the colocation partner and the physical site of the building.
