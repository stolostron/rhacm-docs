---

copyright:
  years: 2020
lastupdated: "2020-2-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

<<<<<<< HEAD
# What's new in {{site.data.keyword.product}} version {{site.data.keyword.version_cp}}
=======
# What's new in (product name here)
>>>>>>> doc_stage

Get a quick overview of changes this release.
{:shortdesc}

<<<<<<< HEAD
{{site.data.keyword.product}} version {{site.data.keyword.version_cp}} introduces the following new features and enhancements

  * [Module versions](#modules)
  * [Installation, configuration, and upgrade](#install)
  * [Administering](#admin)
  * [Security and compliance](#security)
=======
(add sections here)
>>>>>>> doc_stage
  * [Cluster management](#cluster_mngmt)
  * [Application management](#app_mngmt)
  * [Performance improvements](#cluster)
  * [{{site.data.keyword.gui_caps_only}}](#gui)
<<<<<<< HEAD
  * [Technology preview](#preview)

## Module versions

The {{site.data.keyword.product}} includes the following modules:

| Module | Version |
|--|--|--|
|{{site.data.keyword.IBM_notm}} Cloud App Management that includes {{site.data.keyword.IBM_notm}} Cloud Event Management  | 2019.4.0 |
|{{site.data.keyword.IBM_notm}} Cloud Automation Manager | 4.1.0.0|
=======
>>>>>>> doc_stage


## Installation, upgrade, and configuration
{: #install}

<<<<<<< HEAD
### Supported {{site.data.keyword.ocp_tm}} version

The {{site.data.keyword.product}} supports
{{site.data.keyword.ocp_tm}} 4.2 for {{site.data.keyword.linux_bit}} with continued support for {{site.data.keyword.ocp}} 3.11 for {{site.data.keyword.linux_bit_notm}} and {{site.data.keyword.ppc}}.

### Installation and upgrade

You can perform an offline and online installation of the {{site.data.keyword.product}}. Upgrade is supported for offline installations only.

  -  [Offline installation](../install/offline.md)
  -  [Online installation](../install/online.md)

### {{site.data.keyword.rh_tm}} configuration

Red Hat CloudForm functions are introduced in this version of the {{site.data.keyword.product}}, and integration with the Ansible Automation Platform.

* You can now configure Red Hat Ansible Tower with {{site.data.keyword.IBM_notm}} single sign-on. For more information see, [Using {{site.data.keyword.rh_tm}} Ansible Tower](../install/ansible_tower.md). 

* You can now configure Red Hat CloudForms with {{site.data.keyword.IBM_notm}} single sign-on. For more information see, [Using {{site.data.keyword.rh_tm}} CloudForms](../install/cloudforms.md).

=======
>>>>>>> doc_stage
## Administering
{: #admin}

You can now add additional Prometheus instances to manage cluster monitoring. For more information, see [Adding additional Prometheus instances](../admin/add_prom_mcm.md).

## Security and compliance
{: #security}

### Governance and risk

<<<<<<< HEAD
You can now disable your policies. For more information, see _Disabling your security policy from the {{site.data.keyword.gui}}_ on the [Managing a security policy page](../mcm/manage_cluster/manage_grc_policy.md).

You can create and view vulnerability and mutation policy violations for your applications from the {{site.data.keyword.product}} Governance and risk dashboard. For more information, see the _Viewing application violations from the {{site.data.keyword.gui-short}}_ section of the [Managing a security policy page](../mcm/manage_cluster/manage_grc_policy.md).

You can create and update policies on your {{site.data.keyword.product}} hub cluster for multiple namespaces. You can view only the policies, violations, and security findings associated with your cluster and namespace. Update your PlacementPolicy to create policies on multiple namespaces. For more information, see [{{site.data.keyword.product}} policy example](../mcm/compliance/policy_example.md).

### Authentication with Red Hat {{site.data.keyword.open_s}}

You can enable authentication with Red Hat {{site.data.keyword.open_s}} when you install your cluster on a public cloud. For more information, see [Preparing to install the {{site.data.keyword.product}}](../install/prep.md#auth).
=======
>>>>>>> doc_stage

## Cluster management
{: #cluster_mngmt}

<<<<<<< HEAD
### Amazon Elastic Kubernetes Service

In addition to the previously released cloud provider support, the product now supports creating an Amazon Elastic Kubernetes Service cluster with {{site.data.keyword.product}}, which uses the Cluster API, a Kubernetes core-based API that is used to create, configure, and manage clusters with CRD and controller requirements. See [Amazon Elastic Kubernetes Service ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://aws.amazon.com/eks/){:new_window} for more information about the public Kubernetes service.

### Stand-alone multicluster plug-in

The {{site.data.keyword.product}} `mc` command is installed as a separate plug-in so that you can use the standard multicluster commands after you install the basic {{site.data.keyword.cloud_pak}} CLI (cloudctl). For example, with `cloudctl` capability, you can install the `mc` plug-in to import managed clusters. For more information, see [Installing the {{site.data.keyword.cloud_pak}} CLI (cloudctl) multicluster plug-in (mc)](../cli/installing_mc_plugin.md).

### Upgrading the `multicluster endpoint`

Upgrading the `multicluster endpoint` is easier with the simpler command: `cloudctl mc cluster upgrade <cluster-name>`. See [Upgrading multicluster endpoint](../mcm/manage_cluster/upgrade_mc_endpoint.md) for more details.
=======
>>>>>>> doc_stage

## Application management
{: #app_mngmt}


## Performance improvements
{: #cluster}


## {{site.data.keyword.gui_caps_only}}
{: #gui}

<<<<<<< HEAD
### Navigation

The {{site.data.keyword.cloud_pak_mcm}} {{site.data.keyword.gui}} navigation has a new design that highlights product capabilities, while providing users clear pathways based on tasks and use-cases. Previous pages are mapped into the new primary categories. See the following list of navigation details:

  * Observe environments: View the _Overview_ and the _Topology_ page.
  * Automate infrastructure: Access your clusters and use {{site.data.keyword.rhel}} automation technology.
  * Manage applications: Define, deploy, manage applications and view application and deployment details.
  * Govern risk: Create policies to govern the system and see policy and violation details.
  * Monitor health: Provide rich performance data such as Incidents, App monitoring, Grafana, and Helm releases.
  * Administer: Access IAM and Metering capabilities.

### Header

From the {{site.data.keyword.cloud_pak_mcm}} header, you can now click (+) to create a resource. Additionally, you can now access the Search box from the header.

The following image displays navigation and header:

<img src="../images/truncated-ui-no-ship.jpg" width="60%" alt="{{site.data.keyword.product}} screenshot of the navigation tabs and header.">
=======
>>>>>>> doc_stage

## Technology preview
{: #preview}


<<<<<<< HEAD
For all of the features that are available in {{site.data.keyword.product}} as technology preview code (TPC) only, see the [Technology preview](../mcm/tech_previews/tech_overview_mcm.md) section.
=======
>>>>>>> doc_stage

