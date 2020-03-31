---

copyright:
  years: 2020
lastupdated: "2020-03-26"

---

# Scaling your cluster (View recommendations and comment--specifics removed)

You can customize your cluster specifications, such as virtual machine sizes and number of nodes. See the following list of recommended settings for each available cloud provider, but also see the documentation for more specific information:

* [Red Hat OpenShift Container Platform cluster in Amazon Web Services (AWS)](#ocp_aws) <!--check these, of only create is represented now, I can removed managed-->
* [Red Hat OpenShift on IBM Cloud](#rhoks)
* [IBM Kubernetes Service cluster](#iks)
* [Google Kubernetes Engine (GKE)](#gke)
* [Azure Kubernetes Service (AKS) cluster](#aks)
* [Amazon Elastic Kubernetes Service (EKS)](#eks)

<!-- if this is all we are recommending, I think add to system req -->

## Red Hat OpenShift Container Platform cluster in Amazon Web Services (AWS)
{: #ocp_aws}

See the Amazon documentation at [Amazon EC2 Instance Types](https://aws.amazon.com/ec2/instance-types/) for more details.

After the cluster is created, you can resize your cluster to increase or decrease the number of nodes in that cluster. To learn how to resize your cluster, refer to [Creating a MachineSet to scale your cluster](https://docs.openshift.com/container-platform/4.1/machine_management/creating-machineset.html).

## Red Hat OpenShift on IBM Cloud
{: #rhoks}

See the documentation at [Red Hat OpenShift on IBM Cloud](https://cloud.ibm.com/docs/openshift?topic=openshift-clusters) for more details.

After the cluster is created, you can resize your cluster to increase or decrease the number of nodes in that cluster. To learn how to resize your cluster, refer to [Creating a MachineSet to scale your cluster](https://docs.openshift.com/container-platform/4.1/machine_management/creating-machineset.html).

## IBM Kubernetes Service cluster
{: #iks}

See the _cloud.ibm.com_ documentation at [Planning your worker node setup](https://cloud.ibm.com/docs/containers?topic=containers-planning_worker_nodes) for more details.

After the cluster is created, you can resize your cluster to increase or decrease the number of worker nodes in that cluster. To learn how to resize your cluster, refer to [Adding worker nodes and zones to clusters](https://cloud.ibm.com/docs/containers?topic=containers-add_workers).

## Google Kubernetes Engine
{: #gke}

After the cluster is created, you can resize your cluster to increase or decrease the number of nodes in that cluster.  To learn how to resize your cluster, refer to [Resizing a cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/resizing-a-cluster).

## Azure Kubernetes Service (AKS) cluster
{: #aks}

For more information, see [General purpose virtual machine sizes](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general).

For more information or customization, see [Ephemeral OS disks for Azure VMs](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/ephemeral-os-disks).

After the cluster is created, you can resize your cluster to increase or decrease the number of nodes in that cluster. To learn how to resize your cluster, refer to [Scale the node count in an Azure Kubernetes Service (AKS) cluster](https://docs.microsoft.com/en-us/azure/aks/scale-cluster).

## Amazon Elastic Kubernetes Service (EKS)
{: #eks}
 
For more information, see [Amazon EC2 Instance Types](https://aws.amazon.com/ec2/instance-types).

After the cluster is created, you can resize your cluster to increase or decrease the number of nodes in that cluster. To learn how to resize your cluster, refer to [Updating an Existing Worker Node Group](https://docs.aws.amazon.com/eks/latest/userguide/update-stack.html).


