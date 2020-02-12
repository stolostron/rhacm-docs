---

copyright:
  years: 2019
lastupdated: "2019-11-05"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Configuring high availability for {{site.data.keyword.mcm_notm}} components

Configure high availability (HA) for {{site.data.keyword.mcm_notm}} components.
{:shortdesc}

When you configure HA for {{site.data.keyword.mcm_notm}} components, the components run with multiple replicas and the pods are preferentially deployed in different zones.

## Configure HA for {{site.data.keyword.mcm_notm}} components during cluster installation

Add the following piece of code to the `<installation_directory>/cluster/config.yaml` file. Ideally, set the value of `replicas_count` the same as the number of zones configured in your cluster.

```
multicluster-hub:
  global:
     replicas: <replicas_count>
```
{: codeblock}

Next, continue with your cluster installation.

## Configure HA for {{site.data.keyword.mcm_notm}} components after cluster installation

Complete the following steps to configure HA for {{site.data.keyword.mcm_notm}} components after cluster installation:

1. Install the Helm CLI. For more information, see [Installing the Helm CLI (helm)](../../helm-cli/3.4.0/create_helm_cli.md).

2. Get the name of the installed multicluster hub Helm release.
  ```
  helm list --tls | grep multicluster-hub
  ```
  {: codeblock}
  
  Following is a sample output:
  ```
  multicluster-hub    2    Wed May 22 21:37:27 2019    DEPLOYED    ibm-mcm-prod-3.4.0     1.0     kube-system
  ```
  {: pre}
  
3. Create an override file named `override.yaml` with the following content. Ideally, set the value of `replicas_count` the same as the number of zones configured in your cluster.
  ```
    global:
      replicas: <replicas_count>
  ```
  {: codeblock}
  
4. Run the following command to configure HA:
  ```
  helm upgrade multicluster-hub --version=3.4.0  mgmt-charts/ibm-mcm-prod -f override.yaml --tls
  ```
  {: codeblock}

## Notes:

- You must have at least three worker nodes in your cluster. 
- If you use local persistent storage for the {{site.data.keyword.mcm_notm}} `etcd`, you must have at least three management nodes in your cluster. 



