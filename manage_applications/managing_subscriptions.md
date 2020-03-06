---

copyright:
  years: 2019
lastupdated: "2019-12-12"

---

{:new_window: target="blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating and managing subscriptions

You can create and manage subscriptions to identify, retrieve, and deploy new and updated resources to managed clusters. By using subscriptions, you can improve the continuous delivery capabilities of your application management.
{:shortdesc}

Subscriptions (Subscription.app.ibm.com) are Kubernetes resources that serve as sets of definitions for identifying Kubernetes resources and Helm charts within channels by using annotations, labels, and versions.

Subscription resources can point to a channel for identifying new and updated Helm charts or Kubernetes resources for deployment. The subscription operator then watches the channel for new and updated charts and deployables. When a new or updated Helm chart or Kubernetes resource is detected, the subscription operator downloads the Helm release version for the specified Helm chart version or the specified Kubernetes resource. The subscription operator can download these objects directly, or as deployables, from the storage location to target managed clusters without checking the Hub cluster first.

Subscriptions can filter the deployables that are promoted to a channel to select specific deployables. For instance, the subscription can filter the deployables to select a specific deployable version. For this case, the subscription operator checks the `version` parameter to identify the deployable version to select.  

Subscriptions are defined with a `Subscription.app.ibm.com` custom resource definition (CRD)

For more information about deployables and other application resources, see [Application resources](app_resources.md).

  * [Create a subscription](#subscription_create)
  * [Matching a subscription to an application](#subscription_app)
  * [Update a subscription](#subscription_update)
  * [Delete a subscription](#subscription_delete)
  * [Schedule a subscription](#subscription_timewindow)
  * [View the subscription YAML definition](#subscription_compose)
  * [View an example subscription](#subscription_example)

## Creating a subscription
{: #subscription_create}

1. Compose the definition YAML content for your subscription. For more information about the YAML structure, including the required fields, see [Subscription definition](#subscription_compose).

2. Create the subscription within {{site.data.keyword.mcm_notm}}. You can use the console, the Kubernetes CLI (`kubectl`) tool, or REST API:  

   * To use the console:

     1. Open the console.
     2. From the Navigation menu, click **Manage applications**. The **Overview** tab for all applications opens.
     3. Click the **Resources** tab.
     4. Scroll to the _Resource pipeline_ section. From the list of buttons to the right of the resource summary cards, click **Susbcription**. The _Create a Susbcription_ editor is displayed.
     5. Enter the YAML content to define your subscription or directly update the default YAML template to meet your requirements.
     6. When you are finished, click **Save** to create the subscription. Your new subscription displays within the __Resource pipeline__ for the corresponding applications and channels.

     Alternatively, you can select to create a subscription when you are working with a specific application.

     1. From the __Overview__ tab for all applications, click the application from the __All applications__ list. The __Overview__ tab for that application opens.
     2. Click the **Resources** tab for that application.
     3. Scroll to the _Resource pipeline_ section. From the list of buttons to the right of the resource summary cards, click **Susbcription**. The _Create a Susbcription_ editor is displayed.
     4. Enter the YAML content to define your subscription or directly update the default YAML template to meet your requirements.
     5. When you are finished, click **Save** to create the subscription. Your new subscription displays within the __Resource pipeline__ for the corresponding applications and channels.

     **Note:** The subscription might not initially display in your resource pipeline for any application. For the subscription to be associated with an application, you need to include the appropriate values in your subscription definition to match the required values that are defined by the application definition. For more information, see [Matching a subscription to an application](#subscription_app).

   * To use the Kubernetes CLI tool:

     1. Run the following command to apply your file to an apiserver. Replace `filename` with the name of your file:

        ```
        kubectl apply -f filename.yaml
        ```
        {: codeblock}

     2. Verify that your subscription resource is created, by running the following command:

        ```
        kubectl get Subscription
        ```
        {: codeblock}

        Ensure that your new subscription is listed in the resulting output.

   * To use REST API, you need to use the [subscription POST API](../../apis/mcm/subscriptions.json).

After your subscription is created, your subscription can have one of the following statuses:

* `Subscribed` (managed clusters only)
  The subscription has successfully subscribed to the specified resources and the resources are deployed.
* `Propagated` (hub cluster only)
  The subsequent subscriptions based on your specified `spec.placement` setting are generated for deployment to the appropriate managed clusters, if any. However, the subscriptions might not actually be deployed.
* `Failed`
  The subscription failed to subscribe to the specified resources.
* No status
  The subscription operator is either not online, or the `spec.placement` setting for the subscription is missing.

If you created the subscription for a multi-cluster environment, the subscription is created on the Hub cluster. Depending on your `spec.placement` settings, the subsequent placement of your subscription on other clusters is different. If you include more than one placement setting within the `spec.placement` section, the subscription operator uses the following priority to select the placement setting to use:
  
* `spec.placement.placementRef`

  The subscription is placed on the clusters that are identified by the specified `PlacementRule` resource.

* `spec.placement.clusters`

  The subscription is placed on the clusters that are specified as the value for this field.

* `spec.placement.clusterSelector`

  The subscription is placed on the clusters that match the specified label selector that is defined as the value for this field.

If you created your subscription on a stand-alone cluster or a cluster that you want to manage directly, the subscription is created on only that cluster. Depending on the value that you set for the `spec.placement.local` field within the subscription definition, the subsequent behavior of your subscription is different.

* `true`

  The subscription synchronizes with the specified channel that is local to that cluster.

* `false`

  The subscription does not subscribe to any resources from the specified channel.

## Matching a subscription to an application
{: #subscription_app}

To associate a subscription with an application, both the subscription and application must be in the same namespace so that the subscription can retrieve Helm charts, deployables, or other resources from a channel.

Within the application resource definition, the definition must include `spec.componentKinds` settings to indicate that the application uses a subscription. The definition must also include `spec.selector` settings to define the labels (`matchLabels`) or expressions (`matchExpressions`) to use to match the application with the subscription.

Within the subscription resource definition, the definition must include the required values to match the labels or expressions that are defined by the application.

When the subscription is associated with an application, the subscription uses the `spec.placement` settings for the subscription or deployable to deploy any subscribed charts, deployables or other Kubernetes resources for the application.

For more information about the resource definition for an application, see [Creating and managing applications](managing_apps.md).

## Updating a subscription
{: #subscription_update}

1. Compose the definition YAML content for your subscription. For more information about the YAML structure, including the required fields, see [Subscription definition](#subscription_compose.md).

2. Create the subscription within {{site.data.keyword.mcm_notm}}. You can use the console, the Kubernetes CLI (`kubectl`) tool, or REST API:  

   * To use the console:
       1. Open the console.
       2. From the Navigation menu, click **Manage applications**. The **Overview** tab for all applications opens.
       3. Click the **Resources** tab.
       4. Scroll down the page to **Resource pipeline** section. Expand the row for the application that uses the subscription that you want to edit.
       5. For the subscription that you want to update, click the **Edit** icon for the YAML. The __Edit subscription__ window opens.
       6. Edit the YAML.
       7. When you are finished, click **Save** to update the subscription.

     Alternatively, you can select to update the subscription when you are working with a specific application.

       1. From the __Overview__ tab for all applications, click the application from the __All applications__ list. The __Overview__ tab for that application opens.
       2. Click the **Resources** tab for that application.
       3. Scroll down the page to **Resource pipeline** section.
       4. For the subscription that you want to update, click the **Edit** icon for the YAML. The __Edit subscription__ window opens.
       5. Edit the YAML.
       6. When you are finished, click **Save** to update the subscription.

     You can also use the console search to find and edit a subscription:

       1. Click the **Search** icon in the Header.  
       2. Within the search box, filter by `kind:subscription` to view all subscriptions.
       3. Within the list of all subscriptions, click the subscription that you want to update. The YAML for the subscription is displayed.
       4. Click **Edit** to enable editing the YAML content.
       5. When you are finished your edits, click **Save**. Your changes are saved and applied automatically.

   * To use the Kubernetes CLI tool, the steps are the same as for creating a subscription.

   * To use REST API, use the [subscription PATCH API](../../apis/mcm/subscriptions.json).

## Scheduling resource deployments for a subscription
{: #subscription_timewindow}

If you need to deploy new or changed Helm charts, deployables, or other Kubernetes resources during only specific times, you can define subscriptions for those resources to begin deployments during only those specific times. For instance, you can define time windows between 10:00 PM and 11:00 PM each Friday to serve as scheduled maintenance windows for applying patches or other application updates to your clusters.

Alternatively, you can restrict or block deployments from beginning during specific time windows, such as to avoid unexpected deployments during peak business hours. For instance, to avoid peak hours you can define a time window for a subscription to avoid beginning deployments between 8:00 AM and 8:00 PM.

By defining time windows for your subscriptions, you can coordinate updates for all of your applications and clusters. For instance, you can define subscriptions to deploy only new application resources between 6:01 PM and 11:59 PM and define other subscriptions to deploy only updated versions of existing resources between 12:00 AM to 7:59 AM.

When a time window is defined for a subscription, the time ranges when a subscription is active changes. As part of defining a time window, you can define the subscription to be active or blocked during that window. The deployment of new or changed resources begins only when the subscription is active. Regardless of whether a subscription is active or blocked, the subscription continues to monitor for any new or changed resource. The active and blocked setting affects only deployments.

When a new or changed resource is detected, the time window definition determines the next action for the subscription.

* For subscriptions to `HelmRepo`, `ObjectBucket`, and `GitHub` type channels:
  * If the resource is detected during the time range when the subscription is active, the resource deployment begins.
  * If the resource is detected outside the time range when the subscription is blocked from running deployments, the request to deploy the resource is cached. When the next time range that the subscription is active occurs, the cached requests are applied and any related deployments begin.
* For subscriptions to `Namespace` type channels:
  * When a subscription becomes active, the subscription synchronizes with the channel and begins the deployment for the latest version of any resources that need to be deployed.  
  * When the subscription is blocked, the subscription is not synchronized with the channel for deploying resources.

If a deployment begins during a defined time window and is running when the defined end of the time window elapses, the deployment continues to run to completion.

To define a time window for a subscription, you need to add the required fields and values to the subscription resource definition YAML.

* As part of defining a time window, you can define the days and hours for the time window.
* You can also define the time window type, which determines whether the time window when deployments can begin occurs during, or outside, the defined timeframe.
  * If the time window type is `active`, deployments can begin only during the defined timeframe. You can use this setting when you want deployments to occur within only specific maintenance windows.
  * If the time window type is `block`, deployments cannot begin during the defined timeframe, but can begin at any other time. You can use this setting when you have critical updates that are required, but still need to avoid deployments during specific time ranges. For instance, you can use this type to define a time window to allow security-related updates to be applied at any time except between 10:00 AM and 2:00 PM.
* You can define multiple time windows for a subscription, such as to define a time window every Monday and Wednesday.  

## Deleting subscriptions
{: #subscription_delete}

To delete a subscription, you can use the console, the Kubernetes command line interface (`kubectl`) tool, or REST API.  

* To use the console, use the console search to find and delete a subscription:

   1. Open the console.
   2. Click the **Search** icon in the Header.  
   3. Within the search box, filter by `kind:subscription` to view all subscriptions.
   4. Within the list of all subscriptions, expand the _Options_ menu for the subscription that you want to delete. Click **Delete subscription**.
   5. When the list of all subscriptions is refreshed, the subscription is no longer displayed.

* To use the Kubernetes CLI tool:

  1. Run the following command to delete the subscription from a target namespace. Replace `name` and `namespace` with the name of your subscription and your target namespace:

     ```
     kubectl delete Subscription <name> -n <namespace>
     ```
     {: codeblock}

  2. Verify that your subscription is deleted by running the following command:

     ```
     kubectl get Subscription <name>
     ```
     {: codeblock}

* To use REST API, use the [subscription DELETE API](../../apis/mcm/subscriptions.json).

## Subscription definition YAML structure
{: #subscription_compose}

The following YAML structure shows the required fields for a subscription and some of the common optional fields. Your YAML structure needs to include some required fields and values. Depending on your application management requirements, you might need to include other optional fields and values. You can compose your own YAML content with any tool.

```yaml
apiVersion: app.ibm.com/v1alpha1
kind: Subscription
metadata:
  name:
  namespace:
  labels:
spec:
  sourceNamespace:
  source:
  channel:
  name:
  packageFilter:
    version:  
    labelSelector:
      matchLabels:  
        package:
        component:
    annotations:  
  packageOverrides:
  - packageName:
    packageOverrides:
    - path:
      value:
  placement:
    local:
    clusters:
      name:
    clusterSelector:
    placementRef:
      name:
      kind: PlacementRule
  overrides:
    clusterName:
    clusterOverrides:
      path:
      value:
  timeWindow:
    type:
    location:
    weekdays:
    hours:
      - start:
        end:
```
{: codeblock}

|Field|Description|
|-- | -- |
| apiVersion | Required. Set the value to `app.ibm.com/v1alpha1`. |
| kind | Required. Set the value to `Subscription` to indicate that the resource is a subscription. |
| metadata.name | Required. The name for identifying the subscription. |
| metadata.namespace | Required. The namespace resource to use for the subscription. |
| metadata.labels | Optional. The labels for the subscription. |
| spec.channel | Optional. The NamespaceName ("Namespace/Name") that defines the channel for the subscription. Define either the `channel`, or the `source`, or the `sourceNamespace` field. In general, use the `channel` field to point to the channel instead of using the `source` or `sourceNamespace` fields. If more than one field is defined, the first field that is defined is used. |
| spec.sourceNamespace | Optional. The source namespace where deployables are stored on the Hub cluster. Use this field only for namespace channels. Define either the `channel`, or the `source`, or the `sourceNamespace` field. In general, use the `channel` field to point to the channel instead of using the `source` or `sourceNamespace` fields. |
| spec.source | Optional. The path name ("URL") to the Helm repository where deployables are stored. Use this field for only Helm repository channels. Define either the `channel`, or the `source`, or the `sourceNamespace` field. In general, use the `channel` field to point to the channel instead of using the `source` or `sourceNamespace` fields. |
| spec.name | Required for `HelmRepo` type channels, but optional for `Namespace` and `ObjectBucket` type channels. The specific name for the target Helm chart or deployable within the channel. If neither the `name` or `packageFilter` are defined for channel types where the field is optional, all deployables are found and the latest version of each deployable is retrieved. |
| spec.packageFilter | Optional. Defines the parameters to use to find target deployables or a subset of a deployables. If multiple filter conditions are defined, a deployable must meet all filter conditions. |
| spec.packageFilter.version | Optional. The version or versions for the deployable. You can use a range of versions in the form `>1.0`, or `<3.0`. By default, the version with the most recent "creationTimestamp" value is used. |
| spec.packageFilter.annotations | Optional. The annotations for the deployable. |
| spec.packageOverrides | Optional. Section for defining overrides for the Kubernetes resource that is subscribed to by the subscription, such as a Helm chart, deployable, or other Kubernetes resource within a channel. |
| spec.packageOverrides.packageName | Optional, but required for setting an override. Identifies the Kubernetes resource that is being overwritten. |  
| spec.packageOverrides.packageOverrides | Optional, but required for setting an override. The configuration of parameters and replacement values to use to override the Kubernetes resource. For more information, see [Package overrides](#package_overrides). |  
| spec.placement | Required. Identifies the subscribing clusters where deployables need to be placed, or the placement rule that defines the clusters. Use the placement configuration to define values for multi-cluster deployments. |
| spec.local | Optional, but required for a stand-alone cluster or cluster that you want to manage directly. Defines whether the subscription must be deployed locally. Set the value to `true` to have the subscription synchronize with the specified channel. Set the value to `false` to prevent the subscription from subscribing to any resources from the specified channel. Use this field when your cluster is a stand-alone cluster or you are managing this cluster directly. If your cluster is part of a multi-cluster and you do not want to manage the cluster directly, use only one of `clusters`, `clusterSelector`, or `placementRef` to define where your subscription is to be placed. If your cluster is the Hub of a multi-cluster and you want to manage the cluster directly, you must register the Hub as a managed cluster before the subscription operator can subscribe to resources locally. |
| spec.placement.clusters | Optional. Defines the clusters where the subscription is to be placed. Use only one of `clusters`, `clusterSelector`, or `placementRef` to define where your subscription is to be placed for a multi-cluster. If your cluster is a stand-alone cluster that is not your Hub cluster, you can also use `local`. |
| spec.placement.clusters.name | Optional, but required for defining the subscribing clusters. The name or names of the subscribing clusters. |
| spec.placement.clusterSelector | Optional. Defines the label selector to use to identify the clusters where the subscription is to be placed. Use only one of `clusters`, `clusterSelector`, or `placementRef` to define where your subscription is to be placed for a multi-cluster. If your cluster is a stand-alone cluster that is not your Hub cluster, you can also use `local`. |
| spec.placement.placementRef | Optional. Defines the placement rule to use for the subscription. Use only one of `clusters`, `clusterSelector` , or `placementRef` to define where your subscription is to be placed for a multi-cluster. If your cluster is a stand-alone cluster that is not your Hub cluster, you can also use `local`. |
| spec.placement.placementRef.name | Optional, but required for using a placement rule. The name of the placement rule for the subscription. |
| spec.placement.placementRef.kind | Optional, but required for using a placement rule. Set the value to `PlacementRule` to indicate that a placement rule is used for deployments with the subscription. |
| spec.overrides | Optional. Any parameters and values that need to be overridden, such as cluster-specific settings. |
| spec.overrides.clusterName | Optional. The name of the cluster or clusters where parameters and values are being overridden. |
| spec.overrides.clusterOverrides | Optional. The configuration of parameters and values to override. |
| spec.timeWindow | Optional. Defines the settings for configuring a time window when the subscription is active or blocked. |
| spec.timeWindow.type | Optional, but required for configuring a time window. Indicates whether the subscription is active or blocked during the configured time window. Deployments for the subscription occur only when the subscription is active. |
| spec.timeWindow.location | Optional, but required for configuring a time window. The time zone of the configured time range for the time window. All time zones must use the Time Zone (tz) database name format. For more information, see [Time Zone Database ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.iana.org/time-zones). |
| spec.timeWindow.weekdays | Optional, but required for configuring a time window. Indicates the days of the week when the time range is applied to create a time window. The list of days must be defined as an array, such as `weekdays: ["Monday", "Wednesday", "Friday"]`. |
| spec.timeWindow.hours | Optional, but required for configuring a time window. Defined the time range for the time window. A start time and end time for the hour range must be defined for each time window. You can define multiple time window ranges for a subscription. |
| spec.timeWindow.hours.start | Optional, but required for configuring a time window. The timestamp that defines the beginning of the time window. The timestamp must use the Go programming language Kitchen format `"hh:mmpm"`. For more information, see [Constants ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://godoc.org/time#pkg-constants). |  
| spec.timeWindow.hours.end | Optional, but required for configuring a time window. The timestamp that defines the ending of the time window. The timestamp must use the Go programming language Kitchen format `"hh:mmpm"`. For more information, see [Constants ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://godoc.org/time#pkg-constants). |
{: caption="Table 1. Required and optional definition fields" caption-side="top"}

**Notes:**

* When you are defining your YAML, a subscription can use `packageFilters` to point to multiple Helm charts, deployables, or other Kubernetes resources. The subscription, however, only deploys the latest version of one chart, or deployable, or other resource.
* Annotations are used by a subscription operator for `Namespace` type channels to search for versions of a deployable. The subscription operator searches the versions to find the appropriate deployable version to retrieve. If your channel is a `Namespace` channel, include the annotations for identifying the deployable version.
* For time windows, when you are defining the time range for a window, the start time must be set to occur before the end time. If you are defining multiple time windows for a subscription, the time ranges for the windows cannot overlap. The actual time ranges are based on the `subscription-controller` container time, which can be set to a different time and location than the time and location that you are working within.
* Within your subscription spec, you can also define the placement of a Helm release or deployable as part of the subscription definition. Similar to the definition for deployables, each subscription can reference an existing placement rule, or define a placement rule directly within the subscription definition.
* When you are defining where to place your subscription in the `spec.placement` section, use only one of `clusters`, `clusterSelector`, or `placementRef` for a multi-cluster environment. If you include more than one of `clusters`, `clusterSelector`, or `placementRef`, the following priority is used to determine which setting the subscription operator uses:
  1. `placementRef`
  2. `clusters`
  3. `clusterSelector`

### Package overrides
{: #package_overrides}

Package overrides for a subscription override values for the Helm chart or Kubernetes resource that is subscribed to by the subscription.

To configure a package override, specify the field within the Kubernetes resource spec to override as the value for the `path` field. Specify the replacement value as the value for the `value` field.

For example, if you need to override the values field within the spec for a Helm release (`HelmRelease.app.ibm.com`) for a subscribed Helm chart, you need to set the value for the `path` field in your subscription definition to `spec.values`.

```
packageOverrides:
- packageName: nginx-ingress
  packageOverrides:
  - path: spec.values
    value: my-override-values
```
{: codeblock}

The contents for the `value` field are used to override the values within the `spec.values` field of the `HelmRelease` spec.

* For a Helm release, override values for the `spec.values` field are merged into the Helm release `values.yaml` file to override the existing values. This file is used to retrieve the configurable variables for the Helm release.

* If you need to override the release name for a Helm release, include the `packageOverride` section within your definition. Define the `packageOverride` for the Helm release by including the following fields:
  * `packageName` to identify the Helm chart
  * `packageOverrides.path: spec.releaseName` to indicate that you are overriding the release name field in the Helm release spec.
  * `packageOverrides.value:` with your new release name as the value.

   By default, if no Helm release name is specified, the Helm chart name is used to identify the release. In some cases, such as when there are multiple releases subscribed to the same chart, conflicts can occur. The release name must be unique among the subscriptions within a namespace. If the release name for a subscription that you are creating is not unique, an error occurs. You must set a different release name for your subscription by defining a `packageOverride`. If you want to change the name within an existing subscription, you must first delete that subscription and then recreate the subscription with the preferred release name.

  ```
  packageOverrides:
  - packageName: nginx-ingress
    packageOverrides:
    - path: spec.releaseName
      value: my-helm-release-name
  ```
  {: codeblock}

## Example subscription YAML 
{: #subscription_example}

The following YAML content defines example subscriptions:

  * [Channel subscription example](#channel_example)
  * [Scheduled channel subscription example](#timewindow_example)
  * [Channel subscription example with overrides](#channel_example_overrides)
  * [Helm repository subscription example](#helm_example)

### Channel subscription example
{: #channel_example}

```YAML
apiVersion: app.ibm.com/v1alpha1
kind: Subscription
metadata:
  name: my-channel-subscription
spec:
  channel: my-channel-namespace/my-qa-channel
  placement:
    clusters:
    - name: my-development-cluster-1
```
{: codeblock}

### Scheduled channel subscription example
{: #timewindow_example}

The following example subscription includes multiple configured time windows. A time window occurs between 10:20 AM and 10:30 AM occurs every Monday, Wednesday, and Friday. A time window also occurs between 12:40 PM and 1:40 PM every Monday, Wednesday, and Friday. The subscription is active only during these six weekly time windows for deployments to begin.  

```YAML
apiVersion: app.ibm.com/v1alpha1
kind: Subscription
metadata:
  name: nginx
  namespace: my-channel-subscription-nginx
  labels:
    app: nginx-app-details
spec:
  channel: my-channel-namespace/my-development-channel
  name: nginx-ingress
  packageFilter:
    version: "1.20.x"
  placement:
    placementRef:
      kind: PlacementRule
      name: my-placement-rule
  timeWindow:
    type: "block"/"active"
    location: "America/Los_Angeles"
    weekdays: ["Monday", "Wednesday", "Friday"]
    hours:
      - start: "10:20AM"
        end: "10:30AM"
      - start: "12:40PM"
        end: "1:40PM"
```
{: codeblock}

### Channel subscription example with overrides
{: #channel_example_overrides}

The following example includes package overrides to define a different release name of the Helm release for Helm chart. A package override setting is used to set the name `my-nginx-ingress-releaseName` as the different release name for the  `nginx-ingress` Helm release.

```yaml
apiVersion: app.ibm.com/v1alpha1
kind: Subscription
metadata:
  name: simple
  namespace: default
spec:
  channel: dev/dev-helmrepo
  name: nginx-ingress
  packageOverrides:
  - packageName: nginx-ingress
    packageOverrides:
    - path: spec.releaseName
      value: my-nginx-ingress-releaseName
    - path: spec.values
      value: |
        defaultBackend:
          replicaCount: 3
  placement:
    local: false
```
{: codeblock}

### Helm repository subscription example
{: #helm_example}

The following subscription automatically pulls the latest `nginx` Helm release for the version `1.x`. The Helm release deployable is placed on the `mydevcluster1` cluster when a new version is available in the source Helm repository.

The `spec.packageOverrides` section shows optional parameters for overriding values for the Helm release. The override values are merged into the Helm release `values.yaml` file, which is used to retrieve the configurable variables for the Helm release.

```YAML
apiVersion: app.ibm.com/v1alpha1
kind: Subscription
metadata:
  name: my-helm-subscription
  namespace: my-namespace
spec:
  source: https://kubernetes-charts.storage.googleapis.com/
  name: nginx
  packageFilter:
    version: 1.x
  placement:
    clusters:
    - name: my-development-cluster-1
  packageOverrides:
  - packageName: my-server-integration-prod
    packageOverrides:
    - path: spec.values
      value: |
        persistence:
          enabled: false
          useDynamicProvisioning: false
        license: accept
        tls:
          hostname: my-mcm-cluster.icp
        sso:
          registrationImage:
            pullSecret: hub-repo-docker-secret
```
{: codeblock}
