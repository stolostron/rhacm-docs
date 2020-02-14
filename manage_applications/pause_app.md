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

# Pausing a deployment

Temporarily stop a deployment or update.
{:shortdesc}

Pausing a deployment prevents more pods from provisioning to meet the deployment's **Desired Replica** value.

Running pods are not affected by a pause. If a running pod is available, then the deployment is still accessible during a pause.

**Required user type or access level**: Cluster administrator or team administrator

1. From the navigation menu, click **Workloads** > **Deployments**.
2. For the deployment that you want to pause, select **Action** > **Pause**.
3. Click **Pause**.

During the pause, the number of replicas does not change, and the desired number of replicas is not met.

You can resume the deployment at any time. See [Resuming a deployment](resume_app.md).
