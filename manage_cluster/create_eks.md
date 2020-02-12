---

copyright:
  years: 2019
lastupdated: "2019-11-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating an Amazon Elastic Kubernetes Service cluster

Follow the procedure to create an Amazon Elastic Kubernetes Service cluster. You can create a cluster from the {{site.data.keyword.gui}}, or from the CLI. See [Amazon Elastic Kubernetes Service ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://aws.amazon.com/eks/){:new_window} for more information about the public Kubernetes service.
{:shortdesc}

## Supported architectures

The following hardware architectures are supported:

{{site.data.keyword.linux_bit_notm}}
  
**Required user type or access level**: Cluster administrator

  - [Prerequisites](#prereq)
  - [Creating your cluster with kubectl](#create_cli)
  - [Accessing your cluster](#access)
  - [Deleting your cluster](#delete)

## Prerequisites
{: #prereq}

* You must have an hub cluster deployed.

* You need to install the Kubernetes CLI, `kubectl`. To install `kubectl`, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).

* You need to install the `aws-iam-authenticator` to access your targeted managed cluster with the kubeconfig. See [Installing aws-iam-authenticator ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html){:new_window}.

* You need internet access so that your hub cluster can create a remote Amazon Elastic Kubernetes Service cluster.

* You need Amazon Web Services (AWS) login credentials, which include user name, password, access key ID, and secret access key. See [Understanding and Getting Your Security Credentials ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html){:new_window}.

* To create clusters across cloud providers with {{site.data.keyword.open_s}}, run the following command to enable the namespace to pull the image from the private registry:

  ```
  oc policy add-role-to-user system:image-puller system:serviceaccount:<namespace>:default --namespace=ibmcom
  ```
  {:codeblock}
  
<!-- ## Creating your cluster with the {{site.data.keyword.cloud_pak_mcm}} {{site.data.keyword.gui}}
{: #create_gui}

You can create clusters from the {{site.data.keyword.cloud_pak_mcm}} {{site.data.keyword.gui}} for each of the available cloud providers.

1. From the navigation menu, click **Clusters**.
2. Click **Add Cluster**.
3. Choose from one of the options.
   
   You can choose to create a cluster as a managed service from a cloud provider, or you can create a cluster from infrastructure, which is a Cloud Automation Manager feature. 

   **Note:** If you already have an cluster that you want to import into a managed cluster, click the import option.

4. To create as a managed cluster, choose a cloud provider. See (new topic link here) to learn more about available cloud providers.
5. Enter a _Connection name_ and a _Connection description_. 
6. Choose a _Namespace_. The namespaces that are listed are already connected to a cloud provider. 
   
  **Note** If you do not have a namespace that is connected to a cloud provider, you can  Add click **Add connection** from the _Cloud connection_ field.

7. Configure your cloud connection. (what is service account)
   
8. Save your cloud configuration if you want to return to that configuration later. 

9. Click **Add** and continue to configure your cluster.
    
10. Enter details about your cluster in the _Configure your cluster_ details.

11. Choose a default size or customize in the YAML file. (new topic link here)

12. **Optional**: Configure advanced parameters. You can assign labels to later identify 
clusters. 

  **Note**: You must add a label even if the label belongs to another cluster. Labels are not assigned automatically across clusters.

13. Click **Create**. When you create a cluster, you also import a cluster. You can view your cluster details after the create and import process is complete. -->

## Create your cluster with kubectl
{: #create_cli}

Complete the following procedure to create a cluster with kubectl:

1. Create and save the following `.yaml` files that you need to complete the procedure:
   
  * Create and name your `apikey.yaml` file.
  * Create and name your `cluster.yaml` file.
  
2. In the `apikey.yaml` file, enter the Amazon Web Services (AWS) cloud API key information to ensure that you have permission to create a cluster with the API key. Here, `awsAccessKeyID` is your AWS access key ID and `awsSecretAccessKey` is your AWS secret access key. See [Access Keys (Access Key ID and Secret Access Key) ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html#access-keys-and-secret-access-keys){:new_window}. See [_Table 1. YAML file parameters and description_](#table_1) for details about each parameter. See the following sample file:
   
  ```
  apiVersion: v1
  kind: Secret
  metadata:
    name: <cloud-access-secret-name>
    labels:
      cloud-provider: eks
      purpose: cloud-connection
  type: Opaque
  data:
    awsAccessKeyID: <base64-encoded-aws-access-key-id> # printf your-awsAccessKeyID | base64
    awsSecretAccessKey: <base64-encoded-aws-secret-access-key> # printf your-awsSecretAccessKey | base64
  ```
  {:codeblock}
  
  - For `<cloud-access-secret-name>`, enter your secret name.
  
  - From the `data` specification, the `awsAccessKeyID` and `awsSecretAccessKey` are the base64 encoded AWS API keys.
   
  - To get the base64 encoded `awsAccessKeyID` and `awsSecretAccessKey` values, run the following command:
  
     ```
     printf <awsAccessKeyID> | base64
     printf <awsSecretAccessKey> | base64
     ```
     {:codeblock}

  - Use the encoded value to replace the `<base64-encoded-key-id>` and `<base64-encoded-access-key>`.

3. Run the following command to apply the configuration:

   ```
   kubectl apply -f <directory>/apikey.yaml -n <namespace>
   ``` 
   {:codeblock}

5. Edit the cluster object that is defined in the `cluster.yaml` with your cluster configuration. Replace the `<cloud-access-secret-name>` with the value of the name in `apikey.yaml`. See [_Table 1. YAML file parameters and description_](#table_1) for details about each parameter. See the following sample file:

   ```
   apiVersion: "cluster.k8s.io/v1alpha1"
   kind: Cluster
   metadata:
     name: <cluster-name> 
     labels:
       cloud-provider: eks 
   spec:
     clusterNetwork:
       services:
         cidrBlocks: ["10.0.0.0/16"] 
       pods:
         cidrBlocks: ["10.244.0.0/16"] 
       serviceDomain: "cluster.local" 
     providerSpec:
       value:
         apiVersion: "eksprovider/v1alpha1"
         kind: "EKSClusterProviderSpec"
         spec:
           secretName: <cloud-access-secret-name> 
           region: "us-east-2" 
           version: "1.14" # Optional. Kubernetes version.
           nodeType: "t3.medium" # Optional. AWS node instance type.
           nodes: 1 # Optional. Total number of nodes.
           nodesMin: 1 # Optional. Minimum nodes in ASG (Autoscaling Group).
           nodesMax: 2 # Optional. Maximum nodes in ASG (Autoscaling Group). 
    ```
    {: codeblock}

6. Run the following command to apply the cluster object:

   ```
   kubectl apply -f <directory>/cluster.yaml -n <namespace>
   ```
   {: codeblock}

7. Depending on your specifications, it can take up to 30 minutes to create a cluster. Run the following command to see the status:

   ```
   kubectl describe cluster.cluster.k8s.io/<cluster-name> -n <namespace>
   ```
   {: codeblock}
  
  You see `CreateClusterSuccessful` in the `Event` list when the cluster is created. 

### YAML Parameters and descriptions
{: #table_1}

Table 1: The following table lists the parameters and descriptions that are available in the YAML file:

|Parameter|Description|Default value|
|---|---|---|
|apiVersion|{{site.data.keyword.cloud_pak_mcm}} api; do not edit|cluster.k8s.io/v1alpha1|
|kind|Resource type; do not edit|cluster|
|name|Required; your cluster name|eks-cluster|
|labels:cloud-provider|Required name of your cloud provider; do not edit|eks|
|spec:clusterNetwork|Cluster network information||
|services:cidrBlocks|Required, a CIDR notation IP range from which to assign service cluster IPs. Only an array size of one is supported|["10.0.0.0/16"]|
|pods:cidrBlocks|Required, a CIDR notation IP range from which to assign pod IPs when kubenet is used. only an array size of one is supported|["10.244.0.0/16"]|
|servicesDomian|Required; just a placeholder; do not edit|cluster.local|
|providerSpec:value|Cloud provider specific information||
|value:apiVersion|Version of cloud provider api|eks/v1alpha1|
|value:kind|Cloud provider specific resource type|EKSClusterProviderSpec|
|spec:secretName|Required; the same as the name value in apikey.yaml|none|
|spec:region|Required; the AWS region|none|
|spec:version|Optional; Kubernetes version|supported version|
|spec:nodeType|Optional; AWS node instance type|none|
|spec:nodes|Optional; number of nodes in the Kubernetes node pool|none|
|spec:nodesMin|Optional; Minimum nodes in ASG (Autoscaling Group)|none|
|spec:nodesMax|Optional; Maximum nodes in ASG (Autoscaling Group)|none|
{: caption="Table| 1. YAML file parameters and descriptions" caption-side="top"}

## Accessing your cluster 
{: #access}

After you installed your cluster, you can access your cluster by using the `kubeconfig` file or cluster portal.

1. Run the following command to access your cluster by endpoint:
   
   ```
   kubectl describe cluster.cluster.k8s.io/<cluster-name> -n <namespace>
   ```
   {: codeblock}

  URL example: `https://<Cluster Master Host>:<Cluster Master API Port>`

2. If you have the `aws-iam-authenticator` installed, you can access your cluster using the `kubeconfig` file. Run the following command to get the secret:

   ```
   kubectl get secret -n <namespace>
   ```
   {: codeblock}

  See the following example output:

  ```
  NAME                         TYPE                                  DATA   AGE
  <cluster-name>-<cluster-id>  Opaque                                3      4m41s
  ```
  {: pre}

3. Generate the kubeconfig to access the cluster that you created by extracting the `kubeconfig-eks` content inside the secret. Run the following command:

   ```
   kubectl get secrets/<cluster-name>-<cluster-id> -n <namespace> -o 'go-template={{index .data "kubeconfig-eks"}}' | base64 --decode > <directory>/kubeconfig
   ```
   {: codeblock}

4. Set the `KUBECONFIG` environment variable with the following command:

   ```
   export KUBECONFIG=<directory>/kubeconfig
   ```
   {: codeblock}

## Deleting your cluster
{: #delete}

1. Run the following command to get your cluster:

   ```
   kubectl get cluster.cluster.k8s.io/<cluster-name> -n <namespace>
   ```
   {: codeblock}

2. Run the following command to delete the cluster:

   ```
   kubectl delete cluster.cluster.k8s.io/<cluster-name> -n <namespace>
   ```
   {: codeblock}

  For more information about the delete command options, run `kubectl delete --help`.

View your cluster in the {{site.data.keyword.cloud_pak_mcm}} {{site.data.keyword.gui}}. To scale your cluster, see [Scaling your cluster](scale_mcm.md).
