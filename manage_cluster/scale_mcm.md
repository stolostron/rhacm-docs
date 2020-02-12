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

# Scaling your cluster

You can customize your cluster specifications, such as virtual machine sizes and number of nodes. 
{:shortdesc}

See the following list of recommended settings for each available cloud provider:

* [{{site.data.keyword.iks}} cluster](#iks)
* [{{site.data.keyword.open_s}} cluster in Amazon Web Services (AWS)](#ocp_aws)
* [Google Kubernetes Engine (GKE)](#gke)
* [Azure Kubernetes Service (AKS) cluster](#aks)
* [Amazon Elastic Kubernetes Service (EKS)](#eks)

## {{site.data.keyword.iks}} cluster
{: #iks}

- Number of worker nodes:
  
```
workers: 1
```
{: codeblock}

See the _cloud.ibm.com_ documentation at [Planning your worker node setup ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.ibm.com/docs/containers?topic=containers-planning_worker_nodes){: new_window} for more details.

- Type of Virtual Machine to create as Kubernetes worker nodes:

```
machineType: "b3c.4x16.encrypted"
```
{: codeblock}
  
The `b3c.4x16.encrypted` machine type indicates that worker OS is Ubuntu 18.64, with 4 core, 16 GB memory, 25 GB primary disk, and 100 GB secondary disk.

The disk is AES 256-bit encrypted. 

Run `ibmcloud ks machine-types --zone <zone name>` for more details.

- Resizing:

After the cluster is created, you can resize your cluster to increase or decrease the number of worker nodes in that cluster. To learn how to resize your cluster, refer to [Adding worker nodes and zones to clusters ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.ibm.com/docs/containers?topic=containers-add_workers){: new_window}.

## {{site.data.keyword.open_s}} cluster in Amazon Web Services (AWS)
{: #ocp_aws}

- Number of compute, worker, machines:
  
```
compute.replicas: 3
```
{: codeblock}

- The number of control plane machines:
 
```
controlPlane.replicas: 3
```
{: codeblock}

- Type of EC2 instance, including compute, memory and networking resources, for control plane machines and compute machines:

```
controlPlane.platform.aws.type: m5.xlarge
compute.platform.aws.type: m5.xlarge
```
{: codeblock}

See the Amazon documentation at [Amazon EC2 Instance Types ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://aws.amazon.com/ec2/instance-types/){: new_window} for more details.

- Resizing:

After the cluster is created, you can resize your cluster to increase or decrease the number of nodes in that cluster. To learn how to resize your cluster, refer to [Creating a MachineSet to scale your cluster ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.openshift.com/container-platform/4.1/machine_management/creating-machineset.html){: new_window}.

## Google Kubernetes Engine
{: #gke}

- The number of worker nodes:

```
numNodes: 1
```
{: codeblock}

- The type of machine to use for nodes:

```
machineType: "n1-standard-1"
```
{: codeblock}

Defaults to `n1-standard-1`. 
 
The list of predefined machine types is available by using the following command: `gcloud compute machine-types list`.

- Size for node VM boot disks:
   
```
diskSize: "100G"
```
{: codeblock}

Defaults to 100 GB.

- Type of the node VM boot disk:
   
Defaults to `pd-standard`. Disk type must be `pd-standard`, or `pd-ssd`.

```
diskType: "pd-standard"
```
{: codeblock}

After the cluster is created, you can resize your cluster to increase or decrease the number of nodes in that cluster.  To learn how to resize your cluster, refer to [Resizing a cluster ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.google.com/kubernetes-engine/docs/how-to/resizing-a-cluster){: new_window}.

## Azure Kubernetes Service (AKS) cluster
{: #aks}

- The number of worker nodes:
  
```
nodeCount: 2
```
{: codeblock}

- The size of Virtual Machines to create as Kubernetes nodes. 

```
nodeVMSize: "Standard_D8s_v3"
```
{: codeblock}

For more information, see [General purpose virtual machine sizes ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general
){: new_window}

- Resizing:
  
The typical size of the OS disk for each node in the node pool size range is between 100-2000GB. 

For more information or customization, see [Ephemeral OS disks for Azure VMs ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/ephemeral-os-disks){: new_window}.

```
nodeOsdiskSize: 100
```
{: codeblock}

After the cluster is created, you can resize your cluster to increase or decrease the number of nodes in that cluster. To learn how to resize your cluster, refer to [Scale the node count in an Azure Kubernetes Service (AKS) cluster ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.microsoft.com/en-us/azure/aks/scale-cluster){: new_window}.

## Amazon Elastic Kubernetes Service (EKS)
{: #eks}
 
- The instance type for your worker nodes.
  
```
nodeType: "t3.medium"
```
{: codeblock}

For more information, see [Amazon EC2 Instance Types ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://aws.amazon.com/ec2/instance-types
){: new_window}

- The total number of worker nodes.

```
nodes: 2
```
{: codeblock}

- The minimum number of nodes that your worker node Auto Scaling group can scale in to.

```
nodesMin: 1
```
{: codeblock}

- The maximum number of nodes that your worker node Auto Scaling group can scale out to.

```
nodesMax: 3
```
{: codeblock}

After the cluster is created, you can resize your cluster to increase or decrease the number of nodes in that cluster. To learn how to resize your cluster, refer to [Updating an Existing Worker Node Group ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://docs.aws.amazon.com/eks/latest/userguide/update-stack.html){: new_window}.
