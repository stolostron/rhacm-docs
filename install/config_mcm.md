---

copyright:
  years: 2016, 2020
lastupdated: "2020-03-02"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Multicluster config.yaml file settings

The `config.yaml` file contains all the configuration settings that are needed to deploy your cluster.
{:shortdesc}

From the `config.yaml` file, you can customize your installation by using various parameters.

**Note:** Before you update any section of the `config.yaml` file, review the inline comments in that section.

You can set or update the following parameters by modifying the `config.yaml` file.

1. Open the `/<installation_directory>/cluster/config.yaml` file.
2. Add or modify the parameters and values. The format for defining a parameter and values is `<parameter_name>:<value>`.

  * Table 1. [Multicluster-hub settings](#mcm-hub)
  * Table 2. [Vulnerability Advisor (VA) settings](#va)

## Multicluster-hub settings
{: #mcm-hub}

|Parameter|Description|Default value|
|---------|-----------|-------------|
|`multicluster-hub:`|Configure multicluster hub parameters. | |
|&nbsp;&nbsp;`etcd:`|Configure etcd parameters for multicluster hub. ||
|&nbsp;&nbsp;&nbsp;&nbsp;`persistence:`|Enable or disable the persistence volume for etcd. |false |
|&nbsp;&nbsp;&nbsp;&nbsp;`localPath:`|The local directory for persistence volume in all management nodes for etcd. |/var/lib/etcd-mcm |
{: caption="Table 1. Multicluster-hub settings for the IBM Cloud Pak for Multicloud Management" caption-side="top"}

## Vulnerability Advisor (VA) settings
{: #va}

|Parameter|Description|Default value|
|---------|-----------|-------------|
|`vulnerability-advisor.runtimeEngine:`|<ul><li>Set to `cri-o` when you use {{site.data.keyword.product}}.</li><li>For {{site.data.keyword.open_s}} version 3.0, set to `docker`.</li><li>For {{site.data.keyword.open_s}} version 4.0, set to `cri-o`.</li></ul>|`cri-o`|
|`esServiceName:`|<ul><li>Set to `elasticsearch` when you use {{site.data.keyword.product}} logging.</li><li>When you use {{site.data.keyword.open_s}} version 3.0, set to `logging-es.openshift-logging.svc.cluster.local`.</li><li>When you use {{site.data.keyword.open_s}} version 4.0, set to `elasticsearch.openshift-logging.svc.cluster.local`.</li></ul> | `elasticsearch` |
|`es_secret.name:`|<ul><li>Set to `logging-elk-certs` when you use {{site.data.keyword.product}} logging.</li><li>For {{site.data.keyword.open_s}} version 3.0, set to `logging-elasticsearch`.</li><li>For {{site.data.keyword.open_s}} version 4.0, set to `elasticsearch`.</li></ul> | `logging-elk-certs` |
|`es_secret.ca:`|<ul><li>Set to `ca-crt` when you use {{site.data.keyword.product}} logging For {{site.data.keyword.open_s}} version 3.0 and 4.0, set to `admin-ca`.</li></ul> | `ca.cert` |
|`es_secret.cert:`|<ul><li>Set to `curator.crt` to when you use {{site.data.keyword.product}} logging.</li><li>For {{site.data.keyword.open_s}} version 3.0 and 4.0, set to `admin-cert`.</li></ul>  |`curator.crt`|
|`es_secret.key:`|<ul><li>Set to `curator.key` when you use {{site.data.keyword.product}} logging.</li><li>For {{site.data.keyword.open_s}} version 3.0 and 4.0, set to `admin-key`.</li></ul> | `curator.key`|
{: caption="Table 2. Vulnerability Advisor settings" caption-side="top"}

