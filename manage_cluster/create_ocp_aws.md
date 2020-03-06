---

copyright:
  years: 2019
lastupdated: "2019-09-23"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating an {{site.data.keyword.open_s}} cluster in Amazon Web Services (AWS)

You can use the Red Hat Advanced Cluster Management for Kubernetes console or CLI to deploy an {{site.data.keyword.open_s}} on Amazon Web Services (AWS) cluster. 
{:shortdesc}

## Supported architectures

The following hardware architectures are supported:

* {{site.data.keyword.linux_bit_notm}}
* {{site.data.keyword.ppc_notm}}
* {{site.data.keyword.s390_notm}}

**Required user type or access level**: Cluster administrator

  - [Prerequisites](#prereq)
  - [Creating your cluster with kubectl](#create_cli)
  - [Accessing your cluster](#access)
  - [Deleting your cluster](#delete)
 
## Prerequisites
{: #prereq}

* You must have an Red Hat Advanced Cluster Management for Kubernetes hub deployed.
  
* You need to install the Kubernetes CLI, `kubectl`. To install `kubectl`, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md). 

* You need internet access so that your Red Hat Advanced Cluster Management for Kubernetes cluster can create a remote Kubernetes cluster by using Amazon Web Services.

* You need Amazon Web Services (AWS) login credentials, which include user name, password, access key ID, and secret access key. See [Understanding and Getting Your Security Credentials ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html){:new_window}.

* You need an {{site.data.keyword.open_s}} image pull secret. See [Image Pull Secrets ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.openshift.com/enterprise/3.0/dev_guide/image_pull_secrets.html){:new_window}.

* To create clusters across cloud providers with {{site.data.keyword.open_s}}, run the following command to enable the namespace to pull the image from the private registry:

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

  You must add a label even if the label belongs to another cluster. Labels are not assigned automatically across clusters.

13. Click **Create**. When you create a cluster, you also import a cluster. You can view your cluster details after the create and import process is complete. -->

## Creating your cluster with kubectl
{: #create_cli}

Complete the following procedure to create a cluster with kubectl:

1. Create and save the following  `.yaml` files that you need to complete the procedure:
   
   * Create and name your `apikey.yaml` file.
   * Create and name your `pullsecret.yaml` file.
   * Create and name your `cluster.yaml` file.

2. In the `apikey.yaml` file, enter the Amazon Web Services (AWS) cloud API key information to ensure that you have permission to create a cluster with the API key. Here, `awsAccessKeyID` is your AWS ID and `awsSecretAccessKey` is your AWS key. See [_Table 1. YAML file parameters and description_](#table_1) for details about each parameter. See the following sample file:
   
  ```
  apiVersion: v1
  kind: Secret
  metadata:
    name: <cloud-access-secret-name>
  namespace: ocp-provider-system
  labels:
    cloud-provider: ocp
    purpose: cloud-connection
  type: Opaque
  data:
    awsAccessKeyID: <base64-encoded-key-id> # echo -n your-aws-id | base64
    awsSecretAccessKey: <base64-encoded-access-key> # echo -n your-aws-key | base64
  ```
  {:codeblock}
  
  - For `<cloud-access-secret-name>`, enter your secret name.
  
  - From the `data` specification, the `awsAccessKeyID` and `awsSecretAccessKey` are the base64 encoded AWS API keys.
   
  - To get the base64 encoded `awsAccessKeyID` and `awsSecretAccessKey` values, run the following command:
  
  ```
  printf <apikey> | base64
  ```
  {:codeblock}

  - Use the encoded value to replace the `<base64-encoded-key-id>` and `<base64-encoded-access-key>`.
  
3. Run the following command to apply the configuration:

  ```
  kubectl apply -f <directory>/apikey.yaml -n <namespace>
  ``` 
  {:codeblock}

4. In the `pullsecret.yaml` file, enter the {{site.data.keyword.open_s}} pull secret information to ensure that the images can be pulled. 

See the following sample `.yaml` file, where `name` is your pull secret name and `pullSecret` is your pull secret value:

  ```
  apiVersion: v1
  kind: Secret
  metadata:
    name: <pull-secret-name>
    namespace: ocp-provider-system
    labels:
      cloud-provider: ocp
  type: Opaque
  data:
    pullSecret: <base64-encoded-pull-secret> # echo -n your-pull-secret | base64
  ```
  {:codeblock}
 
  The `<pull-secret-name>` is your pull secret name, which is similar to apikey and must be base64 encoded.
  
5. Run the following command to apply the pull secret:

  ```
  kubectl apply -f <directory>/pullsecret.yaml -n <namespace>
  ```
  {:codeblock}

6. Edit the cluster object that is defined in `cluster.yaml` with your Amazon Web Services (AWS) cluster configuration. Replace the `<cloud-access-secret-name>` and `<pull-secret-name>` with the value of the name in `apikey.yaml` and `pullsecret.yaml`. See [_Table 1. YAML file parameters and description_](#table_1) for details about each parameter. See the following sample file:
 
  ```
  apiVersion: "cluster.k8s.io/v1alpha1"
  kind: Cluster
  metadata:
    name: ocp-cluster
    namespace: ocp-provider-system
    labels:
      cloud-provider: ocp
  spec:
    clusterNetwork:
      services:
        cidrBlocks: ["10.96.0.0/16"]
      pods:
        cidrBlocks: ["192.168.0.0/16"]
    providerSpec:
      value:
        apiVersion: ocpprovider/v1alpha1
        kind: OCPClusterProviderSpec
        platform:
          aws:
            region: us-west-1
            type: m5.xlarge
        baseDomain: example.com  
        sshPublicKey: 
        secretName: <cloud-access-secret-name>
        pullSecretName: <pull-secret-name>
        networkType: OpenShiftSDN
        machineCIDR: 10.0.0.0/16
        controlplane:
          replicas: 3
          hyperthreading: Enabled
          name: master
          platform:
              aws:
                type: m5.xlarge
        compute:
          - replicas: 3
            hyperthreading: Enabled
            name: worker
            platform:
              aws:
                type: m5.xlarge
  ```
  {: codeblock}

7. Run the following command to apply the cluster object:

  ```
  kubectl apply -f <directory>/cluster.yaml -n <namespace>
  ```
  {: codeblock}

8. Depending on your specifications, it can take up to 30 minutes to create a cluster. Run the following command to see the status:

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
|kind|Resource type; do not edit|Cluster|
|Name|Required; your cluster name|ocp-cluster|
|labels: cloud-provider|Required name of your cloud provider; do not edit|ocp|
|spec:clusterNetwork|Cluster network information||
|services:cidrBlocks|Required; A block of IP addresses|[172.30.0.0/16]
|Pods:cidrBlocks|Required; A block of IP addresses|[10.128.0.0/14]|
|providerSpec:value|Cloud provider specific information||
|value:apiVersion|Version of cloud provider api|ocpprovider/v1alpha1|
|value:kind|Cloud provider specific resource type|OCPClusterProviderSpec|
|platform:aws|Default platform information for your cluster||
|aws:region|Required; AWS zone ID where you want to create your cluster, from [AWS General Reference  ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.aws.amazon.com/general/latest/gr/rande.html)|none|
|aws:type|Optional, the EC2 instance type for the machines from [Amazon EC2 Instance Types ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://aws.amazon.com/ec2/instance-types/); use this information for every `type` specification||
|baseDomain|Required; The base domain of your cloud provider|purple-chesterfield.com|
|sshPublicKey|Optional. The SSH key to use to access your cluster machines.||
|secretName|Required; the same as the name value in apikey.yaml|none|
|pullsecretName|Required; the same as the name value in pullsecret.yaml|none|
|networkType|Required. The network plug-in to deploy.|OpenShiftSDN|
|machineCIDR|Required. A block of IP addresses used by the OpenShift Container Platform installation program while installing the cluster.|10.0.0.0/16|
|controlplane|Required for cloud provider to host the control plane machines; this parameter value must match the `compute.platform`parameter value|none|
|controlplane:replicas|Optional; a positive integer greater than or equal to three|3|
|controlplane:hyperthreading|Optional, whether to enable or disable simultaneous multithreading, or hyperthreading on compute machines|enabled|
|controlplane:name|Required;|master|
|controlplane:hyperthreading|Optional, whether to enable or disable simultaneous multithreading, or hyperthreading on compute machines|enabled|
|compute|Required; the cloud provider to host the worker machines| This parameter value must match the `controlPlane.platform` parameter value|none|
|compute:replicas|Optional; a positive integer greater than or equal to 2, different from controlPlane|3|
|compute:hyperthreading|Optional, whether to enable or disable simultaneous multithreading, or hyperthreading on compute machines|enabled|
{: caption="Table 1. YAML file parameters and descriptions" caption-side="top"}

## Accessing your cluster 
{: #access}

After you installed your cluster, you can access your cluster by using the `kubeconfig` file or {{site.data.keyword.open_s}} cluster portal.

1. Run the following command to get the secret:

  ```
  $ kubectl get secret -n <namespace>
  ```
  {: codeblock}
  
  See the following example output:
  
  ```
  NAME                      TYPE                                  DATA   AGE
  <cluster-name>-<cluster-id>  Opaque                                3      4m41s
  ```
  {: pre}

2. Generate the Kubeconfig to access the cluster that you created. Run the following command:

  ```
  kubectl get secrets/<cluster-name>-<cluster-id> -o 'go-template={{index .data "kubeconfig"}}' | base64 --decode > <directory>/kubeconfig
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
  $ export KUBECONFIG=<directory>/kubeconfig
  ```
  {: codeblock}

## Deleting your cluster
{: #delete}

1. Run the following command to get your cluster:
   
  ```
  $ kubectl get cluster.cluster.k8s.io/<cluster-name> -n <namespace>
  ```
  {: codeblock}

2. Run the following command to delete the cluster:

  ```
  kubectl delete cluster.cluster.k8s.io/<cluster-name> -n <namespace>
  ```
  {: codeblock}

  For more information about the delete command options, run `kubectl delete --help`.

View your cluster in the Red Hat Advanced Cluster Management for Kubernetes console. To scale your cluster, see [Scaling your cluster](scale_mcm.md).
