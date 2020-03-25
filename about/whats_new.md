---

copyright:
  years: 2020
lastupdated: "2020-03-02"

---

# What's new in Red Hat Advanced Cluster Management for Kubernetes 

Get an overivew of Red Hat Advanced Cluster Management for Kubernetes from (link arch/welcome page here)

## Installation

From a Red Hat OpenShift Container Platform cluster, you can create a hub cluster in 10 minutes or less. <Chris adds his install blurb here for Thurs>. 
  
See [Installing  Red Hat Advanced Cluster Management for Kubernetes](install/installation.md) for information about the operator-based install, which streamlines setup and ongoing cluster lifecycle.

## Cluster management

  - Create clusters to manage. Red Hat Advanced Cluster Management for Kubernetes offers a cloud-like experience for Red Hat OpenShift Container Platform clusters on your cloud infrastructure of choice. The product supports lifecycle management for multiple cloud environments, such as <example of cloud provider> cluster. See [Amazon Elastic Kubernetes Service ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")](https://aws.amazon.com/eks/)or more information about the public Kubernetes service. <Chris can add/edit content here, as well -- I pulled old link as an example, needs redone for current content>
  
  - Import and manage any Red Hat OpenShift Container Platform and other managed Kubernetes clusters as a Service. You can import clusters from different Kubernetes cloud providers, such as <need examples here>. After you import, the targeted cluster becomes a managed cluster for the Red Hat Advanced Cluster Management for Kubernetes hub cluster.

  - Manage cluster upgrade all of your clusters from one simple control plane. <Chris can add his upgrade content--I have no idea what to put here>

## Application management

Application lifecycle management offers the following capabilities:

  - Create and edit application placement rules from the console.
  - View your applications and resources from the topology page
  - Create subscriptions for GitHub channel repositories to store Kubernetes resource YAML files and unpackaged Helm charts.
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






