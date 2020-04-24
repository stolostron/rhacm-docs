# Getting started 

## Introduction

Review the [Architecture](architecture.md) topic and the [Components](components.md) topics to learn more about what is installed with Red Hat Advanced Cluster Management for Kubernetes.

After you learn about the hub cluster and managed cluster architecture, learn more about the [Supported clouds](../install/supported_clouds.md), which lists the cloud provider cluster options. 

The hub cluster is a Red Hat OpenShift cluster version 4.3.x or 4.4 and can run on any [supported RHOCP infrastructure](https://docs.openshift.com/container-platform/4.3/architecture/architecture-installation.html).

## Install

1. Before you install Red Hat Advanced Cluster Management for Kubernetes, review the system configuration requirements and settings at [Requirements and recommendations](../install/requirements.md). Get information about required operating systems and supported browsers. For instance, you want to ensure that you have a supported Red Hat OpenShift Container Platform version so that you can set up your hub cluster.

2. You also need to ensure that your hub cluster has the appropriate capacity. To prepare your hub cluster, see [Preparing your hub cluster for installation](../install/prep.md).

3. With a supported version of OpenShift Container Platform installed and running on your hub cluster, you can proceed with [Installing while connected online](../install/install_connected.md).

After installation, review the [Web console](../console/console_intro.md) guide to learn how to access your console and what features are available in the console.

## Manage clusters

You are now ready to create and import clusters. From your hub cluster, you can create clusters to manage and view cluster information. 

1. See [Creating a cluster](../manage_cluster/create.md) to learn about the types of managed clusters you can create. When you create a managed cluster, the new managed cluster imports automatically. 

2. If you have a cluster that you want to import manually, you can view [Importing a cluster](../manage_cluster/import.md) to learn how to import a managed cluster.

3. When you no longer need to manage a cluster, you can detach that cluster from the _Cluster page_.
## Manage applications

You can start managing applications on any created and imported managed clusters. The types of resources that you can create are applications, channels, subscriptions, and placement rules. 

1. Learn more about the resources and how to create and manage them at [Managing applications](../manage_applications/app_management_overview.md). Add or edit your `.yaml` to create your resources.

2. View and edit your resources from the _Applications Dashboard_.

## Manage security

You can also manage security and compliance across your created and imported managed clusters.

1. Create a policy using the _policy_ templates. See the [policy overview](../governance/policy_overview.md) for details about how to create a policy with a `.yaml` template.

2. From the _Policies_ page, you can view a summary of cluster and policy violations. 

3. View your policies from the _Governance and risk_ page in the console. You can also click on the cluster to view that cluster _Overview_ and learn more about any policy violations.
