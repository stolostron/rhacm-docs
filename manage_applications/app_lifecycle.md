---

copyright:
  years: 2020
lastupdated: "2020-03-13"

---


# Application management lifecycle

Red Hat Advanced Cluster Management for Kubernetes provides enhanced application management capabilities through a Kubernetes resource based application model and channel and subscription based deployment options. The application model and deployment capabilities are designed to unify and simplify the deployment experience for creating and managing your application across both single cluster and multi-cluster scenarios.
{:shortdesc}

With these application management capabilities, you can use channels and subscriptions to gain improved continuous and automated delivery of your deployables to target managed clusters. For more information about deployables, see [Application resources](app_lifecycle.md#deployables).

Your developers and DevOps personnel can use these resources to deploy, update, manage, and monitor versions of your applications across multiple environments through complete automation.

  * [Application model](#app_model)
  * [Application resource interactions and lifecycle](#app_interact)
  * [Deploying application resources](#app_deploy)
  * [Managing applications with the console](#app_gui)

## Application model
{: #app_model}

The application model and deployment options work for, and scale, any clustered environment and application management requirements. This scalability supports both a single application developer that builds and deploys an application from their device to a multicloud environment, or a cloud operations personnel that needs to deploy and update hundreds of applications across hundreds of clusters. With this application model and deployment option, you can separate your organizations roles for developing applications and DevOps. Your application developers can focus on developing and defining the application resources. Meanwhile, your DevOps personnel can focus on creating and managing the channels and subscriptions to ensure that resources are deployed correctly. You can use the new model and deployment options to update and deploy one or more applications to hundreds of managed clusters, each in a different physical location.

Within this application model, applications are composed of multiple resources. The main foundation resources for Red Hat Advanced Cluster Management for Kubernetes applications are the `application` resource and the `deployable` resource. The overrides and dependencies for deployables are defined within the definition for the deployables. The placement rules for deployables can be defined as a stand-alone resource and referenced by the deployable.

* Applications (`Application.app.k8s.io`) in Red Hat Advanced Cluster Management for Kubernetes are used for grouping application components.

* Deployables (`Deployable.app.ibm.com`) are Kubernetes resources that contain templates to wrap other Kubernetes resources or to represent Helm releases for deployment to clusters.

* Placement rules (`PlacementRule.app.ibm.com`) define the target clusters where deployables can be deployed. You can use placement rules to help you facilitate the multi-cluster deployment of your deployables. Placement rules can be referenced by deployables and subscriptions. Placement rules that are defined as stand-alone resources can be shared across deployables.

To better integrate with continuous delivery systems, you can use channel and subscription resources. Channels and subscriptions provide you with improved continuous delivery capabilities for creating and managing your Red Hat Advanced Cluster Management for Kubernetes applications.

* Channels (`Channel.app.ibm.com`) define a namespace within the hub cluster and point to a physical place where resources are stored for deployment; such as an object store, Kubernetes namespace, Helm repository, or GitHub repository. Channels are custom resource definitions that can help you streamline deployments and separate cluster access. Clusters can subscribe to channels for identifying the deployables to deploy to each cluster. Deployables within a channel can be accessed by only the clusters that subscribe to that channel.

* Subscriptions (`Subscription.app.ibm.com`) are sets of definitions that identify deployables within channels by using annotations, labels, and versions. The subscription operator can monitor the channel for new or updated deployables, such as an updated Helm release or new Kubernetes deployable object. Then, the operator can download the Kubernetes deployable object or Helm release directly from the source location (Helm repository, GitHub repository, object store, or namespace) to the target managed clusters.

Although single and multi-cluster applications both use the same Kubernetes specifications, multi-cluster applications involve more automation of the deployment and application management lifecycle. The application definition is based on the Custom Resource Definition (CRD) of the [Kubernetes SIG Application CRD definition](https://github.com/kubernetes-sigs/application){:new_window}. This definition is used for applications in both single and multi-cluster environments for grouping application resources. The other resource kinds for the application model (deployables, channels, subscriptions, and placement rules) are based on specifications that are created by IBM. These specifications use common Kubernetes resource fields for defining annotations, labels, metadata, and more, and support custom fields and values.

For more information about these resources, see [Application resources](app_resources.md).

All of the application component resources for Red Hat Advanced Cluster Management for Kubernetes applications are defined in YAML files. When you need to create or update an application component resource, you need to create or edit the appropriate spec section to include the labels for defining your resource. For more information about creating and managing application resources, see:

* [Creating and managing application resources](managing_apps.md)
* [Creating and managing deployables](managing_deployables.md)
* [Creating and managing channels](managing_channels.md)
* [Creating and managing subscriptions](managing_subscriptions.md)
* [Creating and managing placement rules](managing_placement_rules.md)

The Kubernetes apiserver is the main service for providing application management functions. All application resource specs are accessible by using the Kubernetes CLI tool. In addition, a hcmctl is provided to wrap kubectl commands for better and smoother CLI experiences.

## Application resource interactions and lifecycle
{: #app_interact}

With the new application model and deployment options, the high-level flow for creating and managing applications can resemble the following steps:

1. A developer or DevOps personnel for your organization creates the YAML definitions for any required channels. With the channels created, application developers can include the required values to promote a deployable to a channel when they are creating the deployable.

2. With the channels created, the application developers for your organization can create the YAML definitions for any required applications or related deployables on the hub cluster. As part of creating a deployable, the developer can reference any required placement rule for deploying the deployable. The developer can also include the required values to promote the deployable to a channel.
   * For `objectBucket` type channels, developers can promote resources directly to the channel without wrapping the resource as a deployable. The channel controllers can synchronize the resource as a deployable automatically.
   * For `HelmRepo` type channels, developers can upload Helm charts to the Helm repository without creating deployables to represent the chart. The channel controllers can synchronize the chart as a deployable within the channel.
   * For `GitHub` type channels, developers can upload Kubernetes resources YAML files and unpackaged Helm charts to a GitHub repository without wrapping the resources as deployables. The channel controllers synchronize resources as deployables automatically.
   * For `Namespace` type channels, developers can upload Kubernetes resource templates. Subscription for this type of channel retrieves and deploys the template. The namespaces that the channel monitors for new or updated deployables must be on the hub cluster.

3. DevOps personnel or other users for your organization can create any required subscriptions that need to be used for deploying the application and the related deployables. The labels for the subscription definition are used to associate the subscription to an application by matching the `selector` settings in the application spec.

4. DevOps personnel or other users for your organization can create the set of placement rules for your clusters within Red Hat Advanced Cluster Management for Kubernetes. These users or an application developer can then update the deployables or subscriptions to reference the placement rules.

   A created placement rule can be updated when needed in Git and then pushed through a continuous delivery process to update the rule on the hub cluster. After the hub cluster is updated, the change is made to the rule on the managed clusters that are connected to the hub cluster. Any subsequent change for deployables that is based on the rule change is then started.

5. Users for your organization then complete any required updates for the application resource definitions, such as to configure overrides for deployables, or to adjust or reference placement rules.

Once the deployables and other resources are created, the subscription operator can automatically identify new or updated deployables and begin any associated deployment of the source resources. When further changes to the source resources or deployables occur, the changes are automatically detected and the updated resources are retrieved from the channel source and deployed. The process to automatically identify and deploy changes, can resemble the following high-level steps:

   1. When all resource kinds exist, each subscription monitors, or watches, to the channels that are defined for each subscription for new and updated deployables.
   2. When a new or updated deployable exists, the subscription operator retrieves the source Kubernetes deployable object or Helm release that is wrapped or represented by the deployable.
   3. The subscription operator then uses the associated placement rule to place the Kubernetes deployable object or Helm release on the managed cluster. The subscription operator then continues to watch for further changes.

To create or edit the resource definitions developers and other users can use the console, the Kubernetes CLI tool, or REST API.

## Deploying application resources
{: #app_deploy}

Red Hat Advanced Cluster Management for Kubernetes supports multiple options for the deployment of deployable objects and Helm charts. The deployment option that you use can depend upon whether you need to deploy to a single cluster or multiple clusters and the frequency that you need to deploy updates. For more information, see [Deploying an application resource](deployment_app.md).
  
## Managing applications with the console
{: #app_gui}

The console includes an applications dashboard for managing the application lifecycle. You can use the console dashboard to create and manage application, subscriptions, channels, and placement rules. You can also use the console to view the status of your applications, channels, subscriptions, and related deployments.

The dashboard includes enhanced capabilities, which your developers and operations personnel can use to create, deploy, update, manage, visualize, and monitor applications across your clusters. With this application dashboard, you can complete the following tasks:

* View your deployment pipeline to view all deployed applications across your clusters, including any associated channels and subscriptions.
* View events in the context of an application, including deployments, updates, and monitoring data.
* Access an improved topology view that encompasses the new application resource definitions, including channels, subscriptions, and placement rules.
* View a the logs tab for applications to view logs for each application resource.
* When IBM Cloud Event Management is enabled, you can use that service to view incident reports.
* When IBM Cloud App Management is installed, you can open that service from the console to access visualized golden signals and other monitoring data to view more information about the status and performance of your subscriptions and applications. 
* When Grafana is installed, you can open the Grafana dashboard for your applications from the applications dashboard to monitor your applications.
* Add and edit channels, subscriptions, placement rules, and applications from different views and pages.

  **Note:** The application dashboard shows only the application resources that use the new custom resource definitions. Application resources that are based on the definitions that were used for previous versions of Red Hat Advanced Cluster Management for Kubernetes are not displayed. You can migrate your older style application resources to use the new definitions and have your resources display in the console.

For more information, see [Managing applications with the console](managing_apps_console.md).
