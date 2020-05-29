# Application resources 

Within Red Hat Advanced Cluster Management for Kubernetes, applications are composed of multiple application resources. The foundational resources for Red Hat Advanced Cluster Management for Kubernetes applications are the `application` resource and the `deployable` resource.

In addition, you can use channel, subscription, and placement rule resources to help you deploy, update, and manage your overall applications.

Both single and multi-cluster applications use the same Kubernetes specifications, but multi-cluster applications involve more automation of the deployment and application management lifecycle.

All of the application component resources for Red Hat Advanced Cluster Management for Kubernetes applications are defined in YAML file spec sections. When you need to create or update an application component resource, you need to create or edit the appropriate spec section to include the labels for defining your resource.

View the following application resource sections:

- Applications (`Application.app.k8s.io`) in Red Hat Advanced Cluster Management for Kubernetes are used for viewing the application components. For more information about creating and managing secrets, see [Creating and managing applications](managing_apps.md). See [Application samples](app_sample.md) for sample YAML files.


Deployables are used to wrap other resources to prevent actions from being run against the resources by Kubernetes and other controllers before the resources are placed on target clusters. By wrapping the resources, deployables can be directly deployed to one or more target clusters from the hub cluster where the deployable source is stored. When the deployables are on the target cluster or clusters, the resources are unwrapped so that required actions can then run against the resources.

The placement, overrides, and dependencies for deployables are defined within the spec for the deployables. The placement for deployables can also be defined within a subscription, such as for multi-cluster deployments.

- Secrets (`Secret`) are Kubernetes resources that you can use to store authorization and other sensitive information, such as passwords, OAuth tokens, and SSH keys. By storing this information as secrets, you can separate the information from the application components that require the information to improve your data security. See [Managing secrets](managing_secrets.md). See [Secret samples](secret_sample.md) for sample YAML files.

If you have applications that require secret resources to operate, you can use subscriptions to deploy the secrets to the managed clusters where the resources are needed.

If you have applications that require Kubernetes resources or Helm charts from channels that require authorization, such as entitled GitHub repositories, you can use secrets to provide access to these channels. You can include a reference to a secret within your subscriptions to provide your subscriptions the required credentials to access secure channels. With this access, your subscriptions can access Kubernetes resources and Helm charts for deployment from these channels while maintaining data security.

- Channels (`channel.apps.open-cluster-management.io`) provide you with improved continuous integration and continuous delivery capabilities for creating and managing your Red Hat Advanced Cluster Management for Kubernetes applications. Channels are custom resource definitions that can help you streamline deployments and separate cluster access. 
For more information about creating and managing channels, see [Managing channels](managing_channels.md). See [Channel samples](channel_sample.md) for sample YAML files.

Channels define a namespace within the hub cluster and point to a physical place where resources are stored for deployment, such as an object store, Kubernetes namespace, Helm repository, or GitHub repository. Clusters can subscribe to channels for identifying the deployables to deploy to each cluster. Deployables within a channel can be accessed by only the clusters that subscribe to that channel.

For `Namespace` and `ObjectBucket` channel types, the spec for each channel can define conditions that a deployable must match to be included in the channel. These conditions are defined as Kubernetes labels for the channel, such as the source namespace, package name, labels, and annotations. A deployable must have the same labels for the deployable to be included in the channel. A deployable can be included in a channel only when the deployable is labeled with the same labels as the channel.

- Subscriptions: As with channels, subscriptions (`subscription.apps.open-cluster-management.io`) provide you with improved continuous integration and continuous delivery capabilities for application management. For information about creating and managing subscriptions, see [Managing subscriptions](managing_subscriptions.md). See [Subscription samples](subscription_sample.md) for sample YAML files.

Subscriptions are sets of definitions that identify Helm charts, deployables, and other Kubernetes resources within channels by using annotations, labels, and versions. Subscriptions can point to a channel or storage location for identifying new or updated deployables. The subscription operator can then download the subscribed Helm chart, deployable, or secret directly from the storage location to target managed clusters without checking the Hub cluster first. With a subscription, the subscription operator can monitor the channel for new or updated resources instead of the Hub cluster.

- Placement rules: Placement rules (`placementrule.apps.open-cluster-management.io`) define the target clusters where deployables can be deployed. Use placement rules to help you facilitate the multi-cluster deployment of your deployables. For more information about creating and managing placement rules, see [Managing placement rules](managing_placement_rules.md). See [Placement rule samples](placement_sample.md) for sample YAML files.

The custom resource definition (CRD) and controller for placement rules replaces the placement policies that were used for applications in previous versions of Red Hat Advanced Cluster Management for Kubernetes. Placement policies are still used for governance and risk policies.

Placement rules can be defined for subscriptions and for deployables. Define the placement rule at the subscription level for multi-cluster deployments. Define the placement rule for a specific deployable for single-cluster deployments or to override placement settings.  
