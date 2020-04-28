# Deployables samples

Deployables (`deployable.apps.open-cluster-management.io`) are Kubernetes resources that contain templates to wrap other Kubernetes resources or represent Helm releases for deployment to clusters to create or manage applications.

Deployables are used to wrap other resources to prevent actions from being run against the resources by Kubernetes and other controllers before the resources are placed on target clusters. By wrapping the resources, deployables can be directly deployed to one or more target clusters from the hub cluster where the deployable source is stored. When the deployables are on the target cluster or clusters, the resources are unwrapped so that required actions can then run against the resources.

The placement, overrides, and dependencies for deployables are defined within the spec for the deployables. The placement for deployables can also be defined within a subscription, such as for multi-cluster deployments.

The definition structure for a deployable can resemble the following YAML content:

```yaml
apiVersion: apps.open-cluster-management.io/v1
kind: Deployable
metadata:
  annotations:
    apps.open-cluster-management.io/is-local-deployable: "false"
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
