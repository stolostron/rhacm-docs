## Deploying by using application resources

To set up and use channels, subscriptions, and placement rules for deployments, complete the following procedure:

1. If the channel to represent the object store, Kubernetes namespace, or Helm repository does not exist, create a channel. 

   Ensure that you define any labels or annotations that deployables need before they are promoted to the channel. For more information, see [Creating and managing channels](managing_channels.md).

2. Create your deployables. For more information, see [Creating and managing deployable resources](managing_deployables.md).

3. If your target cluster or clusters are not subscribed to the channel, create the subscription. For more information, see [Creating and managing subscriptions](managing_subscriptions.md).

4. Define the placement rule for the deployables that are to be deployed from the channel. For more information, see [Creating and managing placement rules](managing_placement_rules.md). A placement rule can be defined for a subscription and for deployables. 

   - Define the placement rule for a subscription to have the rule apply to multiple deployables and clusters. 
  
   - Define the placement rule for a deployable to prevent the rule from applyin to all deployables for the subscription, or when you want to override a subscription-level placement rule. 
  
   - If you are referencing a placement rule, you can also include override settings for a deployable to override some placement rule values with values specific to the deployable.

5. Optional. If you created the placement rule as a stand-alone resource, edit the definition for your subscription or deployables to reference your placement rule.

6. Edit the definition for your deployables and your channel to ensure that deployables are promoted to the channel. For more information, see the _Promoting a deployable to a channel_ section.

7. Use the console to monitor the status of the deployment to the target cluster or clusters for the channel.

<!-- Brandi to remove per stop ship, return for GA ## Scheduling a deployment

If you need to deploy new or changed Helm charts or other resources during only specific times, you can define subscriptions for those resources to begin deployments during only those specific times. Alternatively, you can restrict deployments from beginning during specific time windows, such as to avoid unexpected deployments during peak business hours.

For more information, see [Scheduling resource deployments for a subscription](managing_subscriptions.md#subscription_timewindow). -->

## Promoting a deployable to a channel

To promote a deployable, which is a _resource template_, to a channel, you can use any of the following methods:

* Point the deployable to a specific channel by configuring the `spec.channels` field within the deployable definition with the correct annotations to identify the channel.

    The `spec.channels` parameter is available for deployable (`deployable.apps.open-cluster-management.io`) resources to identify the channels where the deployable is to be promoted. The following example shows a deployable that defines the channels where the deployable is to be included:

    ```yaml
    apiVersion: apps.open-cluster-management.io/v1
    kind: Deployable
    metadata:
      name: deployable1
      namespace: default
      spec:
        template:
        placement:
        overrides:
        dependencies:
        channels:
        - mychannel
        - otherchannel
    ```

* Update the channel definition to identify the deployables to include in the channel. Use the `spec.package` and `spec.packageFilter` fields to specify the deployables.

  As an example, the following channel automatically pulls the most recent, or latest, `nginx` chart when a new chart is published to the source Helm repository for the channel. The chart deployable must have a matching version `1.x` to be promoted to the channel.

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
    ---
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
      placement:
        placementRef:
          kind: PlacementRule
          name: towhichcluster
    ```
    
* Update the subscription definition to identify the deployables. The configuration for promoting a deployable to a channel can also be specified within the subscription definition.

The following example subscription indicates that the most recent `nginx` version `1.x` chart is to be promoted through the channel for deployment with the subscription.

    ```
    apiVersion: apps.open-cluster-management.io/v1
    kind: Subscription
    metadata:
        name: mydevsub
        namespace: myspace
    spec:
      source: https://kubernetes-charts.storage.googleapis.com/
      package: nginx
      packageFilter:
        version: 1.x
      placement:
        clusters:
        - name: mydevcluster1
    ```

* Update the channel definition to specify channel gate requirements, and update the definitions for your deployables to include the fields and values to match the gate requirements.

  Channel gate requirements are defined within the `spec.gate` section of a channel definition. If the deployable has the fields to match the channel `spec.gate` values, the deployable is promoted to the channel. In this case, the deployable does not need to point to a specific channel with the `spec.channels` field.

  In the previous example, `packageFilter.version: "1.36.x"` indicates the specific `nginx` version `1.36.x` chart is promoted through the channel for deployment with the subscription.

### Deploying with a percentage roll out  

If you want to roll out a deployment to your target managed clusters instead of deploying to all target clusters, you can configure the deployment of a deployable or chart to only a percentage of your managed clusters at a time. 

For instance, you might want to roll out a deployment when you need to deploy an update but you do not want to affect all clusters at once. When the deployment is successful on a cluster, the deployment is rolled out to another cluster.

For more information, see [Managing deployables with a rolling update](deployment_rollout.md).