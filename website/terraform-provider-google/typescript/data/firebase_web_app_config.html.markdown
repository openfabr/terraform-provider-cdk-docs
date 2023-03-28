---
subcategory: "Firebase"
description: |-
  A Google Cloud Firebase web application configuration
---

# googleFirebaseWebAppConfig

A Google Cloud Firebase web application configuration

\~> **Warning:** This resource is in beta, and should be used with the terraform-provider-google-beta provider.
See [Provider Versions](https://terraform.io/docs/providers/google/guides/provider_versions.html) for more details on beta resources.

To get more information about WebApp, see:

* [API documentation](https://firebase.google.com/docs/projects/api/reference/rest/v1beta1/projects.webApps)
* How-to Guides
  * [Official Documentation](https://firebase.google.com/)

## Argument Reference

The following arguments are supported:

* `webAppId` - (Required) the id of the firebase web app

***

* `project` - (Optional) The ID of the project in which the resource belongs. If it
  is not provided, the provider project is used.

## Attributes Reference

In addition to the arguments listed above, the following attributes are exported:

*   `apiKey` -
    The API key associated with the web App.

*   `authDomain` -
    The domain Firebase Auth configures for OAuth redirects, in the format:
    projectId.firebaseapp.com

*   `databaseUrl` -
    The default Firebase Realtime Database URL.

*   `storageBucket` -
    The default Cloud Storage for Firebase storage bucket name.

*   `locationId` -
    The ID of the project's default GCP resource location. The location is one of the available GCP resource
    locations.
    This field is omitted if the default GCP resource location has not been finalized yet. To set your project's
    default GCP resource location, call defaultLocation.finalize after you add Firebase services to your project.

*   `messagingSenderId` -
    The sender ID for use with Firebase Cloud Messaging.

*   `measurementId` -
    The unique Google-assigned identifier of the Google Analytics web stream associated with the Firebase Web App.
    Firebase SDKs use this ID to interact with Google Analytics APIs.
    This field is only present if the App is linked to a web stream in a Google Analytics App + Web property.
    Learn more about this ID and Google Analytics web streams in the Analytics documentation.
    To generate a measurementId and link the Web App with a Google Analytics web stream,
    call projects.addGoogleAnalytics.
