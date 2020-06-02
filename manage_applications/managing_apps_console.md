# Managing applications with the console

You can use the console to create, manage, view details, and troubleshoot application resources, including applications, deployables, channels, subscriptions, and placement rules. Samples for all resources are located in the [Application resource samples](app_resource_samples.md) documentation.

The console includes different tools that each provide different application management capabilities. These capabilities allow you to easily create, find, update, deploy, and monitor applications resources.

  * [Applications dashboards](#applications-dashboards)
  * [Search](#search)
  * [Topology](#topology)

## Applications dashboards

From the main _Applications_ dashboard, you can view information about all applications and select a specific application to view the dashboard for more information about that specific application.

### Applications dashboard (all applications)

From the _Overview_ tab on this dashboard, you can complete the following tasks:

* View a table that lists all applications. If needed, you can use the search box to filter the applications that are listed.
* From the _Applications_ page, you can view the following information:
  * The application name and namespace.
  * The number of managed clusters where the application is deployed through a subscription.
  * The number of subscriptions that are used to deploy the application and the associated status.
  * The date when the application was created.
  * The Grafana dashboard for the application. 
  
* From this page, you can also select **New application** to create an application, which opens a YAML editor where you can define an application resource. For more information, see [Creating and managing application resources](managing_apps.md#app_create).
* You can click on an application name to go to the _Applications_ dashboard for that specific application to view more information about that application. You can also access _Grafana_.

From the _Resources_ tab for all applications, you can complete the following tasks:

* View the summary of resources for all applications on different cards. These resource summary cards show the following information about your applications and related managed clusters:
  * The number of subscriptions on the hub cluster and the number of subscriptions that failed to deploy to the hub cluster.
  * The total number of managed clusters.
  * The number of subscriptions that are active for those managed clusters.
  * The total number of channels and placement rules for all applications.
  You can click each summary card to open the _Search_ page and display more information about the selected resource.
* Select to create subscriptions, channels, and placement rules. When you select to create any of these resources a YAML editor opens for you to use to define the resource. Default sample YAML content is included as templates to indicate the required fields to help you create any of these resource types. For more information, see:
  * [Creating and managing channels](managing_channels.md#channel_create)
  * [Creating and managing subscriptions](managing_subscriptions.md#subscription_create)
  * [Creating and managing placement rules](managing_placement_rules.md#placement_create)
* View the resource pipeline for all applications, which includes a table that displays details for your applications and other resources:
  * Each row provides details for a single application. Rows are included for all of your applications. If needed, you can use the search box to filter the application rows to find a matching application.
  * Expand the row for each application to view more details for the associated channels, subscriptions, and placement rules, view related incidents, and view the status of resource (pod) deployments.
  * Select an associated subscription for a channel and application to view more details about that subscription, including the subscribed deployables, the associated channel, namespace, and host-cluster, the status of any related resource (pod) deployments, and the placement settings that are used with the subscription.

### Application dashboard (single applications)

From the _Overview_ tab of the dashboard for a single application, you can complete the following tasks:

* View the summary of resource highlights for the application on different cards. These resource summary cards show the following information:
  * The number of subscriptions on the hub cluster for the application and the number of subscriptions that failed to deploy to the hub cluster.
  * The total number of managed clusters where the application is used. This card also shows the total number of subscriptions for the application on those managed clusters, and the number of subscriptions that failed to deploy to those managed clusters.
  * The number of pods for the application, including the number that are running and failed.
  * The number of policy violations and incidents that are related to the application.
  You can click each summary card to open the _Search_ page and display more information about the selected resource.
* Select to view additional details for the application, including the application namespace, version, creation date, associated labels and annotations, and more.
* View the resource topology for the application that shows the application and related components such as channels, deployables, related services, pods, and placement rules. You can select to edit the topology and update the YAML definitions for the application and related resources, such as to add, change, or remove resources.

From the _Resources_ tab for a single application, you can complete the following tasks:

* View the resource list for the application. This list includes all resources that are associated with the application, including pods, secrets, services, and more. This list indicates the name, namespace, kind, API groups, and status of each resource. The list also indicates the cluster where the resource is deployed, the creation date of the resource, and the last date that the resource was updated.
* View the resource pipeline for the application, which includes the summary of the application resources, options to create resources, and a table that provides more details about the resources. The resource pipeline for a single application includes similar information to the pipeline for all applications. The difference between the two pipelines is that this pipeline is scoped to just the selected application.

## Search

The console search page supports searching for application resources by the component kind for each resource. To search for resources, use the following values:

| Application resource | Kind (search parameter) |
|-- | -- |
| Application | `Application` |
| Channel | `Channel` |
| Deployable | `Deployable` |
| Secret | `Secret` |
| Placement rule | `PlacementRule` |
| Subscription | `Subscription` |
{: caption="Table 1. Component kind search term for application resources" caption-side="top"}

You can also search by other fields, including name, namespace, cluster, label, and more.

From the search results, you can view identifying details for each resource, including the name, namespace, cluster, labels, and creation date. If needed, you can also expand the _Options_ menu in the search results for a resource to select to delete that resource.

By clicking the resource name in the search results, a YAML editor opens and displays the YAML definition for the resource. You can choose to edit the definition within the editor. Any changes that you save are applied to the resource immediately.  

For more information about using search, see [Search in the console](../console/search.md).

## Topology

The Topology page provides you with a visualization of your applications, clusters, relationships, and policies. The application topology includes a visualization of the components that comprise each application. The topology view for each application includes any deployables, services, deployments, charts, and pods for that application.

You can select any component from the topology view to view more details. You can also hover your cursor over a resource to view the component kind, name, and namespace and links to view the search results for the resource or namespace. When you are viewing the details for a pod, you can select to view the logs for that pod.

The _Topology_ page is available from the _Observe environments_ sub-menu within the console main menu. For more information about using the topology page, see [console components](../console/console.md).

