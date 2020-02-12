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

# Importing a cluster with the {{site.data.keyword.cloud_pak_mcm}} {{site.data.keyword.gui}}

You can use the {{site.data.keyword.cloud_pak_mcm}} {{site.data.keyword.gui}} to import a cluster. You will need your terminal for authentication.
{:shortdesc}

- [Prerequisites](#prereq)
- [Preparing for import](#prep)
- [Importing a cluster](#import)
- [Deleting a cluster](#delete)

  **Note:** A hub cluster cannot manage another hub cluster.
  
## Prerequisites
{: #prereq}

* You need an {{site.data.keyword.cloud_pak_mcm}} hub cluster deployed. See [{{site.data.keyword.cloud_pak_mcm}}](../../cloudctl/install_cli.md) for installation information.
  
* You need a cluster that you want to manage.
  
## Supported architecture

* {{site.data.keyword.linux_bit_notm}}
* {{site.data.keyword.ppc_notm}}
* {{site.data.keyword.s390_notm}}

## Prepare for import 
{: #prep}

From your terminal, authenticate to your managed cluster based on your cloud provider instructions.

**Required user type or access level**: Cluster administrator

## Importing a cluster
{: #import}

You can import existing clusters from the {{site.data.keyword.cloud_pak_mcm}} {{site.data.keyword.gui}} for each of the available cloud providers.

**Note:** By default, the `multicluster-endpoint` deployment pulls all of the required images from Docker Hub. You only need to install images from DockerHub if you are working in an air gapped environment.

1. From the navigation menu, click **Clusters**.

2. Click **Add cluster**.

3. Click **Import an existing cluster...** > **Select**.

4. Provide a unique cluster name and a unique cluster namespace on the _Configure cluster_ page.

5. Click to expand **Edit cluster import YAML file** and edit the file. 

   See [_Table 1. YAML file parameters and description_](#table_1) for details about each parameter.

   **Note:** Do not remove parameters, as the {{site.data.keyword.gui}} might not properly render.
   
6. Click **Generate Command** to retrieve the command to deploy the `multicluster-endpoint`.

   **Optional**: You can add labels by clicking **Configure advanced parameters** and use these labels to search.

7. From the _Import an existing cluster_ window, hover and click the **Copy command** icon to copy the import command and the token that you are provided. Note: You must click this icon to receive the accurate copy.

8. Go to your terminal and configure your `kubectl` for your targeted managed cluster.

  See [Supported cloud providers](cloud_providers.md) to learn how to configure your `kubectl`.

9. Run the command that you generated and copied from _step 7_ to deploy the `multicluster-endpoint`.

  If you receive the following error, run the command again:

  ```
  error: unable to recognize "STDIN": no matches for kind "Endpoint" in version "multicloud.ibm.com/v1beta1"
  ```
  {: pre}

10. Click **View cluster** to view the _Overview_ page and a summary of your cluster. 

**Note** You can continue to import more clusters. Click **Import another** to repeat the process.

### YAML Parameters and descriptions
{: #table_1}

Table 1: The following table lists the parameters and descriptions that are available in the YAML file:

| Parameter | Description | Default value|
|---|---|---|
| clusterLabels| Provide cluster labels; you can add labels to your file | none |
| cloud| The cloud provider label for your cluster| auto-detect|
| vendor| The Kubernetes vendor label for your cluster| auto-detect|
| environment| The environment label for your cluster| Dev|
| region| The region where your cluster is set up| US|
| version| Version of multicluster-endpoint | 3.2.1|
| ApplicationManager| Enables multicluster manager application deployment, deploys subscription controller and deployable controller | true | 
| tillerIntegration|Enables IBM tiller to deploy Helm release| true|
| prometheusIntegration| Enables integration to IBM or OpenShift monitoring for metric collection| true|
| topologyCollector| Enables cluster topology data collection for the Topology page| true|
| searchCollector| Enables search collection and indexing | true|
| policyController| Enable the Governance and risk dashboard policy feature|true, updateInterval: 15| 
| metering| Enable the Governance and risk dashboard policy feature|false| 
| serviceRegistry| Service registry that is used to discover services that are deployed by Application Deployable among managed clusters.| false | 
| dnsSuffix| The suffix of the registry DNS name, which is added to the end of the target clusters dns domain name.|mcm.svc| 
| plugins| Comma-separated list of enabled plugins. Supported plugins: `kube-service`, `kube-ingress`, and `istio`. |kube-service|
| private_registry_enabled| Enable if using a private Docker registry | false|
| docker_username| User name for the private Docker registry | none|
| docker_password| Password for the private Docker registry | none|
| imageRegistry | The image registry from which to pull the multicluster-endpoint|ibmcom|
| imageNamePostfix| Postfix for the image name | none |
| migrateFrom320|Migration from 3.2.0 multicluster-endpoint|false|
{: caption="Table 1. Table of YAML file parameters and descriptions for import" caption-side="}

## Deleting an imported cluster
{: #delete}

Complete the following procedure to remove an imported cluster and the `multicluster-endpoint` that was created on the managed cluster.

1. From the _Clusters_ page, find your imported cluster in the table.
   
2. Click your cluster name.
   
3. From the _Overview_, click **Delete cluster**.
