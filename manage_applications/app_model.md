# Application model and definitions

The Application model consists of the following Kubernetes custom resources: channels, subscription, placement rules, and applications.

* Channels (`channel.apps.open-cluster-management.io`) define the source repositories that a cluster can subscribe to with a subscription and can be the following types: GitHub repositories, Helm release registries, objectstores, and resource template (deployable) namespace on the hub cluster. Channels require individual namespaces, except GitHub channels, which can share a namespace with another GitHub channel.

* Subscriptions (`subscription.apps.open-cluster-management.io`) allow clusters to subscribe to a source repository (channel) that can be the following types: GitHub repository, Helm release registry, objectstore, or resource template (deployable) namespace. Subscriptions can be applied locally to the hub or to managed-clusters.

* Placement rules (`placementrule.apps.open-cluster-management.io`) define the target clusters where subscriptions deploy and maintain the Kubernetes resources. You can use placement rules to help you facilitate the multi-cluster deployment. Placement rules can be shared across subscriptions.

* Applications (`application.app.k8s.io`) in Red Hat Advanced Cluster Management for Kubernetes are used for grouping Kubernetes resources that make up an application.

 For more information about creating and managing application resources, see:
 
* [Creating and managing application resources](managing_apps.md)
<!--* [Creating and managing deployables](managing_deployables.md) deployable doc needs to be withing channel namespace -->
* [Creating and managing channels](managing_channels.md)
* [Creating and managing subscriptions](managing_subscriptions.md)
* [Creating and managing placement rules](managing_placement_rules.md)
