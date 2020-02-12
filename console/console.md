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

# {{site.data.keyword.product}} {{site.data.keyword.gui}} components

Learn more about a few of the {{site.data.keyword.gui}} components that you can use to view, manage, or customize your {{site.data.keyword.gui}}.


## {{site.data.keyword.product}} {{site.data.keyword.gui}} components

**Note**: The web terminal was removed. Use the Visual Web Terminal.

{{site.data.keyword.mcm_notm}} {{site.data.keyword.gui}} components:

* [Getting started](#get_started)
* [Overview](#mcm_overview)
* [Topology](#mcm_topology)
* [Search](#search)
* [Policies](#mcm_policy)

## Getting started
{: #get_started}

From the Getting started page, you can view descriptions and tasks, and you can scroll to the area to install various CLI tools.

From the _Header_, click the **Help** (?) icon to view the _About_ page, the documentation, and support. Other features of the header include the following:

    * _User_ menu: access _Configure Client_ and customize your home page.
    * Visual Web Terminal: Launch and use the terminal. See [Managing your cluster with the Visual Web Terminal](../mcm-kui/3.4.0/vwt.md) to learn more.
    * Create resource: Enter the configuration manifest for the resource.
    * Catalog: Access Helm charts and {{site.data.keyword.cloud_paks}}

## Overview
{: #mcm_overview}

Use the Overview page to view, manage, and reorganize the dashboard of your cluster information. You can view details of your clusters and other cloud service providers that the product supports. You can also view details about your applications. The Overview dashboard is continuously refreshed in real time.
{: shortdesc}

### Reorganizing your dashboard

You can personalize your view of the Overview dashboard by reorganizing the resource overview cards. You can view the following information about your clusters:

* Name of the cloud service with the number of clusters
* Cluster compliance
* Pod details
* Pod status
* Cluster resources (VCPU/Memory usage)
* Storage usage

### Viewing application details

You can view the information of each application. Click **Show details** to view the following information:

* Number of clusters
* Number of Kubernetes types
* Number of regions
* Number of nodes
* Number of pods

### Viewing your pod health

View the pod health for all of your clusters by expanding the Heatmap. The Heatmap displays color-coordinated boxes that represent the VCPU usage threshold of your nodes.

Click **Show details** to view the map. The size of the color-coordinated boxes represents the number of nodes on your cluster. Hover your cursor over the box to view the response time of your cluster.

### Filtering your results

You can personalize the Overview page more with the filtering feature. Click **Filter results** to specify what information is displayed on your page.

## Topology page
{: #mcm_topology}

The Topology page uses information from Weave Scope probe to display Kubernetes objects within a cluster. You can view hub cluster resources. As you configure managed clusters, you see more clusters in the Topology view.

To reduce the graphics on the page, you can filter the view by Clusters, Namespaces, and Labels. You can also filter the design by selecting the icon that represents the Kubernetes objects.

Learn more about the tabs that are available from the Topology page:

  - Clusters: You can monitor your cluster network, object network, applications, and security policies in a graphical format. View your hub clusters, all your managed clusters, and monitor security violations.

  - Networking: View Kubernetes objects for each cluster and any networks between your Kubernetes objects. Objects display changes if they were recently started. Pods also indicate `pending` and `failed` status.

  - Applications: View the deployables, services, deployments, charts, and pods that comprise each application. You can select any component from the topology view to view more details.

  - Policies: View the policy, policy placement, and clusters that are being validated. Check for violations for the selected policy.

## Search
{: #search}

For {{site.data.keyword.product}}, Search provides visibility into your resources across all your clusters. You need to install the `ibm-search-prod` chart to use Search.

**Note:** You can type any text value in the _Search box_ and results include anything with that value from any property, such as a name or namespace. For example, if you search for `IBM`, you can receive results such as `IBM123`.

For more specific search results, include the property in your search. For example, search for `name:IBM` to search only in the `name` property.

1. Click **Search** in the navigation menu.
2. Type a word in the _Search box_, then Search finds your resources that contain that value.

  - As you search for resources, you receive other resources that are related to your original search result, which help you visualize how the resources interact with other resources in the system.

  - Search returns and lists each cluster with the resource that you search. For resources in the _hub_ cluster, the cluster name is displayed as _local-cluster_.

  - Your search results are grouped by `kind`, and each resource `kind` is grouped in a table.

  - Your search options depend on your cluster objects. See the following examples: name, namespace, status, and other resource fields. Auto-complete provides suggestions to refine your search.  

  - Any user can search for resources, but results are based on your role-based access control assignment. Additionally, if you save and share a Search query with another user, returned results depend on access level for that user. For more information on role access, see [role-based access control](../iam/3.4.0/assign_role.md).

  - You can refine your results with specific fields. See the following example:

    - Search for a single field, such as `kind:pod` to find all pod resources.
    - Search for multiple fields, such as `kind:pod namespace:default` to find the pods in the default namespace.

  - You can also search with conditions by using characters, such as `>, >=, <, <=, !=`.

    See the following example:

    - Search for `kind:pod status:!Running` to find all pod resources where the status is not `Running`.
    - Search for `kind:pod restarts:>1` to find all pods that restarted at least twice.

3. If you want to save your search, click the **Save disk** icon.  

## Policies
{: #mcm_policy}

Use the _Policies_ page to create and manage security policies that are defined for security controls that are enabled. See the following list of capabilities for the Policies dashboard:

* View security policy and cluster violations that exist.
* Remediate your security violations.
* Perform a root cause analysis of security violations.
* View security controls to each compliance certification controls.
* Configure security controls.
* Provide interfaces to pull data into other tools.
* View a summary of risk reports for each security control.
* View periodic security readiness reports.

**Important**: You must enable and manage all security controls and standards to the Enterprise internal security, and external regulatory compliance standards for their {{site.data.keyword.product}} deployments.

Customize the _Policies_ page by filtering the standards, categories, controls, and type of remediation.

From the _Overview_ tab on the _Policies_ page, you can view the _Top Violations_, which are cluster policies with the most violations. You can filter the _Top Violations_ dashboard by the _Clusters_ or _Policies_ labels. You can also filter the _Policy Overview_ dashboard by _Categories_ or _Standards_.

From the _All Policies_ tab, you can view a table of your policies. The following information about your policy is available in the table:

  * Namespace
  * Remediation
  * Cluster Compliant
  * Controls
  * Standards
  * Categories

Select a policy to view the following policy details:

* Policy Details
* Policy YAML Template
* Policy Status
* Policies
* Placement Policies
* Placement Bindings

See the following documentation to learn how to manage the _policies_ dashboard:

* [Managing a security policy](../mcm/manage_cluster/manage_grc_policy.md)
