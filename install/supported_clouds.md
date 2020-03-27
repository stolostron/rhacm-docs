---

copyright:
  years: 2020
lastupdated: "2020-03-25"

---

# Supported managed cloud providers

Learn about the cloud providers that are available with Red Hat Advanced Cluster Management for Kubernetes. Also, find the documented managed providers that are available.

  - [Supported hub cluster cloud provider](#providers)
  - [Supported managed cluster cloud providers](#providers-managed)
  - [Configuring kubectl](#kubectl)

**Best practice:** For managed cluster cloud providers, use latest version of Kubernetes.

## Supported hub cluster cloud provider
{: #providers} 

Red Hat OpenShift Container Platform 4.2 and 4.3 are supported for the hub cluster.

- See [OpenShift on Amazon Web Services](https://www.openshift.com/learn/partners/amazon-web-services).

## Supported managed cluster cloud providers
{: #providers-managed} 

Red Hat OpenShift Container Platform 4.2 and 4.3 are supported for the managed clusters. You can use Red Hat OpenShift Container Platform 3.1.1, as well. See the available managed cluster options and documentation:

- See [OpenShift on Amazon Web Services](https://www.openshift.com/learn/partners/amazon-web-services).

- See [Red Hat OpenShift on IBM Cloud](https://cloud.ibm.com/docs/openshift?topic=openshift-clusters).

- See [Getting started with IBM Cloud Kubernetes Service](https://cloud.ibm.com/docs/containers?topic=containers-getting-started).

- See [Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine/).

- See [Azure Kubernetes Service](https://azure.microsoft.com/en-us/services/kubernetes-service/). 

- See [Amazon Elastic Container Service for Kubernetes](https://aws.amazon.com/eks/).  

## Configuring kubectl
{: #kubectl} 

From vendor documentation previously listed, you might need to learn how configure your `kubectl`. You must have `kubectl` installed. When you [Import an existing cluster](../manage_cluster/import.md), view the cloud provider product documentation for details.
