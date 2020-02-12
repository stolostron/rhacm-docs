---

copyright:
  years: 2019
lastupdated: "2019-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Cloud Automation Manager and {{site.data.keyword.mcm_notm}} integration

IBM Cloud Automation Manager can be integrated with {{site.data.keyword.mcm_notm}}. IBM Cloud Automation Manager is a multicloud, self-service management platform that runs on {{site.data.keyword.product}}. With {{site.data.keyword.mcm_notm}} integration, you can ensure that your clusters are secure, operating efficiently, and delivering appropriate service levels.
{:shortdesc}

For more information about Cloud Automation Manager, see the [Cloud Automation Manager overview](https://www.ibm.com/support/knowledgecenter/SS2L37_4.1.0.0/cam_overview.html?cp=SSFC4F_1.2.0).

## Prerequisites
For a complete list of prerequisites, see [Prerequisites for installing Cloud Automation Manager](https://www.ibm.com/support/knowledgecenter/SS2L37_4.1.0.0/cam_prereq.html?cp=SSFC4F_1.2.0).

## Configuring Cloud Automation Manager and {{site.data.keyword.mcm_notm}}

To install Cloud Automation Manager, see [Installing](https://www.ibm.com/support/knowledgecenter/SS2L37_4.1.0.0/cam_planning.html).

For more information about {{site.data.keyword.mcm_notm}}, see the [{{site.data.keyword.mcm_notm}} product overview](../../about/overview.md).

## Integrating with {{site.data.keyword.mcm_notm}}

You can use a Terraform template that is shipped with Cloud Automation Manager 3.1.2, and later. This template loads the PPA archive and {{site.data.keyword.mcm_notm}} binaries into a Kubernetes cluster. For the complete configuration procedure, see [Integrating with Multicloud Manager {{site.data.keyword.mcm_notm}} Configuration](https://www.ibm.com/support/knowledgecenter/SS2L37_4.1.0.0/content/cam_integrate_mcm.html?cp=SSFC4F_1.2.0) in the product documentation.
