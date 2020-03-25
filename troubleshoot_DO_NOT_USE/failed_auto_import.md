---
copyright:
  years: 2019
lastupdated: "2019-11-04"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Created clusters are not automatically imported

When cluster creation is complete, the cluster is imported into the hub, but there is a race condition that may prevent this from happening.


## Symptom

No import cluster resource is created for the created cluster, which causes the cluster to not be imported.

## Cause

A timing issue causes the `platform-api` pod to initiate before the `multicluster-hub-core-apiserver` pod.

## Resolve the issue

1. Verify the cause by checking the `platform-api` pod logs. See the following example output:

  ```
  {"level":"info","ts":"2019-09-26T14:50:57.827Z","msg":"starting import cluster watcher"}
  {"level":"info","ts":"2019-09-26T14:50:57.846Z","msg":"starting cluster-api watcher"}
  {"level":"info","ts":"2019-09-26T14:51:27.846Z","msg":"starting secret watcher"}
  ```
  {:pre}

2. If you do not see the `platform-api` pod change at the beginning of the logs, the `platform-api` pod needs to be deleted. Run the following command to delete the platform-api pod:

  ```  
  kubectl delete pods --selector=app=platform-api -n kube-system
  ```
  {:codeblock}
   
After you recreate the pod, auto import starts again.
