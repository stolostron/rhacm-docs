---

copyright:
  years: 2020
lastupdated: "2019-03-11"

---

# Importing an existing cluster with the console

You can use the Red Hat Advanced Cluster Management for Kubernetes console to import an existing cluster. You will need your terminal for authentication.

- [Prerequisites](#prereq)
- [Importing a cluster](#import)
- [Deleting a cluster](#delete)

  **Note:** A hub cluster cannot manage another hub cluster.
  
## Prerequisites
{: #prereq}

* You need an Red Hat Advanced Cluster Management for Kubernetes hub cluster deployed. 
* You need a cluster that you want to manage. 
* Install `kubectl` (get site here)
* You need the `base64` command line tool.

**Required user type or access level**: Cluster administrator

## Importing a cluster
{: #import}

You can import existing clusters from the Red Hat Advanced Cluster Management for Kubernetes console for each of the available cloud providers. <!-- IKS EKS GKE AKS ROKS and any OpenShift 4X or 311 cluster -->

1. From the navigation menu, hover over Automate infrastructure and click **Clusters**.

2. Click **Add cluster**.

3. Click **Import an existing cluster**.

4. Provide a cluster name. By default, the namespace is set to the same value as your cluster name. Optional: You can edit the namespace.

5. Optional: Click to expand **Edit cluster import YAML file** and modify the endpoint configuration. 

   See [_Table 1. YAML file parameters and description_](#table_1) for details about each parameter.

6. **Optional**: You can add labels by clicking **Configure advanced parameters** and use these labels to search.
   
7. Click **Generate Command** to retrieve the command to deploy the `multicluster-endpoint`.

8. From the _Import an existing cluster_ window, hover and click the **Copy command** icon to copy the import command and the token that you are provided. Note: You must click this icon to receive the accurate copy.

9. From your terminal, authenticate to your managed cluster. Configure your `kubectl` for your targeted managed cluster.

  See [Supported cloud providers](../install/cloud_providers.md) to learn how to configure your `kubectl`.

9. Run the command that you generated and copied from _step 8_ to deploy the `multicluster-endpoint`.

  If you receive the following error, run the command again:

  ```
  error: unable to recognize "STDIN": no matches for kind "Endpoint" in version "multicloud.ibm.com/v1beta1"
  ```

10. Click **View cluster** to view the _Overview_ page and a summary of your cluster. 

**Note** You can continue to import more clusters. Click **Import another** to repeat the process.

### YAML Parameters and descriptions
{: #table_1}

Table 1: The following table lists the parameters and descriptions that are available in the YAML file:

| Parameter | Description | Default value|
|---|---|---|
| clusterLabels| Provide cluster labels; you can add labels to your file | none |
| clusterLabels.cloud| The cloud provider label for your cluster| auto-detect|
| clusterLabels.vendor| The Kubernetes vendor label for your cluster| auto-detect|
| clusterLabels.environment| The environment label for your cluster| none|
| clusterLabels.region| The region where your cluster is set up|none|
| ApplicationManager.enabled| Enables multicluster manager application deployment, deploys subscription controller and deployable controller | true | 
| searchCollector.enabled| Enables search collection and indexing | true|
| policyController.enabled| Enable the Governance and risk dashboard policy feature|true, updateInterval: 15|  
| serviceRegistry.enabled| Service registry that is used to discover services that are deployed by Application Deployable among managed clusters.| false | 
| serviceRegistry.dnsSuffix| The suffix of the registry DNS name, which is added to the end of the target clusters dns domain name.|mcm.svc| 
| serviceRegistry.plugins| Comma-separated list of enabled plugins. Supported plugins: `kube-service`, `kube-ingress`, and `istio`. |kube-service|
| version| Version of `multicluster-endpoint` |1.0.0|
{: caption="Table 1. Table of YAML file parameters and descriptions for import" caption-side="}

## Deleting an imported cluster
{: #delete}

Complete the following procedure to remove an imported cluster and the `multicluster-endpoint` that was created on the managed cluster.

1. From the _Clusters_ page, find your imported cluster in the table.
   
2. Click **Options** > **Delete cluster**.
