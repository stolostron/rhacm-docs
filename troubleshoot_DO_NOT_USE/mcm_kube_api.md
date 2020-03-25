---
copyright:
  years: 2019, 2020
lastupdated: "2020-03-17"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Red Hat Advanced Cluster Management for Kubernetes managed cluster cannot access the external hub cluster Kubernetes API server 

The managed cluster cannot access the hub cluster external Kubernetes API server. <!--#25273-->
{:shortdesc}

## Symptoms

When you run `cloudctl mc cluster import` to import, you receive the following error: 

  ```
  error: Cluster join request was not found in the maximum wait time.
  ```
  {: codeblock}

## Resolving the problem

If the managed cluster cannot access the hub cluster external Kubernetes API server. You can add `--kube-host` option during `cloudctl mc cluster import` to override the Kubernetes host and port of the hub cluster. See the following procedure:

1. Remove the `multicluster-endpoint` with the following command: 

    ```
    cloudctl mc cluster remove {cluster-name} -K kubeconfig | tee cluster-remove.log
    ```
    {: codeblock}

2. Retry the import step by running the import command with the `--kube-host` option. See the following command:

    ```
    cloudctl mc cluster import -f <cluster-import.yaml> -K kubeconfig --kube-host https://<hub-api-address>:<hub-api-server-port> | tee cluster-import.log
    ```
    {: codeblock}

