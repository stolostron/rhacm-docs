---

copyright:
  years: 2020
lastupdated: "2020-03-02"

---

# What's new in Red Hat Advanced Cluster Management for Kubernetes 

Get an overivew of Red Hat Advanced Cluster Management for Kubernetes from the [Product Welcome page](../about/welcome.md). See the [architecture page](../about/architecture.md) to learn more about major components of the product. 

To learn about the Red Hat Advanced Cluster Management for Kubernetes console capabilities, see [Observability in the console](../console/console_intro.md).

## Installation

With operator-based installation, you can install a working Red Hat OpenShift cluster on a configured cloud provide, such as Amazon Web Services, in less than 10 minutes. See [Installing Red Hat Advanced Cluster Management for Kubernetes when connected](../install/install_connected.md) for more information.  
  
## Cluster management

* Create clusters on various Kubernetes cloud service providers. You can provision and manage Red Hat OpenShift Container Platform clusters on selected Kubernetes cloud service providers. See [Creating a cluster with Red Hat Advanced Cluster Management for Kubernetes](../manage_cluster/create.md) for more information. 

* Import existing Kubernetes clusters. Import your existing Kubernetes clusters that are hosted on popular cloud service providers, or on private clouds to manage your clusters conveniently in one place. See [Importing a target managed cluster to the hub cluster](../manage_cluster/import.md) for more information.

* Manage all of your Red Hat OpenShift Container Platform cluster upgrades in one interface. You can upgrade imported and provisioned Red Hat OpenShift Container Platform clusters either individually or in groups by using the console.

## Application management

Create and manage applications across environments through channel and subscription-based automation. You can also view your applications and resources from the topology page in the console. Application lifecycle management offers the following capabilities:

* Applications (`Application.app.k8s.io`) in Red Hat Advanced Cluster Management for Kubernetes, which are used for grouping applition components. You can scale applications with the application model.

* Deployables (`Deployable.apps.open-cluster-management.io`) are Kubernetes resources that contain templates to wrap other Kubernetes resources or to represent Helm releases for deployment to clusters.

* Placement rules (`PlacementRule.apps.open-cluster-management.io`) define the target clusters where deployables can be deployed. Create and edit application placement rules from the console.

* Channels (`Channel.apps.open-cluster-management.io`) define a namespace within the hub cluster and a place where resources are stored for deployment.
 
* Subscriptions (`Subscription.apps.open-cluster-management.io`) are sets of definitions that identify deployables within channels by using annotations, labels, and versions. 

  - Use subscription annotations, labels, and versions, which are Kubernetes resources that serve as sets of definitions for identifying resources and Helm charts within channels.
  
  - Schedule subscription activity for specific time windows to control deployments and upgrades to your managed clusters.
  
  - Store and deploy Kubernetes secrets through subscriptions.

For more information, see [Managing applications](../manage_applications/overview.md).

## Security and compliance

With the Governance and risk dashboard, you can view and manage the number of security risks and policy violations in your clusters and applications. Create custom policy controllers to report and validate the compliance of your policies on your cluster. Create and manage the following policy controllers that are installed by default:

* [Certificate policy controller](../governance/cert_policy_ctrl.md)
* [Configuration policy controller](../governance/config_policy_ctrl.md)
* [IAM policy controller](../governance/iam_policy_ctrl.md)

See [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](../governance/compliance_intro.md) to learn more about the dashboard and the policy framework.

As you create policies, use the policy element, `templates` to describe how your resource is defined. For more information about the policy elements, see [Red Hat Advanced Cluster Management for Kubernetes policy overview](../governance/policy_overview.md). 
