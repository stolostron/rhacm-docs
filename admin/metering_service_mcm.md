---

copyright:
  years: 2019
lastupdated: "2019-12-03"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Metering service
Use metering to understand how resources are used by your Kubernetes deployments over time.
{: shortdesc}

**Required user type or access level:** Cluster Administrator

You can use metering data to report usage back to central IT or procurement organizations for chargeback purposes. Metering is also used to feed the {{site.data.keyword.IBM}} License Metric Tool. While metering is not a sanctioned license management tool, it helps you collect data to send to those tools for processing.

Use metering as a method to quickly check on resources from a managed cluster, and the resources that are being used by a deployment on a managed cluster.

All {{site.data.keyword.cloud_paks}} and {{site.data.keyword.contain_softs}} are pre-configured for metering, making it easy to track deployments of {{site.data.keyword.IBM_notm}} products over time.

Metering is automatically deployed and configured when you first instantiate your hub cluster. Then, it aggregates data from across your managed clusters. Metering offers views of resources from the managed clusters, and the products and workloads that run on those clusters.

By default, metering is disabled when you import new clusters. To receive metering data when you add a cluster, you must either enable the metering service when the cluster is added or enable the metering service on new clusters post installation. For more information see, [Importing a target managed cluster to the {{site.data.keyword.mcm_notm}} hub cluster](../mcm/installing/install_k8s_cloud.md) or [Modifying the multicluster endpoint settings of your cluster](../mcm/manage_cluster/modify_mc_end.md).

**Note:** The metering service takes up to 24 hours to start reporting metering data for the newly added clusters.

## Viewing metering data

To view cluster data, from the {{site.data.keyword.mcm_notm}} {{site.data.keyword.gui}} menu, select **Administer** > **Metering**. Select the **Clusters** tab to view resources from the managed clusters, and the maximum available cores and nodes managed by each cluster for the current month. Additionally, a downloadable report is available to show the monthly data for all managed clusters.

To view product data, from the {{site.data.keyword.mcm_notm}} {{site.data.keyword.gui}} menu, select **Administer** > **Metering**. Select the **Products** tab to view the products, workloads, and {{site.data.keyword.cloud_paks}} for each managed cluster where metering is enabled on the endpoint. The maximum allocated cores for each workload in each namespace in each managed cluster is shown. The maximum allocated cores is the assigned limit of cores for the workload for chargeback purposes. Maximum allocated cores can be greater than the actual core usage by the workload.

To view detailed metering data for workloads running on the hub cluster, from the Metering dashboard, click **Options** icon and select **Local metering**.

## Metering reports

The first section of the multi-cluster report shows the maximum number of nodes that are managed by {{site.data.keyword.mcm_notm}} at any point in each month, and the maximum worker nodes for each managed cluster. The maximum for {{site.data.keyword.mcm_notm}} might or might not match the sum of the nodes on each cluster. It depends on when, during the month, each cluster was added to or removed from {{site.data.keyword.mcm_notm}} control. The cluster level maximums are included only to allow chargeback. The multi-cluster report also shows the total available cores for each managed cluster.

The second section of the multi-cluster report shows the metrics of workloads and cloudpaks.

To download a .csv file that contains a monthly report of application metrics data, click **Download Report**.

### Reading the report .csv file

The report is in CSV format, which can be loaded by any modern spreadsheet software. However, as CSV files do not include formatting details, it might be necessary to expand columns of interest to see all the data.

The report is organized into sections by month. The oldest tracked month appears at the beginning of the section and the newer months appear at the end of the section.
* The **Period** column displays the year and month of the section on each row.
* The **Status** column displays whether the section is `FINAL` or `PENDING`. The most recent month is marked as `PENDING`. More metering data might still be processed and these report sections updated. When a section is marked `FINAL`, it is no longer being updated.

Within each monthly section, the data is further separated into the following categories:
* Overall summary of managed clusters
* Summary by cluster
* Summary of workloads and cloudpaks of managed clusters

You can also use the following `cloudctl metering` commands to get metering reports.

* [cloudctl metering full-report](#full-report)
* [cloudctl metering mcm-report](#mcm-report)
* [cloudctl metering workload-report](#workload-report)

#### cloudctl metering full-report
{: #full-report}

Download the full report.

- Example

```
cloudctl metering full-report
```
{: codeblock}

#### cloudctl metering mcm-report
{: #mcm-report}

Download the multi-cluster report.

- Example

```
cloudctl metering mcm-report
```
{: codeblock}

#### cloudctl metering workload-report
{: #workload-report}

Download the workload report.

- Example

```
cloudctl metering workload-report
```
{: codeblock}
