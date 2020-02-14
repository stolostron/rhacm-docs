---

copyright:
  years: 2016, 2018
lastupdated: "2018-01-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Resuming an deployment

Resume a paused deployment or update.
{:shortdesc}

**Required user type or access level**: Cluster administrator or team administrator

1. From the navigation menu, click **Workloads** > **Deployments**.
2. For the deployment that you want to resume, select **Action** > **Resume**.
3. Click **Resume**.

The number of pods adjusts to meet the replica level.

When the deployment's **CURRENT**, **READY**, and **DESIRED** values are equal, the deployment is fully resumed.
