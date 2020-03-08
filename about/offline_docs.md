---

copyright:
  years: 2019
lastupdated: "2019-12-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# IBM customizable offline documentation

You can view the documentation for the Red Hat Advanced Cluster Management for Kubernetes offline in a Helm release.
{:shortdesc}

## Contents

The `IBM Customizable Offline Documentation` Helm chart is available from the [IBM charts](https://github.com/IBM/charts/tree/master/stable) repository.

This Helm chart contains the documentation for the current version and previous two versions of the Red Hat Advanced Cluster Management for Kubernetes. You can install and view the documentation in an offline, air-gap environment. In addition to this product documentation, a feature is included for adding non-IBM custom documentation content under the _Our Content (Non-IBM)_ product.

The Docker image for the documentation is available from [Docker Hub](https://hub.docker.com/r/ibmcom/cp4mcm-docs). With each new release for the Red Hat Advanced Cluster Management for Kubernetes, the Docker image is updated to include the new release documentation. For the latest documentation, see the online [IBM Knowledge Center](https://www.ibm.com/support/knowledgecenter/SSFC4F/product_welcome_cloud_pak.html).

## Installing the offline documentation

Follow these steps to install and use the customizable offline documentation:

1. Download the Docker image from [Docker Hub](https://hub.docker.com/r/ibmcom/cp4mcm-docs) onto your Linux® on x86_64 cluster:
   ```
   docker pull ibmcom/cp4mcm-docs:1.1.0
   ```
   {: codeblock}
2. Download the Helm chart from [IBM charts](https://github.com/IBM/charts/tree/master/stable/ibm-offline-docs).
3. Follow the instructions that are in the Helm chart readme file to install the chart.

## Adding custom content

You can add your own HTML or markdown content into the offline documentation so that you can have all of your relevant information in one place. For instructions about how to add your custom content, see the [Helm chart readme file](https://github.com/IBM/charts/tree/master/stable/ibm-offline-docs/README.md#adding-custom-documentation-content).

## Support

This Helm chart is updated quarterly with new release versions. If you encounter incorrect or missing information, check the online IBM Knowledge Center documentation to compare your offline documentation with the latest documentation before you contact IBM support. 

Note: Maintaining documentation within the _Our Content (Non-IBM)_ product is not covered by IBM support.
