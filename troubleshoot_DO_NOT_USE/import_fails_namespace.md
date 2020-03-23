---
copyright:
  years: 2019
lastupdated: "2019-12-13"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Import fails when a cluster namespace exists or apiserver has an error

## Symptoms

You receive an error when you attempt to import a cluster to your hub cluster. After you finished configuring your cluster, you click  **Generate command** and receive the following message:

```
Failed creating cluster resource for import.:500:Internal server error: An issue occurred on the server.
Error creating cluster
```
{: pre}

## Causes

This error can occur when cluster namespace already exist or the `mcm` apiserver has error.

## Resolving the problem

Before you import an cluster, run the following command to check if the cluster namespace does not exist:

```
kubectl get ns |grep <cluster namespace>
```
{: codeblock}

If the error still exist, run the following commands step-by-step to see if there is no error in `rcm-api` and `core-apiserver` logs.

1. Check the `rcm-api` log to make sure there is no error. Run the following command:
   
  ```
  kubectl get pod -n kube-system|grep rcm-api
  kubectl logs -f multicluster-hub-rcm-api-657bd97864-gw8ll -n kube-system
  ```
  {: codeblock}

2. Check the `core-apiserver` log. Run the following command:

  ```
  kubectl get pod -n kube-system|grep core-apiserver
  kubectl logs -f multicluster-hub-core-apiserver-5c68f4dc4c-qfpv8 -n kube-system
  ```
  {: codeblock}

3. Restart the  `core-apiserver` pod:
   
  ```
  kubectl delete pod multicluster-hub-core-apiserver-5c68f4dc4c-qfpv8 -n kube-system
  ```
  {: codeblock}
