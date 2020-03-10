---

copyright:
  years: 2016, 2020
lastupdated: "2020-03-10"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Managing policies

Create and maintain deployment policies. Deployment policies automatically scale the number of deployment replicas.
{:shortdesc}

The CPU usage of deployments drives replica scaling in a cluster.

## Automatic scale up

A scale up is triggered during increased CPU demand, such as when a server experiences high levels of requests. The following condition automatically triggers a scale up operation:

```
CURRENT_CPU_UT >1.1*TARGET_CPU_UT
```
{: codeblock}

When a deployment scales up, its `DESIRED`, `CURRENT`, and `READY` parameter values increase. You can check these values from the deployments home page. 

## Automatic scale down

A scale down is triggered when a server enters an idle state or CPU demand decreases. The following condition automatically triggers a scale down operation:

```
CURRENT_CPU_UT < 0.9*TARGET_CPU_UT
```
{: codeblock}

When an deployment scales down, its DESIRED, CURRENT, and READY parameter values decrease. You can check these values from the deployments home page. 

- {: child} [Creating a deployment policy](../compliance/create_policy.md) <br />
- {: child} [Updating a deployment policy](../compliance/update_policy.md) <br />
- {: child} [Removing a deployment policy](../compliance/remove_policy.md) <br />
{: childlinks}
