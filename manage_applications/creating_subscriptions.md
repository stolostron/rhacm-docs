## Creating a subscription

1. Compose the definition YAML content for your subscription. For more information about YAML structure and samples, see [Application resource samples](app_resource_samples.md) documentation.

2. Create the subscription within Red Hat Advanced Cluster Management for Kubernetes. You can use the console, the Kubernetes CLI (`kubectl`) tool, or REST API:  

   * To use the console:

     1. Open the console.
     2. From the Navigation menu, click **Manage applications**. The **Overview** tab for all applications opens.
     3. Click the **Resources** tab.
     4. Scroll to the _Resource pipeline_ section. From the list of buttons to the right of the resource summary cards, click **Susbcription**. The _Create a Susbcription_ editor is displayed.
     5. Enter the YAML content to define your subscription or directly update the default YAML template to meet your requirements.
     6. When you are finished, click **Save** to create the subscription. Your new subscription displays within the __Resource pipeline__ for the corresponding applications and channels.

     Alternatively, you can select to create a subscription when you are working with a specific application.

     1. From the __Overview__ tab for all applications, click the application from the __All applications__ list. The __Overview__ tab for that application opens.
     2. Click the **Resources** tab for that application.
     3. Scroll to the _Resource pipeline_ section. From the list of buttons to the right of the resource summary cards, click **Susbcription**. The _Create a Susbcription_ editor is displayed.
     4. Enter the YAML content to define your subscription or directly update the default YAML template to meet your requirements.
     5. When you are finished, click **Save** to create the subscription. Your new subscription displays within the __Resource pipeline__ for the corresponding applications and channels.

     **Note:** The subscription might not initially display in your resource pipeline for any application. For the subscription to be associated with an application, you need to include the appropriate values in your subscription definition to match the required values that are defined by the application definition. For more information, see [Matching a subscription to an application](#matching-a-subscription-to-an-application).

   * To use the Kubernetes CLI tool:

     1. Run the following command to apply your file to an apiserver. Replace `filename` with the name of your file:

        ```
        kubectl apply -f filename.yaml
        ```

     2. Verify that your subscription resource is created, by running the following command:

        ```
        kubectl get Subscription
        ```

        Ensure that your new subscription is listed in the resulting output.

   * See the [Subscription API](../apis/subscriptions.json).

After your subscription is created, your subscription can have one of the following statuses:

* `Subscribed` (managed clusters only)

  The subscription has successfully subscribed to the specified resources and the resources are deployed.

* `Propagated` (hub cluster only)
  
  The subsequent subscriptions based on your specified `spec.placement` setting are generated for deployment to the appropriate managed clusters, if any. However, the subscriptions might not actually be deployed.

* `Failed`
  The subscription failed to subscribe to the specified resources.

* `No status`

  The subscription operator is either not online, or the `spec.placement` setting for the subscription is missing.

If you created the subscription for a multi-cluster environment, the subscription is created on the Hub cluster. Depending on your `spec.placement` settings, the subsequent placement of your subscription on other clusters is different. If you include more than one placement setting within the `spec.placement` section, the subscription operator uses the following priority to select the placement setting to use:
  
* `spec.placement.placementRef`

  The subscription is placed on the clusters that are identified by the specified `PlacementRule` resource.

* `spec.placement.clusters`

  The subscription is placed on the clusters that are specified as the value for this field.

* `spec.placement.clusterSelector`

  The subscription is placed on the clusters that match the specified label selector that is defined as the value for this field.

If you created your subscription on a stand-alone cluster or a cluster that you want to manage directly, the subscription is created on only that cluster. Depending on the value that you set for the `spec.placement.local` field within the subscription definition, the subsequent behavior of your subscription is different.

* `true`

  The subscription synchronizes with the specified channel that is local to that cluster.

* `false`

  The subscription does not subscribe to any resources from the specified channel.