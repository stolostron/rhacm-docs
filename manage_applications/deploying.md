## Deploying by using channels, subscriptions, and placement rules

To set up and use channels, subscriptions, and placement rules for deployments, complete the following procedure:

1. If the channel for representing the object store, Kubernetes namespace, or Helm repository does not exist, create the channel. Ensure that you define any labels or annotations that deployables must have before they can be promoted to the channel. For more information, see [Creating and managing channels](managing_channels.md).

2. If your deployables do not exist, create your deployables. For more information, see [Creating and managing deployables](managing_deployables.md).

3. If your target cluster or clusters are not subscribed to the channel, create the subscription. For more information, see [Creating and managing subscriptions](managing_subscriptions.md).

4. Define the placement rule for the deployables that are to be deployed from the channel. For more information, see [Creating and managing placement rules](managing_placement_rules.md).

    A placement rule can be defined for a subscription and for deployables. Define the placement rule or reference to the placement rule in the subscription definition to have the rule apply to multiple deployables and clusters. Define the placement rule or reference to the rule in the deployables definitions when you do not want to have the same settings apply to all deployables for the subscription or when you want to override a subscription-level placement rule. If you are referencing a placement rule, you can also include override settings for a deployable to override some placement rule values with values specific to the deployable.

5. Optional. If you created the placement rule as a stand-alone resource, edit the definition for your subscription or deployables to reference your placement rule.

6. Edit the definition for your deployables and your channel to ensure that deployables are promoted to the channel. For more information, see [Promoting a deployable to a channel](#promoting-a-deployable-to-a-channel).

7. Use the console to monitor the status of the deployment to the target cluster or clusters for the channel.

<!-- Brandi to remove per stop ship, return for GA ## Scheduling a deployment

If you need to deploy new or changed Helm charts or other resources during only specific times, you can define subscriptions for those resources to begin deployments during only those specific times. Alternatively, you can restrict deployments from beginning during specific time windows, such as to avoid unexpected deployments during peak business hours.

For more information, see [Scheduling resource deployments for a subscription](managing_subscriptions.md#subscription_timewindow). -->

## Promoting a deployable to a channel

To promote a deployable to a channel, you can use any of the following methods:

* Point the deployable to a specific channel by configuring the `spec.channels` field within the deployable definition with the correct annotations to identify the channel.

    The `spec.channels` parameter is available for deployable (`deployable.apps.open-cluster-management.io`) resources to identify the channels where the deployable is to be promoted. The following example shows a deployable that defines the channels where the deployable is to be included.

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

  In the previous example, `packageFilter.version: "1.36.x"` indicates the specific `nginx` version `1.36.x` chart is  promoted through the channel for deployment with the subscription.

* Update the channel definition to specify channel gate requirements and update the definitions for your deployables to include the fields and values to match the gate requirements.

  Channel gate requirements are defined within the `spec.gate` section of a channel definition. If the deployable has the fields to match the channel `spec.gate` values, the deployable is promoted to the channel. In this case, the deployable does not need to point to a specific channel with the  `spec.channels` field.

### Deploying with a percentage roll out  

If you want to roll out a deployment to your target managed clusters instead of deploying to all target clusters, you can configure the deployment of a deployable or chart to only a percentage of your managed clusters at a time. For instance, you might want to roll out a deployment when you need to deploy an update but you do not want to affect all clusters at once. When the deployment is successful on a cluster, the deployment is rolled out to another cluster.

For more information, see [Deploying application resources with rolling update](deployment_rollout.md).

## Deploying by using only placement rules

If you do not want or need to use channels and subscriptions, you can still use placement rules. When you are deploying a deployable by using only a placement rule, the deployable definition can include a reference to a stand-alone placement rule resource.

In this scenario, the placement rule defines how to deploy the deployable on target clusters. This placement rule can also be referenced by other deployables so that those deployables are handled with the same deployment settings.

Alternatively, a deployable can include a placement rule definition within the deployable definition. In this scenario, the deployable does not reference any stand-alone placement rule. The placement rule definition that is defined within a deployable is not referenced and shared by other deployables.

To deploy by using a placement rule, define the placement rule for the deployable either as a stand-alone placement rule resource or as part of the deployable definition. If you define the rule as a separate resource, include the `placementRef` field in the definition for the deployable to point to the placement rule.

For more information about defining a placement rule, see [Creating and managing placement rules](managing_placement_rules.md).
