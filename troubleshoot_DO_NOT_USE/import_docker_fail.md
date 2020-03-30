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

# Import cluster resource stuck in Pending state, failure to pull Docker image

If the cluster import configuration of the Docker registry fields is incorrect, you receive `ImagePullBackOff` errors on the managed cluster. As a result, the managed cluster cannot be imported.

## Symptom

Import cluster resource stays in `Pending` state because the `multicluster-endpoint` pod on your target managed cluster fails to pull the Docker image.

  ```
  kubectl get pods -n multicluster-endpoint
  NAME                                                              READY   STATUS             RESTARTS   AGE
  multicluster-endpoint-ibm-klusterlet-operator-5d6d6fc855-wpq48    1/1     ImagePullBackOff   0          31m
  ```
  {:codeblock}

## Cause

Your targeted managed cluster fails to pull the Docker image.

## Resolve the issue

To resolve, change the settings in your cluster import `config.yaml` file and update the cluster resource.  

1. Run the following command to update the cluster resource with a new import cluster-import-config.yaml configuration file.
   
  ```
  cloudctl mc cluster update -f cluster-import-config.yaml
  ```
  {:codeblock}

2. Run the following commands to apply YAML content to the cluster for import:

  ```
  cloudctl mc cluster import <cluster-name> > cluster-import.yaml
  ```
  {:codeblock}

  ```
  kubectl apply -f cluster-import.yaml
  ```
  {:codeblock}
   
Next, go through the import process.
