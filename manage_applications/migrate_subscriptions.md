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

# Migrating subscriptions from previous versions

<!--not sure how applicaple this is, i am sure it should be removed because this is the first release, but I updated it anyways-->
If you are upgrading to Red Hat Advanced Cluster Management for Kubernetes and you have subscriptions for deploying and managing application resources, upgrade your subscriptions to indicate whether each subscription must be deployed locally or not.
{:shortdesc} 

With version {{site.data.keyword.version_cp}}, a `spec.placement.local` field is added for the subscription resource spec. This field is used to indicate whether a subscription resource must be deployed locally (`spec.placement.local: true`) or not (`spec.placement.local: false`).

In version 1.1, the subscription operator determined whether to deploy a subscription locally or not based on whether the subscription includes a `spec.placement` section. If a `spec.placement` section was included, the subscription was deployed locally.

With the `spec.placement.local` field added, all subscriptions that you migrate to {{site.data.keyword.version_cp}} are not considered local resources by default. This behavior causes the subscription operator to not deploy your resources.

To update any subscription that you are migrating so that the subscription is considered local and can be deployed, override the `spec.placement` setting for the subscription. This override needs to remove the placement settings from the previous version.

## Procedure

1. Before you upgrade your Hub cluster, update each of the subscription resources for your managed clusters to override the placement settings. Use the following YAML content to override the placement setting:

   ```yaml
   spec:
   ...
     overrides:
     - clusterName: <target cluster 1>
       clusterOverrides:
       - path: "spec.placement"
         value:
     - clusterName: <target cluster 2>
       clusterOverrides:
       - path: "spec.placement"
         value:
   ```
   {: codeblock}

2. Upgrade your Hub cluster and managed clusters. For more information, see [Upgrading multicluster endpoint](../manage_cluster/upgrade_mc_endpoint.md).

3. When your upgrade is complete for each managed cluster, edit your subscriptions again to remove the override settings.
