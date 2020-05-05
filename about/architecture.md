# Multicluster architecture

Red Hat Advanced Cluster Management for Kubernetes consists of several multicluster components, which are used to access and manage your clusters. 

![Architecture diagram](RHACM-arch.png)

Learn more about the following components for Red Hat Advanced Cluster Management for Kubernetes:

  - Hub cluster
  - Managed cluster
  - Cluster lifecycle
  - Application lifecycle
  - Governance and risk

## Hub cluster

The hub cluster is the common term that is used to define the central controller that runs in a Red Hat Advanced Cluster Management for Kubernetes cluster. From the hub cluster, you can access the console and components found on that console, as well as APIs such as the `rcm-api`, which handles API requests related to cluster lifecycle management.

The hub cluster aggregates information from multiple clusters by using an asynchronous work request model. With a graph database, the hub cluster maintains the state of clusters and applications that run on it. The hub cluster also uses `etcd`, a distributed key value store, to store the state of work requests and results from multiple clusters and provides a set of REST APIs for the various functions that it supports.

## Managed cluster

The managed cluster is the term used to define the Red Hat Advanced Cluster Management for Kubernetes `multicluster-endpoint`, which is the agent that is responsible for a single Kubernetes cluster. The managed cluster initiates a connection to the hub cluster, receives and applies requests, then returns the results. 

See [Managing your clusters](../manage_cluster/intro.md) to learn how to create and import clusters, which is part of _Cluster lifecycle_.

## Cluster lifecycle

Red Hat Advanced Cluster Management for Kubernetes cluster lifecycle defines the process of creating, importing, and managing clusters across public and private clouds. From the hub cluster console, you can view an aggregation of all cluster health statuses, or view individual health metrics. You can upgrade managed Red Hat Openshift clusters individually or in bulk, as well as destroy any Red Hat Openshift clusters clusters that you created from your hub cluster. 

You are ready to manage application resources with the Application lifecycle stage.

## Application lifecycle

Red Hat Advanced Cluster Management for Kubernetes application lifecycle defines the processes used to managed application resources. After you configure a Red Hat Advanced Cluster Management for Kubernetes hub cluster, create and import a managed cluster, you can view and deploy applications with application resources. Your _Application_ is used to only _view_ your resource, while other application resource examples are for deployment. A multi-cluster application uses a Kubernetes specification, but with additional automation of the deployment and lifecycle management of resources to individual clusters.

See [Managing applications](../manage_applications/app_management_overview.md) for more application topics.

## Governance and risk

Governance and risk is the term used to define the processes used to manage security and compliance. After you configure a Red Hat Advanced Cluster Management for Kubernetes hub cluster and a managed cluster, you can view and create policies for Red Hat Advanced Cluster Management for Kubernete with templates from the _Governance and risk_ page. For more information see, [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](../governance/compliance_intro.md).

See [Red Hat Advanced Cluster Management for Kubernetes installation](../install/install_overview.md) to prepare your cluster and get configuration information. See the [components](components.md) topic to learn more about what is installed with the product.
