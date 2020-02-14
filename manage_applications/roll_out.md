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

# Rolling out updates

Update images to a newer version.
{:shortdesc}

Use this task to upgrade a deployment's image to a later version. All services remain available during a rolling update.

**Required user type or access level**: Cluster administrator or team administrator

1. To roll out updates:
2. From the navigation menu, click **Workloads** > **Deployments**.
3. For the deployment that you want to pause, select **Action** > **Rollout**.
4. Enter the new image name. You can also provide a reason for the update.
5. Click **Update**.

Replica information continuously changes during a roll-out.

When the deployment's **CURRENT**, **READY**, and **DESIRED** values are equal, the update is complete. Check the deployment's details to confirm that the update succeeded.
