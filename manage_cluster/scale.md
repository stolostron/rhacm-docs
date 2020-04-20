# Resizing a cluster before creating

You can customize your cluster specifications, such as virtual machine sizes and number of nodes. See the following list of recommended settings for each available provider, but also see the documentation for more specific information:

* [Red Hat OpenShift Container Platform cluster in Amazon Web Services (AWS)](#red-hat-openshift-container-platform-cluster-in-amazon-web-services-aws) 
* [Google Kubernetes Engine (GKE)](#google-kubernetes-engine)
* [Azure Kubernetes Service (AKS) cluster](#azure-kubernetes-service-aks-cluster)

## Red Hat OpenShift Container Platform cluster in Amazon Web Services (AWS)

See the Amazon documentation at [Amazon EC2 Instance Types](https://aws.amazon.com/ec2/instance-types/) for more details.

After the cluster is created, you can resize your cluster to increase or decrease the number of nodes in that cluster. To learn how to resize your cluster, refer to [Creating a MachineSet to scale your cluster](https://docs.openshift.com/container-platform/4.1/machine_management/creating-machineset.html).

## Google Kubernetes Engine

After the cluster is created, you can resize your cluster to increase or decrease the number of nodes in that cluster.  To learn how to resize your cluster, refer to [Resizing a cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/resizing-a-cluster).

## Azure Kubernetes Service (AKS) cluster

For more information, see [General purpose virtual machine sizes](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/sizes-general).

For more information or customization, see [Ephemeral OS disks for Azure VMs](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/ephemeral-os-disks).

After the cluster is created, you can resize your cluster to increase or decrease the number of nodes in that cluster. To learn how to resize your cluster, refer to [Scale the node count in an Azure Kubernetes Service (AKS) cluster](https://docs.microsoft.com/en-us/azure/aks/scale-cluster).



