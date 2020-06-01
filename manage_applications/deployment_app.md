# Deploying applications

If you plan to use a continuous delivery model for developing your applications, you might use a combination of channels, subscriptions, and placement rules.

Channels (`channel.apps.open-cluster-management.io`) define a namespace within the Hub cluster and point to a physical place where resources are stored for deployment, such as an object store, Kubernetes namespace, Helm repository, or GitHub repository. Clusters can subscribe to channels for identifying the deployables to deploy to each cluster. Deployables within a channel can be accessed by only the clusters that subscribe to that channel.

Subscriptions (`subscription.apps.open-cluster-management.io`) are sets of definitions that identify deployables within channels by using annotations, labels, and versions. The subscription operator can monitor the channel for new or updated Helm charts, deployables, or secret. Then, the operator can download the Helm chart, deployable, or secret directly from the source location (Helm repository, GitHub repository, object store, or namespace) to the target managed clusters.

Placement rules (`placementrule.apps.open-cluster-management.io`) define the target clusters where subscriptions deploy and maintain the Kubernetes resources. You can use placement rules to help you facilitate the multi-cluster deployment. Placement rules that are defined as stand-alone resources can be shared across deployables.

Channels, subscriptions, and placement rules can help you to unify and simplify your continuous deliveries that involve frequent updates and deployments to multiple clusters. Use a combination of these resources when you need to deploy to multiple clusters, deploy frequent updates, and share deployment settings across multiple deployables.
Based on your deployment requirements, review the details and process for the following deployment options:

See [Deploying by using application resources](deploying.md) to learn to set up and use channels, subscriptions, and placement rules for deployments.
