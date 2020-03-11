---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating an Azure Kubernetes Service cluster

Follow the procedure to create an Azure Kubernetes Service cluster. You can create a cluster from the Red Hat Advanced Cluster Management for Kubernetes console, or from the CLI. See [Azure Kubernetes Service](https://azure.microsoft.com/en-us/services/kubernetes-service/){:new_window} for more information about the public Kubernetes service. 
{:shortdesc}

## Supported architectures

The following hardware architectures are supported:

* Linux x86_64 <!--may require trademark-->
  
**Required user type or access level**: Cluster administrator

  - [Prerequisites](#prereq)
  - [Creating your cluster with kubectl](#create_cli)
  - [Accessing your cluster](#access)
  - [Deleting your cluster](#delete)

## Prerequisites
{: #prereq}

* You must have an Red Hat Advanced Cluster Management for Kubernetes hub deployed.

* You need internet access so that your Red Hat Advanced Cluster Management for Kubernetes cluster can create a remote Kubernetes cluster by using Azure Kubernetes Service.

* You need Azure login credentials, which include user name and password. See [azure.microsoft.com](https://azure.microsoft.com/en-ca/features/azure-portal).

* You need Azure service principals, which include `clientId`, `clientSecret`, and `tenantId`. See [azure.microsoft.com](https://docs.microsoft.com/en-us/cli/azure/create-an-azure-service-principal-azure-cli?view=azure-cli-latest#password-based-authentication){:new_window}.

* To create clusters across cloud providers with OpenShift Container Platform, run the following command to enable the namespace to pull the image from the private registry:

  ```
  oc policy add-role-to-user system:image-puller system:serviceaccount:<namespace>:default --namespace=ibmcom
  ```
  {:codeblock}
  
<!-- ## Creating your cluster with the Red Hat Advanced Cluster Management for Kubernetes console
{: #create_gui}

You can create clusters from the Red Hat Advanced Cluster Management for Kubernetes console for each of the available cloud providers.

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

1. Install the Azure CLI if you did not install previously. See [Install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest){:new_window} for the installation procedure.

2. Create and save the following `.yaml` files that you need to complete the procedure:
   
  * Create and name your `apikey.yaml` file.
  * Create and name your `cluster.yaml` file.
  
3. In the `apikey.yaml` file, enter the AKS API key information to ensure that you have permission to create a cluster with the API key. See the following values and sample `.yaml` file, then proceed to edit your file:

   - For `<cloud-access-secret-name>`, enter your secret name.
  
   - From the `data` specification, the `clientId`, `clientSecret`, and `tenantId` is retrieved from the Azure service principals, which is listed in prerequesites for this procedure. 
  
  See an example at [Azure Provider: Authenticating using a Service Principal with a Client Secret](https://www.terraform.io/docs/providers/azurerm/auth/service_principal_client_secret.html){:new_window}.

  - To get the base64 encoded clientId value, run the following command:
  
  ```
  printf <clientId> | base64
  ```
  {:codeblock}

  - Enter the encoded value for `<base64-encoded-client-id>`.
  
  - Repeat the previous procedure for `clientSecret` and `tenantId`.
   
  ```
  apiVersion: v1
  kind: Secret
  metadata:
    name: <cloud-access-secret-name>
    labels:
      cloud-provider: aks
      purpose: cloud-connection
  type: Opaque
  data:
    clientId : <base64-encoded-client-id> # printf your-client-id | base64
    clientSecret  : <base64-encoded-client-secret> # printf your-client-secret | base64
    tenantId : <base64-encoded-tenant-id> # printf your-tenant-id | base64
  ```
  {:codeblock}

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
    name: aks-cluster
    labels:
      cloud-provider: aks 
  spec:
    clusterNetwork:
      services:
        cidrBlocks: ["10.0.0.0/16"] 
      pods:
        cidrBlocks: ["10.244.0.0/16"] 
      serviceDomain: "cluster.local" 
    providerSpec:
      value:
        apiVersion: "aksprovider/v1alpha1"
        kind: "AKSClusterProviderSpec"
        spec:
          secretName: <cloud-access-secret-name> 
          location: "eastus" 
          resourceGroupName: "testAksResourceGroup" 
          nodeCount: 1 
          kubernetesVersion: "1.14.6" 
          nodeOsdiskSize: 100.
          dnsServiceIP: 10.0.0.10 
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
|apiVersion|Red Hat Advanced Cluster Management for Kubernetes api; do not edit|cluster.k8s.io/v1alpha1|
|kind|Resource type; do not edit|cluster|
|name|Required; your cluster name|aks-cluster|
|labels:cloud-provider|Required name of your cloud provider; do not edit|aks|
|spec:clusterNetwork|Cluster network information||
|services:cidrBlocks|Required, a CIDR notation IP range from which to assign service cluster IPs. Only an array size of one is supported|["10.0.0.0/16"]|
|pods:cidrBlocks|Required, a CIDR notation IP range from which to assign pod IPs when kubenet is used. only an array size of one is supported|["10.244.0.0/16"]|
|servicesDomian|Required; just a placeholder; do not edit|cluster.local|
|providerSpec:value|Cloud provider specific information||
|value:apiVersion|Version of cloud provider api|aks/v1alpha1|
|value:kind|Cloud provider specific resource type|AKSClusterProviderSpec|
|spec:secretName|Required; the same as the name value in apikey.yaml|none|
|spec:location|Required; the region of the resource group, `az account list-locations` list available locations|none|
|spec:resourceGroupName|Required, name of resource group|none|
|spec:nodeCount|Optional; number of nodes in the Kubernetes node pool|none|
|spec:kubeVersion|Optional value of the Kubernetes version for the cluster master node, from: `az aks get-versions` versions; if not specified, defaults to supported Kubernetes versions|supported version|
|spec:nodeVMSize:|Optional, size of virtual machines to create as Kubernetes nodes; see [General purpose virtual machine sizes](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general)|none|
|spec:nodeOsdiskSize|Optional; size in GB of the OS disk for each node in the node pool, minimum 30 GB|none|
|spec:dnsServiceIP|Optional IP address assigned to the Kubernetes DNS service; value must be in the range of the services cidrBlocks value|none|
{: caption="Table 1. YAML file parameters and descriptions" caption-side="top"}

## Accessing your cluster 
{: #access}

After you installed your cluster, you can access your cluster by using the `kubeconfig` file or cluster portal.

1. Run the following command to access your cluster by endpoint:
   
  ```
  kubectl describe cluster.cluster.k8s.io/<cluster-name> -n <namespace>
  ```
  {: codeblock}

  URL example: `https://<Cluster Master Host>:<Cluster Master API Port>`

2. To access your cluster using the `kubeconfig` file, run the following command to get the secret:

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

3. Generate the kubeconfig to access the cluster that you created. Run the following command:

  ```
  kubectl get secrets/<cluster-name>-<cluster-id> -n <namespace> -o 'go-template={{index .data "kubeconfig"}}' | base64 --decode > <directory>/kubeconfig
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

View your cluster in the Red Hat Advanced Cluster Management for Kubernetes console. To scale your cluster, see [Scaling your cluster](scale_mcm.md).
