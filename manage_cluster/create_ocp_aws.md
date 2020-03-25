---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-25"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating an OpenShift cluster on Amazon Web Services

You can use the Red Hat Advanced Cluster Management for Kubernetes console to deploy an OpenShift cluster on Amazon Web Services (AWS). 
{:shortdesc}

  - [Prerequisites](#prereq)
  - [Creating your cluster with kubectl](#create_cli)
  - [Accessing your cluster](#access)
  - [Deleting your cluster](#delete)
 
## Prerequisites
{: #prereq}

You must have the following prerequisites before creating a cluster on AWS:

* A deployed Red Hat Advanced Cluster Management for Kubernetes hub cluster

* Internet access for your Red Hat Advanced Cluster Management for Kubernetes hub cluster so it can create a remote Kubernetes cluster by using Amazon Web Services

* AWS cloud connection created. See [Setting up a cloud connection for AWS](cloud_conn_aws.md) for more information.

* A configured domain in AWS. See [Configuring an AWS account](https://docs.openshift.com/container-platform/4.3/installing/installing_aws/installing-aws-account.html) for instructions on how to configure a domain. 

## Creating your cluster with the Red Hat Advanced Cluster Management for Kubernetes console
{: #create_gui}

To create clusters from the Red Hat Advanced Cluster Management for Kubernetes console, complete the following steps: 

1. From the navigation menu, navigate to **Automate infrastructure** -> **Clusters**.

2. On the Clusters page, Click **Add Cluster**.

3. Select **Create a cluster**. 
   
  **Note:** This procedure is for creating a cluster. If you have an existing cluster that you want to import, see [Importing a cluster in AWS](import_cluster_aws) for those steps.
  
4. Enter a name for your cluster. This name is used in the hostname of the cluster.

  **Tip:** You can view the `yaml` content updates as you enter the information in the console by setting the *YAML* switch to **ON**. 

5. Enter the base domain information that you configured for your AWS account. See [Configuring an AWS account](https://docs.openshift.com/container-platform/4.3/installing/installing_aws/installing-aws-account.html) for more information. This name is used in the hostname of the cluster.

6. Select Amazon Web Services for the infrastructure platform. See [Supported managed cloud providers](cloud_providers.md) to learn more about other available cloud providers.

7. Select your cloud connection from the available connections on the list. If you do not have one configured, or want to configure a new one, see [Creating a cloud connection on AWS](conn_cloud_aws.md).
   
8. Configure the *Node pools* for your cluster. 

  The node pools define the location and size of the nodes that are used for your cluster. 

  The *Region* specifies where the nodes are located geographically. A closer region might provide faster performance, but a more distant region might be more distributed. 

  * Master pool: There are three Master nodes that are created for your cluster in the master pool. The master nodes share the management of the cluster activity. You can select multiple zones within the region for a more distributed group of master nodes. You can change the type and size of your instance after it is created, but you can also specify it in this section. The default values are *mx4.xlarge - 4 vCPU, 16 GiB RAM - General Purpose* with 500 GiB of root storage. 

  * Worker pools: You can create one or more worker nodes in a worker pool to run the container workloads for the cluster. They can be in a single worker pool, or distributed across multiple worker pools.  

9. Optional: Configure the cluster networking options.

10. Optional: configure label for the cluster.

11. Click **Create**. When you create the  cluster, it is automatically managed by Red Hat Advanced Cluster Management for Kubernetes. You can view your cluster details after the create and import process is complete.

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
|aws:region|Required; AWS zone ID where you want to create your cluster, from [AWS General Reference](https://docs.aws.amazon.com/general/latest/gr/rande.html)|none|
|aws:type|Optional, the EC2 instance type for the machines from [Amazon EC2 Instance Types](https://aws.amazon.com/ec2/instance-types/); use this information for every `type` specification||
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

After you installed your cluster, you can access your cluster by using the `kubeconfig` file or OpenShift cluster portal.

????? Information coming ??????

## Deleting your cluster
{: #delete}

1. From the navigation menu, navigate to **Automate infrastructure** -> **Clusters**.

2. Select **...** beside the cluster that you want to delete.

3. Select **Delete cluster**. 

View your cluster in the Red Hat Advanced Cluster Management for Kubernetes console. To scale your cluster, see [Scaling your cluster](scale_mcm.md).
