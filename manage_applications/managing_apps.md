---

copyright:
  years: 2020
lastupdated: "2020-03-09"

---

# Creating and managing application resources

Create application resources to group and view the application components that make up your overall Red Hat Advanced Cluster Management for Kubernetes multi-cluster applications.
{:shortdesc}

  * [Create an application](#app_create)
  * [Matching an application to a subscription](#subscription_app)
  * [Update an application](#app_update)
  * [Delete an application](#app_delete)
  * [View the application YAML definition](#app_compose)
  * [View an example application](#app_example)

## Create an application 
{: #app_create}

1. Compose your application definition YAML content. To create or update an application resource, you must first compose the YAML file that defines the resource. For more information about the YAML structure, including the required fields, see [Application definition](#app_compose).

2. Create the application within Red Hat Advanced Cluster Management for Kubernetes. You can use the console, the Kubernetes command line interface (`kubectl`) tool, or REST API:  

   * To use the console,
     1. Open the console.
     2. From the Navigation menu, click **Manage applications**. The **Overview** tab for all applications opens.
     3. Click **New application**. The _Create application_ window opens.
     4. Update or replace the default YAML content within the editor to define your application.
     5. When you are finished adding and editing the YAML, click **Save** to create the application. Your new application displays within the list of applications on the **Overview** tab.

   * To use the Kubernetes CLI tool,
     1. Compose and save your application YAML file with your preferred editing tool.
     2. Run the following command to apply your file to an apiserver. Replace `filename` with the name of your file:

        ```shell
        kubectl apply -f filename.yaml
        ```
        {: codeblock}

     3. Verify that your application resource is created by running the following command:

        ```shell
        kubectl get Application
        ```
        {: codeblock}

        Ensure that your new application is listed in the resulting output. 

   * To use REST API, use the [application POST API](../apis/mcm/applications.json).

## Matching a subscription to an application
{: #subscription_app}

To associate a subscription with an application, both the subscription and application must be in the same namespace so that the subscription can retrieve Helm charts, deployables, or other resources from a channel to deploy for an application.

Within the application resource definition, the definition must include `spec.componentKinds` settings to indicate that the application uses a subscription. The definition must also include `spec.selector` settings to define the labels (`matchLabels`) or expressions (`matchExpressions`) to use to match the application with the subscription.

Within the subscription resource definition, the definition must include the required values to match the labels or expressions that are defined by the application.

When the subscription is associated with an application, the subscription uses the `spec.placement` settings for the subscription or deployable to deploy any subscribed charts, deployables or other Kubernetes resources for the application.

For more information about the resource definition for an application, see [Creating and managing applications](managing_apps.md).

## Update an application
{: #app_update}

1. Compose your application definition updates. For more information about the YAML structure, including the required fields, see [Application definition](#app_compose).

2. Update the application definition. You can use the console, the Kubernetes command line interface (`kubectl`) tool, or REST API:

   * To use the console, complete the following steps:
     1. Open the console.
     2. From the Navigation menu, click **Manage applications**. The **Overview** tab for all applications opens.
     3. Within the list of all applications, find the row for the application that you want to update. For that row expand the _Options_ menu and click **Edit application**. The _Edit application_ window opens.
     4. Update the YAML content for the application.
     5. When you are finished your edits, click **Close editor**. Your changes are saved and applied automatically.

     You can also use the console search to find and edit an application:
     1. Click the _Search_ icon in the Header to open the _Search_ page.  
     2. Within the search box, filter by `kind:application` to view all applications.
     3. Within the list of all applications, click the application that you want to update. The _Overview_ page for that application opens.
     4. Click **Edit app**. The _Edit application_ window opens.
     5. Update the YAML content for the application.
     6. When you are finished your edits, click **Close editor**. Your changes are saved and applied automatically.

   * To use the Kubernetes CLI tool, the steps are the same as for creating an application.

   * To use REST API, use the [application PATCH API](../apis/mcm/applications.json).

## Delete an application
{: #app_delete}

To delete an application, you can use the console, the Kubernetes command line interface (`kubectl`) tool, or REST API:

* To use the console, complete the following steps:
  1. Open the console.
  2. From the Navigation menu, click **Manage applications**. The **Overview** tab for all applications opens.
  3. Within the list of all applications, find the row for the application that you want to delete. For that row expand the _Options_ menu and click **Delete application**. A confirmation window opens.
  4. Confirm the removal to delete the application. When the list of all applications is refreshed, the application is no longer included.
  5. When the list of all applications is refreshed, the application is no longer displayed.

  You can also use the console search to find and delete an application:
  1. From the Navigation menu, click **Search**.  
  2. Within the search box, filter by `kind:application` to view all applications.
  3. Within the list of all applications, expand the _Options_ menu for the application that you want to delete. Click **Delete application**. A confirmation window opens.
  5. Confirm the removal to delete the application. When the list of all applications is refreshed, the application is no longer included.
  6. When the list of all applications is refreshed, the application is no longer displayed.

* To use the Kubernetes CLI tool, complete the following steps:  
  1. Run the following command to delete the application from a target namespace. Replace `name` and `namespace` with the name of your application and your target namespace:
     ```
     kubectl delete Application <name> -n <namespace>     
     ```
     {: codeblock}
  2. Verify that your application resource is deleted by running the following command: 
     ```
     kubectl get Application <name>
     ```
     {: codeblock}

* To use REST API, use the [application DELETE API](../apis/mcm/applications.json).

## Application definition YAML structure
{: #app_compose}

To compose the application definition YAML content for creating or updating an application resource, your YAML structure needs to include some required fields and values. Depending on your application requirements or application management requirements, you might need to include other optional fields and values. 

The following YAML structure shows the required fields for an application and some of the common optional fields.

```yaml
apiVersion: app.k8s.io/v1beta1
kind: Application
metadata:
  name:
  namespace:
  resourceVersion:
  annotations:
  labels:
    app:
    chart:
    heritage:
    name:
    release:
spec:
  componentKinds:
  - group:
    kind:
  descriptor:
  selector:
    matchExpressions:
    - key:
      operator:
      values:
```
{: codeblock}

|Field|Description|
|-- | -- |
| apiVersion | Required. Set the value to `app.k8s.io/v1beta1`. |
| kind | Required. Set the value to `Application` to indicate the resource is an application resource. |
| metadata.name | Required. The name for identifying the application resource. |
| metadata.namespace | The namespace resource to use for the application. |
| metadata.resourceVersion | The version of the application resource. |
| metadata.annotations | Optional. The annotations for the application. |
| metadata.labels | Optional. The labels for the deployable. |
| spec.componentKinds | Optional. The list of the kinds of resources to be associated with the application. |
| spec.selector.matchExpressions | Optional. Label selectors for associating other Kubernetes resources with the application. |
| spec.selector.matchExpressions.key | Required when defining label selectors. The Kubernetes label key that a resource needs to match. |
| spec.selector.matchExpressions.values | Required when defining label selectors. The Kubernetes label values that a resource needs to match. |
{: caption="Table 1. Required and optional definition fields" caption-side="top"}

The spec for defining these applications is based on the Application metadata descriptor custom resource definition that is provided by the Kubernetes Special Interest Group (SIG). You can use this definition to help you compose your own application YAML content. For more information about this definition, see [Kubernetes SIG Application CRD community specification](https://github.com/kubernetes-sigs/application).

## Example application
{: #app_example}

```YAML
apiVersion: app.k8s.io/v1beta1
kind: Application
metadata:
  labels:
    app: nginx-app-details
  name: nginx-app-3
  namespace: ns-sub-1
spec:
  componentKinds:
  - group: app.ibm.com
    kind: Subscription
  selector:
    matchLabels:
      app: nginx-app-details
status: {}
```
{: codeblock}
