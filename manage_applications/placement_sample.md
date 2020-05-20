
# Placement rule samples

Placement rules (`placementrule.apps.open-cluster-management.io`) define the target clusters where deployables can be deployed. Use placement rules to help you facilitate the multi-cluster deployment of your deployables.  

## Placement rule YAML structure

The following YAML structure shows the required fields for a placement rule and some of the common optional fields. Your YAML structure needs to include some required fields and values. Depending on your application management requirements, you might need to include other optional fields and values. You can compose your own YAML content with any tool.

```yaml
apiVersion: apps.open-cluster-management.io/v1
kind: PlacementRule
  name:
  namespace:
  resourceVersion:
  labels:
    app:
    chart:
    release:
    heritage:
  selfLink:
  uid:
spec:
  clusterSelector:
    matchLabels:
      datacenter:
      environment:
  clusterReplicas:
  clusterConditions:
  ResourceHint:
    type:
    order:
  Policies:
```
## Placement rule YAML values table 

|Field|Description|
|-- | -- |
| apiVersion | Required. Set the value to `apps.open-cluster-management.io/v1`. |
| kind | Required. Set the value to `PlacementRule` to indicate that the resource is a placement rule. |
| metadata.name | Required. The name for identifying the placement rule. |
| metadata.namespace | Required. The namespace resource to use for the placement rule. |
| metadata.resourceVersion | Optional. The version of the placement rule resource. |
| metadata.labels | Optional. The labels for the placement rule. |
| spec.clusterSelector | Optional. The labels for identifying the target clusters |
| spec.clusterSelector.matchLabels | Optional. The labels that must exist for the target clusters. |
| status.decisions | Optional. Defines the target clusters where deployables are placed. |
| status.decisions.clusterName | Optional. The name of a target cluster |
| status.decisions.clusterNamespace | Optional. The namespace for a target cluster. |
| spec.clusterReplicas | Optional. The number of replicas to create. |
| spec.clusterConditions | Optional. Define any conditions for the cluster. |
| spec.ResourceHint | Optional. If more than one cluster matches the labels and values that you provided in the previous fields, you can specify a resource specific criteria to select the clusters. For example, you can select the cluster with the most available CPU cores. |
| spec.ResourceHint.type | Optional. Set the value to either `cpu` to select clusters based on available CPU cores or `memory` to select clusters based on available memory resources. |
| spec.ResourceHint.order | Optional. Set the value to either `asc` for ascending order, or `desc` for descending order. |
| spec.Policies | Optional. The policy filters for the placement rule. |
{: caption="Table 1. Required and optional definition fields" caption-side="top"}

## Placement rule sample files

Existing placement rules can include the following fields that indicate the status for the placement rule. This status section is appended after the `spec` section in the YAML structure for a rule.

```  
status:
  decisions:
    clusterName:
    clusterNamespace:
```

|Field|Description|
|-- | -- |
| status | The status information for the placement rule. |
| status.decisions | Defines the target clusters where deployables are placed. |
| status.decisions.clusterName | The name of a target cluster |
| status.decisions.clusterNamespace | The namespace for a target cluster. |
{: caption="Table 2. Status definition fields" caption-side="top"}

- Example 1

```yaml
apiVersion: apps.open-cluster-management.io/v1
kind: PlacementRule
metadata:
  name: gbapp-gbapp
  namespace: development
  labels:
    app: gbapp
spec:
  clusterSelector:
    matchLabels:
      environment: Dev
  clusterReplicas: 1
status:
  decisions:
    - clusterName: local-cluster
      clusterNamespace: local-cluster
```

- Example 2

```YAML
apiVersion: apps.open-cluster-management.io/v1
kind: PlacementRule
metadata:
  name: towhichcluster
  namespace: ns-sub-1
  labels:
    app: nginx-app-details
spec:
  clusterReplicas: 1
  clusterConditions:
    - type: OK
  clusterSelector:
    matchExpressions:
    - key: environment
      operator: In
      values:
      - dev
```
