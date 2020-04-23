# Creating and managing channels

Create and use channels when you need to improve the continuous integration and delivery capabilities for creating and managing your Red Hat Advanced Cluster Management for Kubernetes applications. Channels are custom resource definitions that can help you streamline deployments and separate cluster access.
{:shortdesc}

Channels (`channel.apps.open-cluster-management.io`) define a namespace within the hub cluster and point to a physical place where resources are stored for deployment. There are four types of channels. Each channel differs based on the type of source location where resources are stored:  

* Kubernetes namespace (`Namespace`)  
  Uses deployables to store Kubernetes resource templates. Subscription for this type of channel retrieves and deploys the template. The namespaces that the channel monitors for new or updated deployables must be on the hub cluster.

* Object store (`ObjectBucket`)  
  Stores Kubernetes resource YAML files. Each YAML file includes the template portion for one resource, not the full deployable object. An object store can be populated with a deployable object that is on the hub cluster or directly from a continuous integration pipeline, or by including the required YAML files into the object store.

* Helm repository (`HelmRepo`)  
  Stores Helm charts. For information about how to structure your charts, see [Helm documentation](https://helm.sh/docs/).

* GitHub repository (`GitHub`)  
  Stores Kubernetes resources YAML files and unpackaged Helm charts. These resources do not need to be wrapped or represented as deployables. The channel controllers synchronize resources as deployables automatically.

Channels are created on the hub cluster by pointing to the location where resources are stored, such as a bucket within an object store, a Helm repository, a GitHub repository, or a namespace on the hub cluster. Channels are defined with a `Channel` custom resource definition (CRD)

Channels reside in their own namespace for role-based access control. The channel namespace is made available to a subscription operator on managed clusters when the cluster subscribes to the channel. The operator can then get the secrets to access the actual channel. The operator needs this access to check whether a deployable meets the channel requirements.

For more information about deployables and other application resources, see [Application resources](app_resources.md).

The channel type can be specified with the `spec.sourceNamespaces` and `spec.type` fields of a channel spec. When a channel is created and pointing to a source, the channel controller maintains the promotion of the deployables at the source. The controller also synchronizes the source and channel namespaces.

  * [Create a channel](#create-a-channel)
  * [Update a channel](#update-a-channel)
  * [Delete a channel](#delete-a-channel)
  * [Managing deployments with channels](#managing-deployments-with-channels)
  * [Channel status and synchronization](#channel-status-and-synchronization)
  * [Channel definition YAML structure](#channel-definition-yaml-structure)
  * [Example channel YAML](#example-channel-yaml)

## Create a channel

1. Compose your channel definition YAML content. To create or update a channel resource, you must first compose the YAML file that defines the resource. For more information about the YAML structure, including the required fields, see [Channel definition YAML structure](#channel-definition-yaml-structure).

2. Optional. If you are creating an `Namespace` type channel, create the namespace on your hub cluster. You can define the namespace as part of your YAML definition or use the Kubernetes command line interface (`kubectl`) tool to create the namespace.
  
   To use the Kubernetes CLI tool, run the following command. Replace `namespace name` with the name for your new namespace.

   ```
   kubectl create namespace <namespace name>
   ```

3. Optional. If you need or want to use a Kubernetes Secret for authenticating the access to a repository or chart by the channel, create the Kubernetes Secret resource. You can use the Kubernetes command line interface (`kubectl`) tool to create the Kubernetes Secret by running the following command:

    ```
    kubectl create secret <secret name> generic --from-literal=user --from-literal=password=
    ```

   You can use a secret for authentication with only `HelmRepo`, `ObjectBucket`, and `GitHub` type channels. To associate a secret with a channel, include the `spec.secretRef.name` setting in your channel YAML definition.

4. Create the channel within Red Hat Advanced Cluster Management for Kubernetes. You can use the console, the Kubernetes command line interface (`kubectl`) tool, or REST API:  

   * To use the console,

     1. From the Navigation menu, click **Manage applications**. The **Overview** tab for all applications opens.
     2. Click the **Resources** tab.
     3. Scroll to the _Resource pipeline_ section. From the list of buttons, find and click **Channel**. The _Create a Channel_ editor is displayed.
     4. Enter the YAML content to define your channel or directly update the default YAML template to meet your requirements.
     5. When you are finished, click **Save** to create the channel. Your new channel displays within the __Resource pipeline__ for the corresponding applications.

     Alternatively, you can select to create a channel when you are working with a specific application.

     1. From the __Overview__ tab for all applications, click the application from the __All applications__ list. The __Overview__ tab for that application opens.
     2. Click the **Resources** tab for that application.
     3. Scroll to the _Resource pipeline_ section. From the list of buttons to the right of the resource summary cards, click **Channel**. The _Create a Channel_ editor is displayed.
     4. Enter the YAML content to define your channel or directly update the default YAML template to meet your requirements.
     5. When you are finished, click **Save** to create the channel. Your new channel displays within the __Resource pipeline__ for the application.

   * To use the Kubernetes CLI tool,

     1. Compose and save your channel YAML file with your preferred editing tool.
     2. Run the following command to apply your file to an apiserver. Replace `filename` with the name of your file:

        ```
        kubectl apply -f filename.yaml
        ```

     3. Verify that your channel resource is created, by running the following command:

        ```
        kubectl get Channel
        ```

        Ensure that your new channel is listed in the resulting output.

   * To use REST API, you need to use the [channel POST API](../apis/channels.json).

## Update a channel

1. Compose the definition updates for your channel. For more information about the YAML structure, including the required fields, see [Channel definition YAML structure](#channel-definition-yaml-structure).

2. Update the definition. You can use the console, the Kubernetes command line interface (`kubectl`) tool, or REST API:

   * To use the console,

       1. Open the console.
       2. From the Navigation menu, click **Manage applications**. The **Overview** tab for all applications opens.
       3. Click the **Resources** tab.
       4. Scroll down the page to **Resource pipeline** section. Click the **YAML** edit icon for channel that you want to update. The __Edit channel__ window opens.
       5. Edit the YAML for the channel.
       6. When you are finished, click **Save** to update the channel.

     You can also use the console search to find and edit a channel:
       1. From the Navigation menu, click **Search**.  
       2. Within the search box, filter by `kind:channel` to view all channels.
       3. Within the list of all channels, click the channel that you want to update. The YAML for the channel is displayed.
       4. Click **Edit** to enable editing the YAML content.
       5. When you are finished your edits, click **Save**. Your changes are saved and applied automatically.

   * To use the Kubernetes CLI tool, the steps are the same as for creating a channel.

   * To use REST API, use the [channel PATCH API](../apis/channels.json).

## Delete a channel

To delete a channel, you can use the console, the Kubernetes command line interface (`kubectl`) tool, or REST API.  

* To use the console, use the console search to find and delete a channel:

  1. Open the console.
  2. Click the _Search_ icon in the _Header_ to open the _Search_ page.
  3. Within the search box, filter by `kind:channel` to view all channels.
  4. Within the list of all channels, select the _Options_ menu for the channel that you want to delete. Click **Delete channel**.
  5. When the list of all channels is refreshed, the channel is no longer displayed.

* To use the Kubernetes CLI tool,  

  1. Run the following command to delete the channel from a target namespace. Replace `name` and `namespace` with the name of your channel and your target namespace:

     ```
     kubectl delete Channel <name> -n <namespace>
     ```

  2. Verify that your channel is deleted by running the following command:

     ```
     kubectl get Channel <name>
     ```

* To use REST API, use the [channel DELETE API](../apis/channels.json).

## Managing deployments with channels

You can use channels and subscriptions to manage the continuous delivery of deployables, such as Helm charts and Kubernetes deployable objects, to your managed clusters or other namespaces.

When a channel points to a Helm repository, the channel operator creates a deployable to represent each Helm release that is found in the repository.  

For Kubernetes deployable objects, you can add the objects to a channel by wrapping them as deployables.

Within the deployable definition you can directly specify a channel where the deployable is to be promoted. You can also specify the required Kubernetes labels for the deployable to match the gate requirements for a channel to have the deployable automatically added to a channel. When the channel controller detects that the deployable includes the required Kubernetes labels, the controller promotes the deployable to the channel.

When creating a `Namespace` and `ObjectBucket` channel, you can set the channel gate requirements within the `spec.gates` section of the channel definition. These requirements are Kubernetes annotations that a deployable must include before the deployable can be promoted to the channel. For instance, you can specify annotations for development approvals, test and quality assurance approval, and to indicate a deployable is ready for deployment to a production environment cluster. These gate requirements can be any field and value, such as the source namespace, package name, labels, and annotations. A deployable can be promoted in a channel only when the deployable definition includes the matching fields and values. When a deployable meets the defined requirements, the deployable is automatically promoted to the channel and deployed to any managed clusters that subscribe to the channel. Gate requirements do not apply for `HelmRepo` and `GitHub` channel types.

For channels that do not include gate requirements, the channel controller promotes the latest version of a deployable to the channel.  

Clusters can subscribe to channels for identifying the deployables to deploy to each cluster. Deployables that are promoted to a channel can be accessed by only the subscriptions for that channel. When channels and subscriptions exist, the channels and subscriptions work together to retrieve deployables from the channel source and place the deployables at the destination. The destination is typically a managed cluster, which is abstracted as a namespace. A managed cluster or namespace can subscribe to multiple channels for identifying the deployables to deploy to the cluster. Channels ensure that the correct deployable is available for retrieval. Subscriptions ensure that the deployable is retrieved and placed on the destination namespaces or clusters. For retrieving a deployable, the subscription operator checks the annotation limits and determines whether to retrieve and apply the deployable to the managed cluster.

## Channel status and synchronization

Channels do not have a status, while a subscription that subscribes to a channel does have a status. The status for a subscription reports whether the subscription is successfully propagated on the hub cluster, and whether the subscription successfully created or applied a deployable template or created the helmRelease CR. The status for the deployables that are deployed through the use of channels and subscriptions are reported separately from the subscription.

Since channels do not have a status, the resources that are promoted to a channel namespace are not always synchronized with the actual channel storage.

When a deployable is included within a channel or updated, the subscription operator for the channel detects the new or updated deployable automatically. You do not need to issue any notification from the hub cluster to the target managed clusters.

For a subscription to a namespace type channel, resources are synchronized for a managed cluster only while the cluster can access the channel namespace. Since the channel source exists on the hub cluster, the subscription can only pull the resources from the source when access to the hub cluster exists.

For subscriptions to Helm repository and object store type channels, the subscription watches the channel source repositories for new or updated Helm charts or deployables. The subscriptions do not need to communicate with the hub cluster unless the source repository is on the hub cluster. If subscriptions are set up to pull the latest version for a Helm release or deployable object, and new versions are included in the repository types, the subscriptions can retrieve the versions.  

## Channel definition YAML structure

The following YAML structures show the required fields for a channel and some of the common optional fields. Your YAML structure needs to include some required fields and values. Depending on your application management requirements, you might need to include other optional fields and values. You can compose your own YAML content with any tool.

```yaml
apiVersion: apps.open-cluster-management.io/v1
kind: Channel
metadata:
  name:
  namespace:
spec:
  sourceNamespaces:  
  type:
  pathname:
  secretRef:
    name:
  gates:
    annotations:
  labels:
```

|Field|Description|
|-- | -- |
| apiVersion | Required. Set the value to `apps.open-cluster-management.io/v1`. |
| kind | Required. Set the value to `Channel` to indicate that the resource is a channel. |
| metadata.name | Required. The name of the channel. |
| metadata.namespace | Required. The namespace for the channel. |
| spec.sourceNamespaces | Optional. Identifies the namespace that the channel controller monitors for new or updated deployables to retrieve and promote to the channel. For a `Namespace` channel, the namespace must be on the hub cluster. |  
| spec.type | Required. The channel type. The supported types are: `Namespace`, `HelmRepo`, `GitHub`, and `ObjectBucket` |
| spec.pathname | Required for `HelmRepo`, `GitHub`, `ObjectBucket`, `Namespace` channels. <ul><li>For a `HelmRepo` channel, set the value to be the URL for the Helm repository.</li><li>For an `ObjectBucket` channel, set the value to be the URL for the Object store.</li><li>For a `GitHub` channel, set the value to be the HTTPS URL for the GitHub repository.</li><li>For a `Namespace` channel, set the value to be the namespace where the channel is included.</li></ul> |
| spec.secretRef.name | Optional. Identifies a Kubernetes Secret resource to use for authentication, such as for accessing a repository or chart. You can use a secret for authentication with only `HelmRepo`, `ObjectBucket`, and `GitHub` type channels. |
| spec.gates | Optional. Defines requirements for promoting a deployable within the channel. If no requirements are set, any deployable that is added to the channel namespace or source is promoted to the channel. `gates` do not apply for `HelmRepo` and `GitHub` channel types, only for `Namespace` and `ObjectBucket` channel types. |
| spec.gates.annotations | Optional. The annotations for the channel. Deployables must have matching annotations to be included in the channel. |
| spec.labels | Optional. The labels for the channel. |
{: caption="Table 1. Required and optional definition fields" caption-side="top"}

## Example channel YAML

The following YAML content defines an example for each channel type:

* [Kubernetes namespace (`Namespace`) channel](#kubernetes-namespace-namespace-channel)
* [Object store bucket (`ObjectBucket`) channel](#object-store-bucket-objectbucket-channel)
* [Helm repository (`HelmRepo`) channel](#helm-repository-helmrepo-channel)
* [GitHub (`GitHub`) repository](#github-github-repository)

### Kubernetes namespace (`Namespace`) channel

The following example channel definition abstracts a namespace as a channel that holds deployable resources. When this YAML is applied, a namespace `ch-qa` is created for the channel that is named `qa`. When created, this channel points to the source default namespace for identifying deployables. The channel controller maintains the resources at the actual namespace location and ensures that the resources are kept up-to-date.

  ```yaml
  apiVersion: apps.open-cluster-management.io/v1
  kind: Channel
  metadata:
    name: qa
    namespace: ch-qa
  spec:
    sourceNamespaces:
    - default
    type: Namespace
    pathname: ch-qa
    gates:
      annotations:
        dev-ready: approved
  ```

### Object store bucket (`ObjectBucket`) channel 

The following example channel definition abstracts an object store bucket as a channel:

```yaml
apiVersion: apps.open-cluster-management.io/v1
kind: Channel
metadata:
 name: dev
  namespace: ch-obj
spec:
 type: ObjectBucket
 pathname: [http://9.28.236.243:31311/dev] <!-- Ian please confirm this change -->
 secretRef:
   name: miniosecret
 gates:
   annotations:
     dev-ready: true
```

### Helm repository (`HelmRepo`) channel

The following example channel definition abstracts a Helm repository as a channel:

```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: hub-repo
---
apiVersion: apps.open-cluster-management.io/v1
kind: Channel
metadata:
  name: 
  namespace: hub-repo
spec:
    pathname: https://9.21.107.150:8443/helm-repo/charts
    configRef:
      name: insecure-skip-verify
    type: HelmRepo
---
apiVersion: v1
data:
  insecureSkipVerify: "true"
kind: ConfigMap
metadata:
  name: insecure-skip-verify
  namespace: hub-repo
```

The following channel definition shows another example of a Helm repository channel:

```YAML
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

### GitHub (`GitHub`) repository 

The following example channel definition shows an example of a channel for the GitHub Repository. In the following example, `secretRef` refers to the user identity used to access the GitHub repo that is specified in the `pathname`. If you have a public repo, you do not need the `secretRef`:

```yaml
apiVersion: app.ibm.com/v1alpha1
kind: Channel
metadata:
  name: hive-cluster-gitrepo
  namespace: gitops-cluster-lifecycle
spec:
  type: GitHub
  pathname: https://github.com/open-cluster-management/gitops-clusters.git
  secretRef:
    name: github-gitops-clusters
---
apiVersion: v1
kind: Secret
metadata:
  name: github-gitops-clusters
  namespace: gitops-cluster-lifecycle
data:
  user: dXNlcgo=            # Value of user and accessToken is Base 64 coded.
  accessToken: cGFzc3dvcmQ
```

