---

copyright:
  years: 2020
lastupdated: "2020-03-23"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Supported Cluster API and managed cloud providers

Learn about the Cluster API cloud providers that are available with Red Hat Advanced Cluster Management for Kubernetes. Also, find the documented managed providers that are available.
{:shortdesc}

  - [Supported Cluster API cloud providers](#providers)
  - [Supported managed cluster cloud providers](#providers-managed)
  - [Configuring kubectl](#kubectl)

OpenShift Container Platform 4.2 is supported for the hub cluster and managed clusters.

**Best practice:** For managed cluster cloud providers, use latest version of Kubernetes.

<!--This is about cluster that we can provision and manage-->
## Supported Cluster API cloud providers <!--Supported Automated Cluster provisining through Hive-->
{: #providers} 

<!--info about hive-->
<!--https://github.com/openshift/hive-->
<!--https://blog.openshift.com/openshift-hive-cluster-as-a-service/-->

- OpenShift Container Platform 4.x on AWS
- OpenShift Container Platform 4.x on GCP
- OpenShift Container Platform 4.x on Azure

<!--This is about cluster that we can manage (import)-->
## Supported managed cluster cloud providers
{: #providers-managed}

- See IBM Kubernetes Service
- See OpenShift Container Platform on IBM Cloud
- See Elastic Kubernete Service on AWS https://aws.amazon.com/eks/
- See [OpenShift Container Platform on AWS](https://www.openshift.com/learn/partners/amazon-web-services){: new_window}.
- See [Azure Kubernetes Service](https://azure.microsoft.com/en-us/services/kubernetes-service/){: new_window}.
- See [Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine/){: new_window}.

<!--Does this belong here?-->
## Configuring kubectl
{: #kubectl} 

From each cloud provider documentation, you might need to learn how configure your `kubectl`. You must have `kubectl` installed.

Each cloud provider process to configure `kubectl` is different, so view the product documentation for details.
