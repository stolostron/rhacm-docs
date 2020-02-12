---

copyright:
  years: 2019
lastupdated: "2019-11-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Supported Cluster API and managed cloud providers

Learn about the Cluster API cloud providers that are available with {{site.data.keyword.cloud_pak_mcm}}. Also, find the documented managed providers that are available.
{:shortdesc}

  - [Supported Cluster API cloud providers](#providers)
  - [Supported managed cluster cloud providers](#providers-managed)
  - [Configuring kubectl](#kubectl)

{{site.data.keyword.open_s}} 4.2 is supported for the hub cluster and managed clusters.

**Best practice:** For managed cluster cloud providers, use latest version of Kubernetes.

## Supported Cluster API cloud providers
{: #providers} 

- See [Getting started with {{site.data.keyword.iks}} ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.ibm.com/docs/containers?topic=containers-getting-started){: new_window}.

- See [{{site.data.keyword.open_s}} on AWS ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.openshift.com/learn/partners/amazon-web-services){: new_window}.

- See [Google Kubernetes Engine ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.google.com/kubernetes-engine/){: new_window}.

- See [Azure Kubernetes Service ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://azure.microsoft.com/en-us/services/kubernetes-service/){: new_window}.

## Supported managed cluster cloud providers
{: #providers-managed} 

- See [{{site.data.keyword.iks}} ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.ibm.com/docs/containers?topic=containers-getting-started){: new_window}.

- See [Red Hat OpenShift on IBM Cloud ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.ibm.com/docs/openshift?topic=openshift-clusters){: new_window}.

- See [{{site.data.keyword.open_s}} on AWS ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://www.openshift.com/learn/partners/amazon-web-services){: new_window}.

- See [Google Kubernetes Engine ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.google.com/kubernetes-engine/){: new_window}.

- See [Azure Kubernetes Service ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://azure.microsoft.com/en-us/services/kubernetes-service/){: new_window}. 

- See [Amazon Elastic Container Service for Kubernetes ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://aws.amazon.com/eks/){: new_window}.  

## Configuring kubectl
{: #kubectl} 

From each cloud provider documentation, you might need to learn how configure your `kubectl`. You must have `kubectl` installed.

For instance, for {{site.data.keyword.iks}}, you can visit [IBM Cloud Kubernetes Service CLI ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://cloud.ibm.com/docs/containers?topic=containers-cli-plugin-kubernetes-service-cli){: new_window} and search for `ibmcloud ks cluster-config`.

Each cloud provider process to configure `kubectl` is different, so view the product documentation for details.
