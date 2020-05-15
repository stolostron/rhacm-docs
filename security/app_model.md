# Application model and definitions

Applications are composed of multiple resources. The main foundational resources that Red Hat Advanced Cluster Management for Kubernetes applications provides are subscription, channel, placement rules, and applications.

Within this application model, applications are composed of multiple resources. The main foundation resources for Red Hat Advanced Cluster Management for Kubernetes applications are the `application` resource and the `deployable` resource. The overrides and dependencies for deployables are defined within the definition for the deployables. The placement rules for deployables can be defined as a stand-alone resource and referenced by the deployable.

**Note:** The Kubernetes apiserver is the main service for providing application management functions. All application resource specs are accessible by using the Kubernetes CLI tool. 

* Channels (`channel.apps.open-cluster-management.io`) define the source repositories that a cluster can subscribe to with a subscription and can be of the following types: GitHub repositories, Helm release registries, objectstores, and resource template (deployable) namespace on the hub cluster.

* Subscriptions (`subscription.apps.open-cluster-management.io`) allow clusters to subscribe to a source repository (channel) that can be of the following type: GitHub repository, Helm release registry, objectstore, or resource template (deployable) namespace.

Subscriptions serve as the continuous delivery for your development and operations pipelines. Configure subscriptions to deliver content locally to a cluster or to many clusters with a placement rule, which is defined in the next list item.

* Placement rules (`placementrule.apps.open-cluster-management.io`) define the target clusters where subscriptions deploy and maintain the Kubernetes resources. You can use placement rules to help you facilitate the multi-cluster deployment. Placement rules that are defined as stand-alone resources can be shared across deployables.

* Applications (`application.app.k8s.io`) in Red Hat Advanced Cluster Management for Kubernetes are used for grouping subscriptions that deploy and maintain the Kubernetes resources that make up an application.
 
All of the application component resources for Red Hat Advanced Cluster Management for Kubernetes applications are defined in YAML files. For more information about creating and managing application resources, see:
 
* [Creating and managing application resources](managing_apps.md)
* [Creating and managing deployables](managing_deployables.md)
* [Creating and managing channels](managing_channels.md)
* [Creating and managing subscriptions](managing_subscriptions.md)
* [Creating and managing placement rules](managing_placement_rules.md)