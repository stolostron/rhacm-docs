# Deleting a subscription

To delete a subscription, you can use the console, the Kubernetes command line interface (`kubectl`) tool, or REST API.  

* To use the console, use the console search to find and delete a subscription:

   1. Open the console.
   2. Click the **Search** icon in the _Header_.  
   3. Within the Search box, filter by `kind:subscription` to view all subscriptions.
   4. Within the list of all subscriptions, expand the _Options_ menu for the subscription that you want to delete. Click **Delete subscription**.
   5. When the list of all subscriptions is refreshed, the subscription is no longer displayed.

* To use the Kubernetes CLI tool:

  1. Run the following command to delete the subscription from a target namespace. Replace `name` and `namespace` with the name of your subscription and your target namespace:

     ```
     kubectl delete Subscription <name> -n <namespace>
     ```

  2. Verify that your subscription is deleted by running the following command:

     ```
     kubectl get Subscription <name>
     ```

* See [APIs](../apis/api.md).