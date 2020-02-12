---

copyright:
  years: 2019
lastupdated: "2019-09-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating an {{site.data.keyword.iks}} cluster

Follow the procedure to create an {{site.data.keyword.iks}} cluster. For more information about {{site.data.keyword.iks}}, see [Getting started with {{site.data.keyword.iks}} ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://console.bluemix.net/docs/containers/container_index.html#container_index).
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

* You must have an {{site.data.keyword.cloud_pak_mcm}} hub deployed.

* You need to install the Kubernetes CLI, `kubectl`. To install `kubectl`, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md). 

* You need internet access so that your {{site.data.keyword.cloud_pak_mcm}} cluster can create a remote Kubernetes cluster by using {{site.data.keyword.iks}}.

* You need an IBM Cloud API key. See [Managing identity and access ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.ibm.com/docs/iam?topic=iam-userapikey#userapikey).

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

   **Note:** If you already have a cluster that you want to import into a managed cluster, click the import option.

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

  You must add a label even if the label belongs to another cluster. Labels are not assigned automatically across clusters.

13. Click **Create**. When you create a cluster, you also import a cluster. You can view your cluster details after the create and import process is complete. -->

## Create your cluster with kubectl
{: #create_cli}

Complete the following procedure to create a cluster with kubectl:

1. Install the IBM Cloud CLI if did not install previously. See [Install the IBM Cloud CLI ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.ibm.com/docs/containers?topic=containers-cs_cli_install) for the installation procedure.

2. Create and save the following `.yaml` files that you need to complete the procedure:
   
  * Create and name your `apikey.yaml` file.
  * Create and name your `cluster.yaml` file.
   
3. In the `apikey.yaml` file, enter the IBM Cloud API key to ensure that you have permission to create a cluster with the API key. See [_Table 1. YAML file parameters and description_](#table_1) for details about each parameter. See the following sample file:
   
  ```
  apiVersion: v1
  kind: Secret
  metadata:
    name: <cloud-access-secret-name>
    labels:
      cloud-provider: iks
      purpose: cloud-connection
  type: Opaque
  data:
    apikey: <base64-encoded-api-key> 
  ```
  {:codeblock}
 
  - For `<cloud-access-secret-name>`, enter your secret name.
  
  - From the `data` specification, the `apikey` is a base64 encoded IBM Cloud API key.
  
  - To get the base64 encoded `apikey` value, run the following command:
  
  ```
  printf <apikey> | base64
  ```
  {:codeblock}
    
  - Enter the encoded value for `<base64-encoded-api-key>`.

4. Run the following command to apply the configuration:

  ```
  kubectl apply -f <directory>/apikey.yaml -n <namespace>
  ``` 
  {:codeblock}

5. Edit the cluster object that is defined in the `cluster.yaml` with your cluster configuration. Replace the `<cloud-access-secret-name>` with the value of the name in `apikey.yaml`. See [_Table 1. YAML file parameters and description_](#table_1) for details about each parameter. See the following sample file:

  ```
  apiVersion: "cluster.k8s.io/v1alpha1"
  kind: Cluster
  metadata:
    name: iks-cluster
    labels:
      cloud-provider: iks
  spec:
    clusterNetwork:
      services:
        cidrBlocks: ["172.32.0.0/16"]
      pods:
        cidrBlocks: ["192.168.0.0/16"]
      serviceDomain: "cluster.local"
    providerSpec:
      value:
        apiVersion: "iks/v1alpha1"
        kind: "IKSClusterProviderSpec"
        spec:
          secretName: <cloud-access-secret-name>
          zone: wdc04
          workers: 1
          machineType: b3c.4x16.encrypted
          privateVlan: 2646907
          publicVlan: 2646905
          region: us-south
          kubeVersion: 3.11.135_openshift
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
|kind|Resource type; do not edit|Cluster|
|name|Required; your cluster name|iks-cluster|
|labels:cloud-provider|Required; name of your cloud provider; do not edit|iks|
|spec:clusterNetwork|Cluster network information||
|services:cidrBlocks|Required; just a placeholder; do not edit|["172.32.0.0/16"]|
|pods:cidrBlocks|Required; just a placeholder; do not edit|["192.168.0.0/16"]|
|servicesDomian|Required; just a placeholder; do not edit|cluster.local|
|providerSpec:value|Cloud provider specific information||
|value:apiVersion|Version of cloud provider api|iks/v1alpha1|
|value:kind|Cloud provider specific resource type|IKSClusterProviderSpec|
|spec:secretName|Required; the same as the name value in apikey.yaml|none|
|spec:zone|Required; IBM Cloud zone ID where you want to create your cluster from `ibmcloud ks zone-ls`|none|
|spec:workers|Optional; number of worker nodes in the node pool; when the option is not specified, default is 1|1|
|spec:machineType|Required; IBM Cloud infrastructure Machine type for the zone from `ibmcloud ks machine-types --zone <zone_name>`|none|
|spec:privateVlan|Required; IBM Cloud infrastructure private vlan ID account for the zone from `ibmcloud regions`, values from: `ibmcloud ks vlan-ls --zone <zone_name>`|none|
|spec:publicVlan:|Required; IBM Cloud infrastructure public vlan ID account for the zone from `ibmcloud regions`, values from: `ibmcloud ks vlan-ls --zone <zone_name>`|none|
|spec:region| Required values from: `ibmcloud regions`; region of the resource group|none|
|spec:kubeVersion|Optional value of the Kubernetes version for the cluster master node, from: `ibmcloud ks versions`; if not specified, defaults to the latest supported Kubernetes versions|none|
{: caption="Table 1. YAML file parameters and descriptions" caption-side="top"}

## Accessing your cluster
{: #access}

After you installed your cluster, you can access your cluster by using the `kubeconfig` file or cluster portal.

1. Run the following command to get the secret:

  ```
  kubectl get secret -n <namespace>
  ```
  {: codeblock}
  
  See the following example output:
  
  ```
  NAME                         TYPE     DATA   AGE
  <cluster-name>-<cluster-id>  Opaque   3      4m41s
  ```
  {: pre}

2. Generate the kubeconfig to access the cluster that you created. Run the following command:

  ```
  kubectl get secrets/<cluster-name>-<cluster-id> -n <namespace> -o 'go-template={{index .data "kubeconfig"}}' | base64 --decode > <directory>/kubeconfig
  ```
  {: codeblock}

3. Run the following command to access your cluster by endpoint: 
   
  ```
  kubectl describe cluster.cluster.k8s.io/<cluster-name> -n <namespace>
  ```
  {: codeblock}
  
  URL example: `https://<Cluster Master Host>:<Cluster Master API Port>`

4. Set the `KUBECONFIG` environment variable with the following command:

  ```
  export KUBECONFIG=<directory>/kubeconfig
  ```
  {: codeblock}
  
## Deleting your cluster
{: #delete}

1. Run the following command to get your cluster:
   
  ```
  kubectl get cluster.cluster.k8s.io/<cluster-name>
  ```
  {: codeblock}

2. Run the following command to delete the cluster:

  ```
  kubectl delete cluster.cluster.k8s.io/<cluster-name> -n <namespace>
  ```
  {: codeblock}

  For more information about the delete command options, run `kubectl delete --help`.

View your cluster in the {{site.data.keyword.cloud_pak_mcm}} {{site.data.keyword.gui}}. To scale your cluster, see [Scaling your cluster](scale_mcm.md).
