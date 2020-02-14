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

# Rolling back an update

You can revert your image to a previous version.
{:shortdesc}

You might revert your image if the current version is not stable.

**Required user type or access level**: Cluster administrator or team administrator

1. From the navigation menu, click **Workloads** > **Deployments**.
2. For the deployment that you want to roll back, select **Action** > **Rollback**.
3. Select the previous image version to apply.
4. Click **Rollback**.

Replica information continuously changes during a rollback.

When the deployment's **CURRENT**, **READY**, and **DESIRED** values are equal values are equal, the rollback is complete. Check the deployment's details to confirm that the rollback succeeded.
