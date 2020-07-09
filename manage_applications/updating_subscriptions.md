# Updating a subscription

1. Compose the definition YAML content for your subscription.

2. Create the subscription within Red Hat Advanced Cluster Management for Kubernetes. You can use the console, the Kubernetes CLI (`kubectl`) tool, or REST API:  

   * To use the console:
       1. Open the console.
       2. From the Navigation menu, click **Manage applications**. The **Overview** tab for all applications opens.
       3. Click the **Resources** tab.
       4. Scroll down the page to **Resource pipeline** section. Expand the row for the application that uses the subscription that you want to edit.
       5. For the subscription that you want to update, click the **Edit** icon for the YAML. The __Edit subscription__ window opens.
       6. Edit the YAML.
       7. When you are finished, click **Save** to update the subscription.

     Alternatively, you can select to update the subscription when you are working with a specific application.

       1. From the __Overview__ tab for all applications, click the application from the __All applications__ list. The __Overview__ tab for that application opens.
       2. Click the **Resources** tab for that application.
       3. Scroll down the page to **Resource pipeline** section.
       4. For the subscription that you want to update, click the **Edit** icon for the YAML. The __Edit subscription__ window opens.
       5. Edit the YAML.
       6. When you are finished, click **Save** to update the subscription.

     You can also use the console search to find and edit a subscription:

       1. Click the **Search** icon in the Header.  
       2. Within the search box, filter by `kind:subscription` to view all subscriptions.
       3. Within the list of all subscriptions, click the subscription that you want to update. The YAML for the subscription is displayed.
       4. Click **Edit** to enable editing the YAML content.
       5. When you are finished your edits, click **Save**. Your changes are saved and applied automatically.

   * To use the Kubernetes CLI tool, the steps are the same as for creating a subscription.

   See [APIs](https://access.redhat.com/documentation/en-us/red_hat_advanced_cluster_management_for_kubernetes/1.0/html/apis/index).
