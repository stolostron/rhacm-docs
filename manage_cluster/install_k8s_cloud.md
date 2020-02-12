---

copyright:
  years: 2019
lastupdated: "2019-12-12"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Importing a target managed cluster to the hub cluster

You can import clusters from different Kubernetes cloud providers. After you import, the targeted cluster becomes a managed cluster for the {{site.data.keyword.mcm_notm}} hub cluster. Unless otherwise specified, complete the import tasks anywhere where you can access the hub cluster and the targeted managed cluster.
{:shortdesc}

#### Notes:

1. You need the monitoring service enabled on your hub cluster if you want monitoring integrated with your managed cluster after import.
   
2. If you want to see metering data for all managed clusters, you must enable the {{site.data.keyword.mcm_notm}} metering service on your hub cluster and also when you add managed clusters. By default, metering is disabled when you add managed clusters.

Choose from the following instructions to set up your managed cluster:

**Required user type or access level**: Cluster administrator

- {: child} [Importing a cluster with the {{site.data.keyword.mcm_notm}} {{site.data.keyword.gui}}](../manage_cluster/import_gui.md)
- {: child} [Importing a cluster with the CLI](../manage_cluster/import_cli.md)
- {: child} [Importing a managed cluster in an air gapped environment](offline_endpoint.md)


**Note:** See the _Delete with force_ section of each importing topic if you are not able to delete your imported cluster resources.
