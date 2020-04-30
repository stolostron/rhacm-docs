# Channels samples

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