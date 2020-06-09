## Matching a subscription to an application

To associate a subscription with an application, both the subscription and application must be in the same namespace so that the subscription can retrieve Helm charts, deployables, or other resources from a channel.

Within the application resource definition, the definition must include `spec.componentKinds` settings to indicate that the application uses a subscription. The definition must also include `spec.selector` settings to define the labels (`matchLabels`) or expressions (`matchExpressions`) to use to match the application with the subscription.

Within the subscription resource definition, the definition must include the required values to match the labels or expressions that are defined by the application.

When the subscription is associated with an application, the subscription uses the `spec.placement` settings for the subscription or deployable to deploy any subscribed charts, deployables or other Kubernetes resources for the application.

For more information about the resource definition for an application, see [Creating and managing application resources](managing_apps.md).