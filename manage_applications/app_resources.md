# Application resources 

Within Red Hat Advanced Cluster Management for Kubernetes, applications are composed of multiple application resources. The foundational resources for Red Hat Advanced Cluster Management for Kubernetes applications are the `application` resource and the `deployable` resource.

In addition, you can use channel, subscription, and placement rule resources to help you deploy, update, and manage your overall applications.

Both single and multi-cluster applications use the same Kubernetes specifications, but multi-cluster applications involve more automation of the deployment and application management lifecycle.

All of the application component resources for Red Hat Advanced Cluster Management for Kubernetes applications are defined in YAML file spec sections. When you need to create or update an application component resource, you need to create or edit the appropriate spec section to include the labels for defining your resource.

View the following application resource sections:

- [Application](#application)
- [Deployables](#deployables)
- [Secrets](#secrets)
- [Channels](#channels)
- [Subscriptions](#subscriptions)
- [Placement rules](#placement-rules)

## Application

Applications (`Application.app.k8s.io`) in Red Hat Advanced Cluster Management for Kubernetes are used for viewing the application components.

The definition structure for an application can resemble the following example YAML content:

```yaml
apiVersion: app.k8s.io/v1beta1
kind: Application
metadata:
  labels:
    app: nginx-app-details
  name: nginx-app-3
  namespace: ns-sub-1
spec:
  componentKinds:
  - group: apps.open-cluster-management.io
    kind: Subscription
  selector:
    matchLabels:
      app: nginx-app-details
status: {}
```

For more information about creating and managing applications, see [Creating and managing applications](managing_apps.md).

## Deployables


Deployables (`deployable.apps.open-cluster-management.io`) are Kubernetes resources that contain templates to wrap other Kubernetes resources or represent Helm releases for deployment to clusters to create or manage applications.

Deployables are used to wrap other resources to prevent actions from being run against the resources by Kubernetes and other controllers before the resources are placed on target clusters. By wrapping the resources, deployables can be directly deployed to one or more target clusters from the hub cluster where the deployable source is stored. When the deployables are on the target cluster or clusters, the resources are unwrapped so that required actions can then run against the resources.

The placement, overrides, and dependencies for deployables are defined within the spec for the deployables. The placement for deployables can also be defined within a subscription, such as for multi-cluster deployments.

The definition structure for a deployable can resemble the following YAML content:

```yaml
apiVersion: apps.open-cluster-management.io/v1
kind: Deployable
metadata:
  annotations:
    apps.open-cluster-management.io/is-local-deployable: false
  labels:
    app: nginx-app-details
  name: example-configmap
  namespace: ns-sub-1
spec:
  template:
    apiVersion: v1
    kind: ConfigMap
    metadata:
      name: config1
      namespace: default
    data:
      purpose: for test
```

For more information about creating and managing deployables, see [Managing deployables](managing_deployables.md).

## Secrets

Secrets (`Secret`) are Kubernetes resources that you can use to store authorization and other sensitive information, such as passwords, OAuth tokens, and SSH keys. By storing this information as secrets, you can separate the information from the application components that require the information to improve your data security.

If you have applications that require secret resources to operate, you can use subscriptions to deploy the secrets to the managed clusters where the resources are needed.

If you have applications that require Kubernetes resources or Helm charts from channels that require authorization, such as entitled GitHub repositories, you can use secrets to provide access to these channels. You can include a reference to a secret within your subscriptions to provide your subscriptions the required credentials to access secure channels. With this access, your subscriptions can access Kubernetes resources and Helm charts for deployment from these channels while maintaining data security.

The definition structure for a secret can resemble the following YAML content:

```yaml
apiVersion: v1
kind: Secret
metadata:
  annotations:
      apps.open-cluster-management.io/deployables: "true"
  name: [secret-name]
  namespace: [channel-namespace]
data:
  AccessKeyID: [ABCdeF1=] #Base64 encoded
  SecretAccessKey: [gHIjk2lmnoPQRST3uvw==] #Base64 encoded
```

For more information about creating and managing secrets, see [Managing secrets](managing_secrets.md).

## Channels

Channels (`channel.apps.open-cluster-management.io`) provide you with improved continuous integration and continuous delivery capabilities for creating and managing your Red Hat Advanced Cluster Management for Kubernetes applications. Channels are custom resource definitions that can help you streamline deployments and separate cluster access.

Channels define a namespace within the hub cluster and point to a physical place where resources are stored for deployment, such as an object store, Kubernetes namespace, Helm repository, or GitHub repository. Clusters can subscribe to channels for identifying the deployables to deploy to each cluster. Deployables within a channel can be accessed by only the clusters that subscribe to that channel.

For `Namespace` and `ObjectBucket` channel types, the spec for each channel can define conditions that a deployable must match to be included in the channel. These conditions are defined as Kubernetes labels for the channel, such as the source namespace, package name, labels, and annotations. A deployable must have the same labels for the deployable to be included in the channel. A deployable can be included in a channel only when the deployable is labeled with the same labels as the channel.

The definition structure for a channel can resemble the following YAML content, which defines a namespace type channel:

```yaml
apiVersion: apps.open-cluster-management.io/v1
kind: Channel
metadata:
  name: predev-ch
  namespace: ns-ch
  labels:
    app: nginx-app-details
spec:
  type: HelmRepo
  pathname: https://kubernetes-charts.storage.googleapis.com/
```

For more information about creating and managing channels, see [Managing channels](managing_channels.md).

## Subscriptions

As with channels, subscriptions (`subscription.apps.open-cluster-management.io`) provide you with improved continuous integration and continuous delivery capabilities for application management.

Subscriptions are sets of definitions that identify Helm charts, deployables, and other Kubernetes resources within channels by using annotations, labels, and versions. Subscriptions can point to a channel or storage location for identifying new or updated deployables. The subscription operator can then download the subscribed Helm chart, deployable, or secret directly from the storage location to target managed clusters without checking the Hub cluster first. With a subscription, the subscription operator can monitor the channel for new or updated resources instead of the Hub cluster.

The definition structure for a subscription can resemble the following YAML content:

```yaml
apiVersion: apps.open-cluster-management.io/v1
kind: Subscription
metadata:
  name: nginx
  namespace: ns-sub-1
  labels:
    app: nginx-app-details
spec:
  channel: ns-ch/predev-ch
  name: nginx-ingress
  packageFilter:
    version: "1.36.x"
  placement: # See the following section for information
    placementRef:
      kind: PlacementRule
      name: towhichcluster
  overrides: # See Deployable documentation
  - clusterName: "/"
    clusterOverrides:
    - path: "metadata.namespace"
      value: default
```

For more information about creating and managing subscriptions, see [Managing subscriptions](managing_subscriptions.md).

## Placement rules

Placement rules (`placementrule.apps.open-cluster-management.io`) define the target clusters where deployables can be deployed. Use placement rules to help you facilitate the multi-cluster deployment of your deployables.

The custom resource definition (CRD) and controller for placement rules replaces the placement policies that were used for applications in previous versions of Red Hat Advanced Cluster Management for Kubernetes. Placement policies are still used for governance and risk policies.

Placement rules can be defined for subscriptions and for deployables. Define the placement rule at the subscription level for multi-cluster deployments. Define the placement rule for a specific deployable for single-cluster deployments or to override placement settings.  

The definition structure for a placement rule can resemble the following YAML content:

```yaml
apiVersion: apps.open-cluster-management.io/v1
kind: PlacementRule
metadata:
  name: towhichcluster
  namespace: ns-sub-1
spec:
  clusterSelector: {}
```

For more information about creating and managing placement rules, see [Managing placement rules](managing_placement_rules.md).
