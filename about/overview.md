---

copyright:
  years: 2019
lastupdated: "2019-11-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Overview

The {{site.data.keyword.product}}, running on Red Hat {{site.data.keyword.open_s_tm}}, provides consistent visibility, governance, and automation from on premises to the edge. Enterprises gain capabilities such as multicluster management, event management, application performance management, infrastructure management, and existing tools management.
{:shortdesc}

With {{site.data.keyword.product}}, you get more application and cluster visibility across the enterprise to any public or private cloud. You can improve automation by simplifying your IT and application operations management with increased flexibility and cost savings, and intelligent data analysis driven by predictive signals.

You can also take advantage of the governance with this {{site.data.keyword.product}} because you can manage your multicloud environments with a consistent and automated set of configuration and security policies across all applications and clusters.

## Management capabilities

<img src="../images/cloud_pak_mcm.jpg" width="70%" alt="{{site.data.keyword.product}} capabilities (tiles): Event, Infrastructure, Application, Multicluster, Existing tools">

The {{site.data.keyword.product}} contains the following installable modules: {{site.data.keyword.IBM_notm}} Cloud App Management that includes {{site.data.keyword.IBM_notm}} Cloud Event Management, and {{site.data.keyword.IBM_notm}} Cloud Automation Manager. You can use these products to manage applications and clusters, as described in the following list. See [Installable modules](modules.md) for information about these products.

### Event management

Visibility with {{site.data.keyword.IBM_notm}} Cloud Event Management: You can visualize and manage multiple clusters when you install Event Management. By using Event Management, you can consolidate information from your monitoring systems and address problems. Events indicate that something happened on an application, service, or another monitored object. All events that are related to a single application, or to a particular cluster, are correlated with an incident. Event Management can receive events from various monitoring sources, either on-premises or in the cloud. Event Management is installed along with IBM Cloud App Management.

### Infrastructure management

Provisioning with {{site.data.keyword.IBM_notm}} Cloud Automation Manager: {{site.data.keyword.IBM_notm}} Cloud Automation Manager is a cloud management solution that automates provisioning of infrastructure and virtual machine applications across multiple cloud environments with optional workflow orchestration.

### Application management

Monitoring with {{site.data.keyword.IBM_notm}} Cloud App Management: Monitor cloud and on-premises application environments with {{site.data.keyword.IBM_notm}} Cloud App Management. Bridge your existing infrastructure into the cloud.

### Multicluster management

Multicluster operations and visibility:

{{site.data.keyword.product}} provides user visibility, application-centric management (governance, deployments, health, operations), and policy-based compliance across clouds and clusters. With {{site.data.keyword.product}}, you have control of your Kubernetes clusters. You can ensure that your clusters are secure, operating efficiently, and delivering the service levels that applications expect.

Using {{site.data.keyword.product}}, you have rich views of how clusters operate within the environment. You can see dashboards of aggregated information across multiple clusters, view the topology of resources within those clusters, or navigate into individual clusters consoles for more detailed views.

See the following examples of {{site.data.keyword.product}} usage:

- View health of all the clusters in a specific region.
- Know how many nodes are down in all the clusters.
- View the pods in a namespace in all development clusters
- View all the failed pods in a specific data center

You can access the description of {{site.data.keyword.product}} APIs. For more information, see [APIs](../apis/mcm_apis.md).

#### Cluster inventory
You can query information about all the clusters that are connected to the system. By using cluster labels, you can organize your clusters according to different cloud providers, geographic regions, data centers, and the functional purpose of individual clusters. From the console, you can view the health status of pods, nodes, persistent volumes, and applications that run in those clusters.

#### Application resources
You can deploy application resources on multiple clusters. {{site.data.keyword.product}} supports Helm charts as the deployment model by extending the Catalog to target multiple clusters for deployment. This complements any existing CI/CD pipelines by allowing operators the ability to deploy application charts that can be created in more than one cluster.

With {{site.data.keyword.product}}, you can define application templates that combine deployable workloads. This allows you to manage all components of an application as a single unit. Channels, subscriptions, and placement rules define where the application components are deployed and how many replicas there should be.

See [Managing applications](../mcm/applications/overview.md) for more application topics.

#### Governance and risk

{{site.data.keyword.product}} enables you to check whether your clusters are operating properly by comparing the current configuration of various resources against your desired state. The system enables you to create policy document templates that can check policies against roles, or pod objects within the clusters. See [{{site.data.keyword.product}} Governance and risk](../mcm/compliance/compliance_intro.md) for more introduction information.

#### Existing tools management

Obtain the optional license to configure Red Hat Ansible: You can integrate Red Hat Ansible to use {{site.data.keyword.product}} automation capability. See [Using Red Hat Ansible Tower](../install/ansible_tower.md) for instructions.

Obtain the optional license to configure Red Hat CloudForms: Configure {{site.data.keyword.rh_tm}} CloudForms to manage your virtual and private cloud infrastructures. See [Using Red Hat CloudForms](../install/cloudforms.md) for instructions.
