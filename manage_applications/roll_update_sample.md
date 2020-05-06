# Rolling update samples 

You can configure the deployment to occur on only a percentage of your managed clusters at a time. When the deployment on those clusters is successful, the deployment is rolled out incrementally to the remaining clusters. For more information about rolling updates, see [Managing deployables with rolling update](deployment_rollout.md).

## Rolling update YAML structure

See example YAML definitions show the required fields for deploying an update for a subscription by using a rolling update. The following definitions create a `predev-ch` channel in the `ns-ch` namespace, and a `towhichcluster` placementrule in the `ns-sub-1` to use for the subscriptions:

```yaml
---
apiVersion: v1
kind: Namespace
metadata:
  name: ns-ch
---
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
---
apiVersion: v1
kind: Namespace
metadata:
  name: ns-sub-1
---
apiVersion: apps.open-cluster-management.io/v1
kind: PlacementRule
metadata:
  name: towhichcluster
  namespace: ns-sub-1
spec:
  clusterSelector: {}
```

- The following definitions create the initial and target subscriptions. As demonstrated in the following example, the original subscription resource is `nginx-ingress` Helm chart version `1.35.x` and the target subscription is `nginx-ingress` Helm chart version `1.36.x`.

```yaml
---
apiVersion: apps.open-cluster-management.io/v1
kind: Subscription
metadata:
  name: sub-orig
  namespace: ns-sub-1
  labels:
    app: nginx-app-details
spec:
  channel: ns-ch/predev-ch
  name: nginx-ingress
  packageFilter:
    version: "1.35.x"
  placement:
    placementRef:
      kind: PlacementRule
      name: towhichcluster
  overrides:
  - clusterName: "/"
    clusterOverrides:
    - path: "metadata.namespace"
      value: default
---
apiVersion: apps.open-cluster-management.io/v1
kind: Subscription
metadata:
  name: sub-target
  namespace: ns-sub-1
  labels:
    app: nginx-app-details
spec:
  channel: ns-ch/predev-ch
  name: nginx-ingress
  packageFilter:
    version: "1.36.x"
  overrides:
  - clusterName: "/"
    clusterOverrides:
    - path: "metadata.namespace"
      value: default
```

The definition for the initial subscription does not include the required fields for using a rolling update:

```yaml
apps.open-cluster-management.io/rollingupdate-maxunavaialble: 20
apps.open-cluster-management.io/rollingupdate-target: subscription-target
```

These annotations can be added to the initial subscription with the following command:

```yaml
kubectl annotate --overwrite subscriptions.apps.open-cluster-management.io sub-orig -n ns-sub-1 apps.open-cluster-management.io/rollingupdate-target=sub-target apps.open-cluster-management.io/rollingupdate-maxunavaialble=20
```

With the annotations added, the definition for the initial subscription resembles the following YAML content:

```yaml
apiVersion: apps.open-cluster-management.io/v1
kind: Subscription
metadata:
  annotations:
    apps.open-cluster-management.io/rollingupdate-maxunavaialble: "20"
    apps.open-cluster-management.io/rollingupdate-target: sub-target
  name: subscription-orig
  namespace: ns-sub-1
spec:
  channel: ns-ch/predev-ch
  name: nginx-ingress
  packageFilter:
    version: "1.35.x"
```
