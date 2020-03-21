---

copyright:
  years: 2020
lastupdated: "2020-03-16"

---

# Importing a cluster with the CLI

After you install Red Hat Advanced Cluster Management for Kubernetes, you are ready to import a cluster to manage. 
{:shortdesc}
<!--Links need to be revisited here-->
  - [Prerequisites](#prereq)
  - [Preparing for import](#prep)
  - [Importing a cluster](#import)
  - [Deleting an imported cluster](#delete)
  
  **Note:** A hub cluster cannot manage another hub cluster.
    
## Prerequisites
{: #prereq}

* You must have an Red Hat Advanced Cluster Management for Kubernetes hub that is deployed and cluster that you want to manage.

* You need to install the Kubernetes CLI, `kubectl`. To install `kubectl`, see [Installing the Kubernetes CLI (kubectl)](../../kubectl/install_kubectl.md).

* You must install the Red Hat Advanced Cluster Management for Kubernetes CLI, `cloudctl`. For more information, see [Installing the Red Hat Advanced Cluster Management for Kubernetes CLI](../../cloudctl/install_cli.md) to install the CLI.

  **Note:** Download the installation file for CLI tools from the console.
  
## Supported architecture

* Linux
* Linux on Power (ppc64le)
* Linux on LinuxONE

## Prepare for import 
{: #prep}

To learn more about the `import` command and see [options] that are available, see [Red Hat Advanced Cluster Management for Kubernetes CLI multicluster commands (mc)](../../cli/cli_mc_commands.md).

**Note:** By default, the `multicluster-endpoint` deployment pulls all of the required images from Docker Hub. You only need to install images from DockerHub if you are working in an air gapped environment.

1. Log in to your _hub_-cluster with `cloudctl login`. Run the following command:
   
  ```
  cloudctl login -a https://<Hub Cluster Master Host>:<Cluster Master API Port> --skip-ssl-validation
  ```
  {: codeblock}
  
2. Run the following command to create the configuration template, `cluster-import-config.yaml`, where `<name>` is the name of the cluster resource on the hub, and `<namespace>` is the namespace of the cluster resources on the hub:

  ```
  cloudctl mc cluster template {name} [-n|--namespace {namespace}] > cluster-import-config.yaml
  ```
  {: codeblock}

  See [_Table 1. YAML file parameters and description_](#table_1) for details about each parameter in `cluster-import-config.yaml`. 
  
3. Create a cluster resource. When you create the cluster resource, you automatically create a namespace, a service account, a secret, and a cluster registry in the hub cluster. 

  ```
  cloudctl mc cluster create -f cluster-import-config.yaml
  ```
  {: codeblock}
  
  See [kubernetes/cluster-registry](https://github.com/kubernetes/cluster-registry) in the hub cluster. 
  
4. Generate the `cluster-import.yaml`
  
  ```
  cloudctl mc cluster import {name} [-n|--namespace {namespace}] > cluster-import.yaml
  ```
  {: codeblock}
  
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
| policyController| Enable the Governance and risk dashboard policy feature|true| 
| metering| Enable the Governance and risk dashboard policy feature|false| 
| serviceRegistry| Service registry that is used to discover services that are deployed by Application Deployable among managed clusters.| false | 
| dnsSuffix| The suffix of the registry DNS name, which is added to the end of the target clusters dns domain name.|mcm.svc| 
| plugins| Comma-separated list of enabled plugins. Supported plugins: `kube-service`, `kube-ingress`, and `istio`. |kube-service|
| private_registry_enabled| Enable if using a private Docker registry | false|
| docker_username| User name for the private Docker registry | None|
| docker_password| Password for the private Docker registry | none|
| imageNamePostfix| Postfix for the image name | none |
| migrateFrom320|Migration from 3.2.0 multicluster-endpoint|false|
{: caption="Table 1. Table of YAML file parameters and descriptions for import" caption-side="}

**Note:** Do not remove parameters, as the console might not properly render.

## Importing the cluster
{: #import}

1. Configure your `kubectl` for your targeted managed cluster.

  See [Supported cloud providers](cloud_providers.md) to learn how to configure your `kubectl`.

2. Run the following command to import the targeted managed cluster:

  ```
  kubectl apply -f cluster-import.yaml
  ```
  {: codeblock}

  If you receive the following error, run the command again:

  ```
  error: unable to recognize "STDIN": no matches for kind "Endpoint" in version "multicloud.ibm.com/v1beta1"
  ```
  {: pre}
  
4. Verify that the cluster is successfully imported.

  - Log in to your Red Hat Advanced Cluster Management for Kubernetes hub cluster.
  - From the navigation bar, click **Clusters**.
  - Find your new imported managed cluster in the list. 
  - Ensure that the status is _Ready_. Depending on environment, it might take a few minutes to see the status.
  
## Deleting an imported cluster
{: #delete}

You can delete your Red Hat Advanced Cluster Management for Kubernetes managed cluster resources from the hub cluster so that it is not a managed cluster.

1. Log in to your _hub_ cluster with `cloudctl login`.

  ```
  cloudctl login -a https://<Cluster Master Host>:<Cluster Master API Port> --skip-ssl-validation
  ```
  {: codeblock}

2. Run the following command to remove the managed cluster:

  ```
  kubectl delete cluster {name} --namespace {namespace}
  ```
  {: codeblock}
  
  Removing a cluster can take a few minutes.
  
3. Verify that your cluster was removed from the list by running the following command:

  ```
  kubectl get clusters --all-namespaces
  ```
  {: codeblock}
  
