---

copyright:
  years: 2019
lastupdated: "2019-12-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Mutation Advisor Advanced (MA++)

Mutation Advisor Advanced (MA++) provides real-time, integrity protection for running containers on your clusters. Enable MA++ to collect events from your containers.
{:shortdesc}

MA++ uses a Sysdig/Falco data collector to detect mutation events for files and processes, in real time. For more information, see [Falco ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](http://falco.org){: new_window}. 

MA++ detects unexpected mutation events by filtering event patterns. MA++ is integrated with the Security Advisor and Mutation Advisor controller. Mutation Advisor Advanced (MA++) functions are independent of the Mutation Advisor, except for the Minio COS and Elasticsearch. 

For more information about MA++ components, see the _Mutation Advisor Advanced (MA++)_ section in the [Multicluster config.yaml file settings](../../install/config_mcm.md).

## Enabling Mutation Advisor Advanced

**Prerequisite**: You must install the kernel headers in the host (node) operating system. For more information, see the _Docker_ section in [Installing Falco ![Opens in a new tab](../../images/icons/launch-glyph.svg "Opens in a new tab")](https://falco.org/docs/installation/#docker){: new_window}. 

* To install Falco on Ubuntu, run the following command:  

   ```
   apt-get -y install linux-headers-$(uname -r)
   ```
   {: codeblock}

* To install Falco on {{site.data.keyword.rhel}} ({{site.data.keyword.rhel_short}}), run the following command:
   
   ```
   yum -y install kernel-devel-$(uname -r)
   ```
   {: codeblock}

## MA++ APIs

Before you run MA++ API commands, retrieve the authentication token and download the CA certificate for your cluster. For more information, see [Preparing to run component or management API commands](../../iam/3.4.0/apis/access_api.md). For information about accessing MA++ APIs, see [Mutation Advisor Advanced (MA++) APIs](../../apis/mapp_api.json).

## Accessing reports

You can view the modification alerts of system files, configuration files, content files, or the operating system process. You can access the MA++ {{site.data.keyword.gui}} from the {{site.data.keyword.product}} {{site.data.keyword.gui}}. Complete the following steps to access the MA++ dashboard:

1. Log in to your {{site.data.keyword.product}} {{site.data.keyword.gui}}.
2. From the navigation menu, click **Add-ons** > **Mutation Advisor**.
3. Click **Go to Mutation Advisor (Advanced)** to view the dashboard. 
4. Click the _Clusters_ tab to view cluster MA++ report summaries.
5. Click the _List Containers_ tab to view namespace MA++ report summaries.
6. Click the _Whitelist_ tab to view filter and whitelist rules in MA++.

## Configuring Mutation Advisor Advanced

Access the MA++ `mutation-advisor-mapp-crawler-filter` configuration map to update the file. Complete the follwoing steps:

1. Log in to your {{site.data.keyword.product}} {{site.data.keyword.gui}}.

2. Select the **Terminal** icon ![web terminal icon](../../images/icons/vwt_icon.jpg "web terminal icon") in the header.
**Remember:** The {{site.data.keyword.kui}} connects to the cloud that you are already logged into with the {{site.data.keyword.gui}}.

3. Edit the `mutation-advisor-mapp-crawler-filter` configuration map by running the following command in the terminal:

   ```
   kubectl edit cm -n kube-system mutation-advisor-mapp-crawler-filter
   ```
   {: codeblock}
   
   The configuration map includes the `config.json` file, which lists the configuration maps that are used to whitelist and filter. Your configuration file might resemble the following content:
   
      ```
      apiVersion: v1
      data:
        mapp-sample-filter-user.json: 
          [
            {
              "k8s.ns.name": "mutation-advisor-samle",
              "k8s.pod.name": "mutation-advisor-sample",
              "container.name": "*",
              "m_type": "*"
              "key": "proc.cmdline",
              "operator": "prefix", 
              "value": "sample_filter", 
              "enable": false
            }
          ]
        mapp-sample-whitelist-user.json: 
          [
            {
              "container.image.repository": "*", 
              "container.image.tag": "*",
              "k8s.ns.name": "mutation-advisor-sample", 
              "k8s.pod.name": "mutation-advisor-sampl",
              "container.name": "*", 
              "m_type": "*", 
              "key": "proc.cmdline",
              "value": "sample_whitelist", 
              "enabled": false
            }
          ]
        ```
        {: pre}

### Configuring whitelists and filters

MA++ detects unexpected changes of files and processes from system level events in your container. You can filter and whitelist specific mutation events or alerts. 

*Filter* is used to define an ignore pattern when events are collected at the MA++ crawler.

*Whitelist* is used to define an ignore pattern when mutation alerts are gathered at the MA++ aggregator. 

Configure *Filter* and *Whitelist* by updating your `mutation-advisor-mapp-crawler-filter-user` configuration map. The `data` parameter in your `mutation-advisor-mapp-crawler-filter-user` configuration map might resemble the following configuration:

   ```
   data:
     config.json: '{"configs":[{"name":"mutation-advisor-mapp-crawler-filter-system","namespace":"kube-system","filter":"shared-filter-system.json"},{"name":"mutation-advisor-mapp-crawler-filter-user","namespace":"kube-system","filter":"shared-filter-user.json"},{"name":"mutation-advisor-mapp-crawler-filter-auto","namespace":"kube-system","filter":"shared-filter-auto.json"},{"name":"mutation-advisor-mapp-crawler-wl","namespace":"kube-system","filter":"crawl-filter.json","whitelist":"mutation-filter.json"}]}'
   ```
   {: pre}

#### Defining rules

To define whitelists and filters, you can update your `mutation-advisor-mapp-crawler-filter-user` configuration map. You can define a set of rules for filters and whitelists. For example, your filter rule might resemble the following configuration:

   ```
   [
       {
           "k8s.ns.name": "*",
           "k8s.pod.name": "*",
           "container.name": "*",
           "m_type": "*",
           "key": "proc.cmdline",
           "operator": "prefix",
           "value": "ibmc-s3fs",
           "enabled": true
       },
       ....
   ```
   {: pre}

View the table description of the parameters used in your `mutation-advisor-mapp-crawler-filter-user` configuration map: 

| Parameter name           | Required configuration| Example | Description | 
| ----           | ---- | ---- | ---- | 
| k8s.ns.name    | Filter | `"kube-*"` | The name of the target namespace; wildcard `*` can be used. | 
| k8s.pod.name   | Filter | `"mutation-advisor-*"` | The name of the target pod; wildcard `*` can be used.  | 
| container.name | Filter | `"*"` | The name of the target container; wildcard `*` can be used.   | 
| container.image.repository | Whitelist | `"*"` | The name of the target container; wildcard `*` can be used. | 
| container.image.tag | Whitelist | `"*"` | The name of the target container; wildcard `*` can be used.   | 
| m_type         | Filter and whitelist | `"process or file"` | The type of target mutation pattern; wildcard `*` can be used.  | 
| key            | Filter and whitelist | `"proc.cmdline"`, `"filename"` | The key for the filter. | 
| operator       | Filter and whitelist | `"match"`, `"prefix"` | A comparison of mutation events. | 
| value          | Filter and whitelist | `"ls -l"`, `"/var/log/"` | A list the mutation events.  | 
| enabled        |  | `true` | The toggle switch filter. When the value is `false`, filter feature is ignored. When the `enabled ` field is empty, the filter is enabled. | 
{: caption="Table 1. Description of the syntax to define rules." caption-side="top"}

#### Viewing rules

Complete the following steps to view rules from the MA++ {{site.data.keyword.gui}}:

1. Log in to your {{site.data.keyword.product}} {{site.data.keyword.gui}}.
2. From the navigation menu, click **Add-ons** > **Mutation Advisor**.
3. Click **Go to Mutation Advisor (Advanced)** to view the MA++ dashboard.
4. Click **Whitelist** to view the list of rules. 

### Configuring Security Advisor 

You can integrate MA++ alerts with the Security Advisor. Install the Security findings API and configure MA++ aggregator to enable alerts and notification from the Security Advisor dashboard. For more information, see [Security findings API](../../apis/sa_api.json).

Configure your `mutation-advisor-mapp-aggregator` deployment to enable MA++ notifications from Security Advisor. Your `mutation-advisor-mapp-aggregator` might resemble the following configuration: 

   ```yaml
         containers:
         - name: summarizer
           env:
           - name: SA_EVENT_FW_ENABLED
             value: "true"
           - name: SA_PROXY_ENABLED
             value: "true"
           - name: SA_CLUSTER_NAME
             value: "local-cluster"
           - name: SA_ACCOUNT_ID
             value: "id-mycluster-account"
           - name: SA_FINDING_IP
             value: kubernetes.default:443
           - name: HUB_K8S_SECRET_NS
             value: "multicluster-endpoint"
           - name: HUB_K8S_SECRET_NAME
             value: "multicluster-endpoint-hub-kubeconfig"
   ```
   {:pre}
