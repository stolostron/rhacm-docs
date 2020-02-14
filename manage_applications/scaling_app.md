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

# Scaling deployments

Manually adjust the number of deployment instances.
{:shortdesc}

You can manually adjust the number of deployment instances.

**Note:** To define a policy that automatically scales the number of deployment replicas, see [Managing policies](../manage_policies/manage_policy.md).

**Required user type or access level**: Cluster administrator or team administrator

1. From the navigation menu, click **Workloads** > **Deployments**.
2. For the deployment that you want to scale, select **Action** > **Scale**. The "Scale deployment" window is displayed.
3. Enter the number of pods that you require.
4. Click **Scale deployment**. The number of deployed pods scales up or down to meet the new number of pods that you need.

The deployment's **DESIRED**, **CURRENT**, **READY** and **AVAILABLE**, values are updated.
