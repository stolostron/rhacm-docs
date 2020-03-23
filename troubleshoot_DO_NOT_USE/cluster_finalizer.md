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

# Import cluster resource is stuck in Terminating because of platform-api cluster finalizer

When you remove a cluster resource, it might stuck as an endless state of `Terminating` because a finalizer on the resource is not removed. A bug in the `platform-api`, as a result of timing, keeps this finalizer from getting removed.

## Symptom

Import cluster resource is stuck in `Terminating` state because of a `platform-api` cluster finalizer timing issue.

## Cause

The `platform-api` pod initiates before the `multicluster-hub-core-apiserver` pod.

## Resolve the issue

1. Verify the cause by checking the `platform-api` pod logs. See the following example output:

  ```
  {"level":"info","ts":"2019-09-26T14:50:57.827Z","msg":"starting import cluster watcher"}
  {"level":"info","ts":"2019-09-26T14:50:57.846Z","msg":"starting cluster-api watcher"}
  {"level":"info","ts":"2019-09-26T14:51:27.846Z","msg":"starting secret watcher"}
  ```
  {:pre}

2. If you do not see the the `platform-api` pod change at the beginning of the logs, the `platform-api` pod needs to be deleted. Run the following command to delete the `platform-api` pod:
   
  ```
  kubectl delete pods --selector=app=platform-api -n kube-system
  ```
  {:codeblock}
   
After you re-create the pod, auto import starts again.
