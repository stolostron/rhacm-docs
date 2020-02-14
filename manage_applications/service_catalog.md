---

copyright:
  years: 2017, 2019
lastupdated: "2019-11-14"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Managing Service {{site.data.keyword.catalog}} resources

You can manage the Service {{site.data.keyword.catalog}} from the command line interface (CLI) and the {{site.data.keyword.gui}}. The Service {{site.data.keyword.catalog}} component adds five Kubernetes resources that you can use.
{: shortdesc}

- [Service {{site.data.keyword.catalog}} resource details](#resource_details)
- [Managing the Service {{site.data.keyword.catalog}} resources with command line interface](#service_cli)
- [Managing the Service {{site.data.keyword.catalog}} resources from the {{site.data.keyword.icp_notm}} {{site.data.keyword.gui}}](#service_gui)

## Service {{site.data.keyword.catalog}} resource details
{: #resource_details}

| Resource | Resource details |
| ------------- | ------------- |
| <ul><li>ClusterServiceBroker</li><li> ServiceBroker</li></ul> | Manages a set of one or more services |
| <ul><li>ClusterServiceClass</li><li> ServiceClass</li></ul> | Describes the service and associated plans that the broker offers for each service |
| <ul><li>ClusterServicePlan</li><li>ServicePlan</li></ul> | Describes the plans that are offered for the service |
| <ul><li>ServiceInstance</li></ul>| Creates an instance of a managed service that is available for use by one or more in-cluster applications |
| <ul><li>ServiceBinding</li></ul> | ServiceBinding refers to and uses a ServiceInstance. It also creates a Kubernetes secret that contains the connection details and credentials for the service that is represented by the ServiceInstance |

{: caption="Table 1. Service {{site.data.keyword.catalog}} resource details" caption-side="top"}

## Managing the Service {{site.data.keyword.catalog}} resources with command line interface
{: #service_cli}

You can use the eight resources from the `kubectl` command line interface. The following table describes the scope and usage of the resources:

| Kubernetes Resource        | Scope     | Example usage |
|-----------------|-----------|---------------------|
| ClusterServiceBrokers | cluster | `kubectl get clusterservicebrokers` |
| ClusterServiceClasses | cluster  | `kubectl get clusterserviceclasses` |
| ClusterServicePlans | cluster   | `kubectl get clusterserviceplans` |
| ServiceBrokers | namespace | `kubectl get servicebrokers -n <namespace>` |
| ServiceClasses | namespace | `kubectl get serviceclasses -n <namespace>` |
| ServicePlans | namespace| `kubectl get serviceplans -n <namespace>` |
| ServiceInstances | namespace | `kubectl get serviceinstances -n <namespace>` |
| ServiceBindings | namespace | `kubectl get servicebindings -n <namespace>` |
{: caption="Table 1. Kubernetes resources for the service catalog" caption-side="top"}

You can extend the capabilities of your {{site.data.keyword.icp_notm}} cluster by integrating with services that are deployed in your {{site.data.keyword.icp_notm}} cluster or external cluster. See [Creating a service broker resource from the command line interface](../manage_applications/creating_broker.md) for more details.


## Managing the Service {{site.data.keyword.catalog}} resources from the {{site.data.keyword.icp_notm}} {{site.data.keyword.gui}}
{: #service_gui}

You can load and deploy brokers as Helm charts from the {{site.data.keyword.icp_notm}} {{site.data.keyword.catalog}} from the {{site.data.keyword.gui}}. The charts include the registration and authorized secret creation template. Helm Charts can include the templates for deployment of a broker, if it needs to be deployed inside a cluster.

Broker services that are available for deployment are listed in the {{site.data.keyword.catalog}} view along with Helm charts. Services can be identified with the `service` label.

After a service broker is registered with your operating system, you can select the services and internal plans of each service in the {{site.data.keyword.catalog}}.

{{site.data.keyword.icp_notm}} supports the service details page. The service details page contains an overview of the service and lists the available plans, the process of deployment and creating an instance of the service, and the option of service binding.

  **Note:** Under role-based access control _(RBAC)_, only the cluster administrator has permission to deploy and register broker charts and get all ClusterServiceClasses and ClusterServicePlans. The ClusterServiceClasses and ClusterServicePlans resources are assigned to the team.

See [Creating a service broker resource from the {{site.data.keyword.gui}}](../manage_cluster/creating_broker_ui.md) for more details.
