---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Observability in the console 

Learn more about a few of the console components that you can use to view, manage, or customize your console. 

See [Accessing your cluster by using the console](../installing/url.md) to access your cluster console. 

## Red Hat Advanced Cluster Management for Kubernetes console components

Red Hat Advanced Cluster Management for Kubernetes console components:

* [Getting started](#get_started)
* [Overview](#mcm_overview)
* [Topology](#mcm_topology)
* [Search](#search)
* [Governance and risk dashboard](#grc)

## Getting started 
{: #get_started}

From the Red Hat Advanced Cluster Management for Kubernetes getting started page, you can view descriptions and tasks, and you can install various CLI tools.

From the _Header_, click the **Help** (?) icon to view the _About_ page, the documentation, and more. From the _User_ menu, you can access the _Configure Client_ page.

## Overview 
{: #mcm_overview}

Use the Overview page to view, manage, and reorganize the dashboard of your cluster information. You can view details of your clusters and other cloud service providers that Red Hat Advanced Cluster Management for Kubernetes supports. The Overview dashboard is continuously refreshed in real time.
{: shortdesc}

### Reorganizing your dashboard

You can personalize your view of the Overview dashboard by reorganizing the resource overview cards. You can view the following information about your clusters: 

* Name of the cloud service with the number of clusters
* Cluster compliance
* Pod details
* Pod status
* Cluster resources (VCPU/Memory usage)
* Storage usage

### Viewing application details (Technology preview)

You can view the information of each application. Click **Show details** to view the following information:

* Number of clusters
* Number of Kubernetes types
* Number of regions
* Number of nodes
* Number of pods

For more information about your application resources, see [Application management (Technical preview)](../manage_applications/overview.md).

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

  - Clusters: You can monitor your cluster network, object network, and security policies in a graphical format. View your hub clusters, all your managed clusters, and monitor security violations.

  - Networking: View Kubernetes objects for each cluster and any networks between your Kubernetes objects. Objects display changes if they were recently started. Pods also indicate `pending` and `failed` status.

  - Policies: View the policy, policy placement, and clusters that are being validated. Check for violations for the selected policy.

## Search 
{: #search}

For Red Hat Advanced Cluster Management for Kubernetes, Search provides visibility into your resources across all your clusters. You need to install the `search-prod` chart to use Search.

**Note:** You can type any text value in the _Search box_ and results include anything with that value from any property, such as a name or namespace. For example, if you search for `RedHat`, you can receive results such as `RedHat123`. 

For more specific search results, include the property in your search. For example, search for `name:RedHat` to search only in the `name` property.

1. Click **Search** in the navigation menu. 
2. Type a word in the _Search box_, then Search finds your resources that contain that value.
   
  - As you search for resources, you receive other resources that are related to your original search result, which help you visualize how the resources interact with other resources in the system. 
  
  - Search returns and lists each cluster with the resource that you search. For resources in the _hub_ cluster, the cluster name is displayed as _local-cluster_.
   
  - Your search results are grouped by `kind`, and each resource `kind` is grouped in a table. 

  - Your search options depend on your cluster objects. You can refine your results with specific labels. Search is case-sensitive when you query labels. See the following examples: name, namespace, status, and other resource fields. Auto-complete provides suggestions to refine your search. See the following example:

    - Search for a single field, such as `kind:pod` to find all pod resources.
    - Search for multiple fields, such as `kind:pod namespace:default` to find the pods in the default namespace. 
  
  **Note:** Any user can search for resources, but results are based on your role-based access control assignment. Additionally, if you save and share a Search query with another user, returned results depend on access level for that user. For more information on role access, see _Using RBAC Authorization_ in the [Kubernetes documentation](https://kubernetes.io/docs/reference/access-authn-authz/rbac/){:new_window}.

  - You can also search with conditions by using characters, such as `>, >=, <, <=, !=`.

    See the following example:

    - Search for `kind:pod status:!Running` to find all pod resources where the status is not `Running`.
    - Search for `kind:pod restarts:>1` to find all pods that restarted at least twice.

3. If you want to save your search, click the **Save disk** icon.  

## Governance and risk
{: #grc}

Use the Governance and risk dashboard to create and manage policies and policy controllers. For more information, see [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](../compliance/compliance_intro.md).

