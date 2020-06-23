# Resizing a cluster

You can customize your managed cluster specifications, such as virtual machine sizes and number of nodes. See the following list of recommended settings for each available provider, but also see the documentation for more specific information:

## Amazon Web Services

You can change the number of nodes of a Red Hat OpenShift Container Platform cluster that was created in an Amazon Web Services environment by modifying the `MachineSet` parameters on the hub cluster. See [Recommended cluster scaling practices](https://docs.openshift.com/container-platform/4.4/scalability_and_performance/recommended-cluster-scaling-practices.html) and [Manually scaling a MachineSet](https://docs.openshift.com/container-platform/4.4/machine_management/manually-scaling-machineset.html) in the OpenShift Container Platform documentation that applies to your version. **Tip:** If you created the cluster by using the Red Hat Advanced Cluster Management for Kubernetes console, then it is an OpenShift Container Platform cluster. 

If you are changing the number of nodes of an Amazon EKS cluster that you imported, see [Cluster autoscaler](https://docs.aws.amazon.com/eks/latest/userguide/cluster-autoscaler.html) for information about scaling the cluster. 

## Google Cloud Platform

You can change the number of nodes of a Red Hat OpenShift Container Platform cluster that was created in an Google Cloud Platform environment by modifying the `MachineSet` parameters on the hub cluster. See [Recommended cluster scaling practices](https://docs.openshift.com/container-platform/4.4/scalability_and_performance/recommended-cluster-scaling-practices.html) and [Manually scaling a MachineSet](https://docs.openshift.com/container-platform/4.4/machine_management/manually-scaling-machineset.html) in the OpenShift Container Platform documentation that applies to your version. **Tip:** If you created the cluster by using Red Hat Advanced Cluster Management for Kubernetes, then it is an OpenShift Container Platform cluster. 

If you are changing the number of nodes of a Google Kubernetes Engine cluster that you imported, see [Resizing a cluster](https://cloud.google.com/kubernetes-engine/docs/how-to/resizing-a-cluster) for information about scaling the cluster.

## Microsoft Azure Kubernetes Service

You can change the number of nodes of a Red Hat OpenShift Container Platform cluster that was created in an Azure Kubernetes Service environment by modifying the `MachineSet` parameters on the hub cluster. See [Recommended cluster scaling practices](https://docs.openshift.com/container-platform/4.4/scalability_and_performance/recommended-cluster-scaling-practices.html) and [Manually scaling a MachineSet](https://docs.openshift.com/container-platform/4.4/machine_management/manually-scaling-machineset.html) in the OpenShift Container Platform documentation that applies to your version. **Tip:** If you created the cluster by using Red Hat Advanced Cluster Management for Kubernetes, then it is an OpenShift Container Platform cluster. 

If you are changing the number of nodes of an Azure Kubernetes Services cluster that you imported, see [Scaling a cluster](https://docs.microsoft.com/en-us/azure/aks/scale-cluster) for information about scaling the cluster.

## Bare metal cluster

You can change the number of nodes of a Red Hat OpenShift Container Platform cluster that was created in a bare metal environment by modifying the `MachineSet` parameters on the hub cluster. See [Recommended cluster scaling practices](https://docs.openshift.com/container-platform/4.4/scalability_and_performance/recommended-cluster-scaling-practices.html) and [Manually scaling a MachineSet](https://docs.openshift.com/container-platform/4.4/machine_management/manually-scaling-machineset.html) in the OpenShift Container Platform documentation that applies to your version. **Tip:** If you created the cluster by using Red Hat Advanced Cluster Management for Kubernetes, then it is an OpenShift Container Platform cluster. 

If you are changing the number of nodes of a bare metal cluster that you imported, see [Installing a cluster on bare metal with network customizations](https://docs.openshift.com/container-platform/4.4/installing/installing_bare_metal/installing-bare-metal-network-customizations.html) for information about scaling the cluster.

**Note:** Bare metal clusters are only supported when the hub cluster is OpenShift Container Platform version 4.4, and later. 

## IBM Kubernetes Service

If you are changing the number of nodes of an IBM Kubernetes Service cluster that you imported, see [Adding worker nodes and zones to clusters](https://cloud.ibm.com/docs/containers?topic=containers-add_workers) for information about scaling the cluster.
