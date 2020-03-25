---
copyright:
  years: 2019
lastupdated: "2019-11-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating an EKS cluster fails with an error that states cluster exists

When you attempt to create an EKS cluster after you delete a previous cluster, the log shows that the cluster is already created.
{:shortdesc}

## Symptom

When you attempt to create an EKS cluster after you delete a previous cluster, the log shows that the cluster is already created. You receive `AlreadyExistsException` in your log. <!-- Issue #773 -->

See the following display as an example:

  ```
  creating CloudFormation stack "_cluster_name_": AlreadyExistsException: Stack [_cluster_name_] already exists
  ```
  {:pre}

## Cause

After you delete your cluster, the Amazon CloudFormation stack can take about 10 minutes to delete the stack completely. If you attempt to create a cluster with the same name and region immediately before deletion is complete, you might receive `AlreadyExistsException` in the log.

## Resolve the issue

You can wait 10 mins and try to create your EKS cluster again, or you can choose to use a different cluster name.
