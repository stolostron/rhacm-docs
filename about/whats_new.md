---

copyright:
  years: 2020
lastupdated: "2020-03-02"

---

# What's new in Red Hat Advanced Cluster Management for Kubernetes 

Get an overivew of Red Hat Advanced Cluster Management for Kubernetes from (link arch/welcome page here)

## Installation

* Operator-based installation can install a working Red Hat OpenShift cluster on a configured cloud provider, like Amazon Web Services, in less than 10 minutes. See [Installing Red Hat Advanced Cluster Management for Kubernetes when connected](../install/install_connected.md) for more information.  
  
## Cluster management

* Create clusters on various Kubernetes cloud service providers. You can provision and manage Red Hat OpenShift Container Platform clusters on selected Kubernetes cloud service providers. See [Creating a cluster with Red Hat Advanced Cluster Management for Kubernetes](../manage_cluster/create.md) for more information. 
* Import existing Kubernetes clusters. Import your existing Kubernetes clusters that are hosted on popular cloud service providers or on private clouds to manage your clusters conveniently in one place. See [Importing a target managed cluster to the hub cluster](../manage_cluster/import.md) for more information.
* Manage all of your Red Hat OpenShift Container Platform cluster upgrades in one interface. You can upgrade imported and provisioned Red Hat OpenShift Container Platform clusters either individually or in groups by using the console.
 Import existing Kubernetes clusters. Import your existing Kubernetes clusters that are hosted on popular cloud service providers or on private clouds to manage your clusters conveniently in one place. See [Importing a target managed cluster to the hub cluster](../manage_cluster/import.md) for more information.
* Manage all of your Red Hat OpenShift Container Platform cluster upgrades in one interface. You can upgrade imported and provisioned Red Hat OpenShift Container Platform clusters either individually or in groups by using the console.


## Application management

Application lifecycle management offers the following capabilities:

  - Create and edit application placement rules from the console.
  - View your applications and resources from the topology page
  - Use subscription annotations, labels, and versions, which are Kubernetes resources that serve as sets of definitions for identifying resources and Helm charts within channels.
  - Schedule subscription activity for specific times to control deployments and upgrades to your managed clusters.
  - Store and deploy Kubernetes secrets through subscriptions.

For more information, see [Managing applications](manage_applications/overview.md).

## Security and compliance

With the Governance and risk compliance dashboard, you can view and manage the number of security risks and policy violations in your clusters and applications. Create custom policy controllers to report and validate the compliance of your policies on your cluster. Create and manage the following policy controllers that are installed by default:

* [Certificate policy controller](../compliance/cert_policy_ctrl.md)
* [Configuration policy controller](../compliance/config_policy_ctrl.md)
* [IAM policy controller](../compliance/iam_policy_ctrl.md)

See [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](../compliance/compliance_intro.md) to learn more about the dashboard and the policy framework.

As you create policies, use the policy element, `templates` to describe how your resource is defined. For more information about the policy elements, see [Red Hat Advanced Cluster Management for Kubernetes policy overview](../compliance/policy_overview.md). 






