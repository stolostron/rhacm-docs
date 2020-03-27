---

copyright:
  years: 2020
lastupdated: "2020-03-25"

---

# Supported managed cloud providers

Learn about the cloud providers that are available with Red Hat Advanced Cluster Management for Kubernetes. Also, find the documented managed providers that are available.

  - [Supported hub cluster cloud providers](#providers)
  - [Supported managed cluster cloud providers](#providers-managed)
  - [Configuring kubectl](#kubectl)

**Best practice:** For managed cluster cloud providers, use latest version of Kubernetes.

## Supported hub cluster cloud providers
{: #providers} 

Red Hat OpenShift Container Platform 4.2 and 4.3 are supported for the hub cluster. <!-- do we need to also mention 3.1.1 here?-->

- See [OpenShift on Amazon Web Services]](https://www.openshift.com/learn/partners/amazon-web-services).


## Supported managed cluster cloud providers
{: #providers-managed} 

Red Hat OpenShift Container Platform 4.2 and 4.3 are supported for the managed clusters. You can use Red Hat OpenShift Container Platform 3.1.1, as well. See the available managed cluster options. <!-- Not a complete list here and please verrify what is listed, we still need to add IKS and RHOKS... -->

- See [OpenShift on Amazon Web Services](https://www.openshift.com/learn/partners/amazon-web-services).

- See [Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine/).

- See [Azure Kubernetes Service](https://azure.microsoft.com/en-us/services/kubernetes-service/). 

- See [Amazon Elastic Container Service for Kubernetes](https://aws.amazon.com/eks/).  

## Configuring kubectl
{: #kubectl} 

From each cloud provider documentation, you might need to learn how configure your `kubectl`. You must have `kubectl` installed.

Each cloud provider process to configure `kubectl` is different, so view the product documentation for details.
