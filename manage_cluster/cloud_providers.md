---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-16"
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

Red Hat OpenShift 4.2 is supported for the hub cluster and managed clusters.

**Best practice:** For managed cluster cloud providers, use the latest version of Kubernetes.

## Supported Cluster API cloud providers
{: #providers} 

- See [OpenShift Container Platform on AWS](https://www.openshift.com/learn/partners/amazon-web-services){: new_window}.

## Supported managed cluster cloud providers
{: #providers-managed}

- See [OpenShift Container Platform on AWS](https://www.openshift.com/learn/partners/amazon-web-services){: new_window}. 

## Configuring kubectl
{: #kubectl} 

- See _Overview of kubectl_ in the [Kubernetes documentation](https://kubernetes.io/docs/reference/kubectl/overview/).
- See [Red Hat OpenShift on AWS](https://www.openshift.com/learn/partners/amazon-web-services).

## Configuring oc
{: #oc} 

The commands that are used with Red Hat Advanced Cluster Management for Kubernetes cluster creation and management are based on `kubectl` commands. Red Hat OpenShift provides commands that are equivalent to the `kubectl` commands by replacing `kubectl` with `oc` in the command syntax. For OpenShift on AWS, you can visit [Usage of `oc` and `kubectl` commands](https://docs.openshift.com/container-platform/4.2/cli_reference/openshift_cli/usage-oc-kubectl.html) for more information.
