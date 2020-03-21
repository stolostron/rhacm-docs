---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-16"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Importing a target managed cluster to the hub cluster

You can import clusters from different Kubernetes cloud providers. After you import, the targeted cluster becomes a managed cluster for the Red Hat Advanced Cluster Management for Kubernetes hub cluster. Unless otherwise specified, complete the import tasks anywhere where you can access the hub cluster and the targeted managed cluster.
{:shortdesc}

Choose from the following instructions to set up your managed cluster:

**Required user type or access level**: Cluster administrator

- {: child} [Importing a cluster with the Red Hat Advanced Cluster Management for Kubernetes console](import_gui.md)
- {: child} [Importing a cluster with the CLI](import_cli.md)
- {: child} [Importing a managed cluster in an air gapped environment](offline_endpoint.md)
- {: child} [Modifying multicluster endpoint](modify_endpoint.md)


**Note:** See the _Delete with force_ section of each importing topic if you are not able to delete your imported cluster resources.
