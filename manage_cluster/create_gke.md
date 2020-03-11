---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Creating a Google Kubernetes Engine cluster

Follow the procedure to create a Google Kubernetes Engine (Kubernetes Engine) cluster. For more information about Kubernetes Engine, see [Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine/){:new_window}.
{:shortdesc}

## Supported architectures

The following hardware architectures are supported:

* Linux 
* Linux on Power (ppc64le)
* Linux on IBM Z and LinuxONE

**Required user type or access level**: Cluster administrator

  - [Prerequisites](#prereq)
  - [Creating your cluster with kubectl](#create_cli)
  - [Accessing your cluster](#access)
  - [Deleting your cluster](#delete)
  - [Updating your `kubeconfig` file](#update)

## Prerequisites
{: #prereq}

* You must have an Red Hat Advanced Cluster Management for Kubernetes hub deployed. 

* You need internet access so that your Red Hat Advanced Cluster Management for Kubernetes cluster can create a remote Kubernetes cluster by using Google Kubernetes Engine.

* You need Google Cloud Platform login credentials and access to create a Google Kubernetes Engine cluster.

* To create clusters across cloud providers with OpenShift Container Platform, run the following command to enable the namespace to pull the image from the private registry:

  ```
  oc policy add-role-to-user system:image-puller system:serviceaccount:<namespace>:default --namespace=ibmcom
  ```
  {:codeblock}

<!-- ## Creating your cluster with the Red Hat Advanced Cluster Management for Kubernetes console
{: #create_gui}

You can create clusters from the Red Hat Advanced Cluster Management for Kubernetes console for each of the available cloud providers.

1. From the navigation menu, click **Clusters**.
2. Click **Add Cluster**.
3. Choose from one of the options.

   You can choose to create a cluster as a managed service from a cloud provider, or you can create a cluster from infrastructure, which is a Cloud Automation Manager feature.

   **Note:** If you already have an cluster that you want to import into a managed cluster, click the import option.

4. To create as a managed cluster, choose a cloud provider. See (new topic link here) to learn more about available cloud providers.
5. Enter a _Connection name_ and a _Connection description_.
6. Choose a _Namespace_. The namespaces that are listed are already connected to a cloud provider.

  **Note** If you do not have a namespace that is connected to a cloud provider, you can  Add click **Add connection** from the _Cloud connection_ field.

7. Configure your cloud connection. (what is service account)

8. Save your cloud configuration if you want to return to that configuration later.

9. Click **Add** and continue to configure your cluster.

10. Enter details about your cluster in the _Configure your cluster_ details.

11. Choose a default size or customize in the YAML file. (new topic link here)

12. **Optional**: Configure advanced parameters. You can assign labels to later identify clusters.

  You must add a label even if the label belongs to another cluster. Labels are not assigned automatically across clusters.

13. Click **Create**. When you create a cluster, you also import a cluster. You can view your cluster details after the create and import process is complete. -->

## Create your cluster with kubectl
{: #create_cli}

Complete the following procedure to create a cluster with kubectl:

1. Create and save the following `.yaml` files that you need to complete the procedure:

  * Create and name your `apikey.yaml` file.
  * Create and name your `cluster.yaml` file.

2. Create a service account to obtain Google identity credentials. See _Creating a service account_ in the [Google Developers Console](https://developers.google.com/identity/protocols/OAuth2ServiceAccount#creatinganaccount){:new_window}.

3. Download the corresponding JSON key file. Encode key with base64 and add it to the `apikey.yaml` privateKey field. Run the following command:

  ```
  cat key.json | base64 | tr -d '\n'
  ```
  {:codeblock}

  <!-- 3 needs to be fixed and formatted like the others -->

4. In the `apikey.yaml` file, enter the GKE API key information to ensure that you have permission to create a cluster with the API key. In the following example, `name` is your GKE ID and `privateKey` is your GKE key:

  ```
  apiVersion: v1
  kind: Secret
  metadata:
    name: <cloud-access-secret-name>
    labels:
      cloud-provider: gke
      purpose: cloud-connection
  type: Opaque
  data:
    privateKey: <base64-encoded-private-key> # cat key.json | base64 | tr -d '\n'
   ```
   {:codeblock}

5. Run the following command to apply the configuration:

  ```
  kubectl apply -f <directory>/apikey.yaml -n <namespace>
  ```
  {:codeblock}

6. Edit the cluster object that is defined in the `cluster.yaml` with your cluster configuration. Ensure that the object name is the same as the secret name. See [_Table 1. YAML file parameters and description_](#table_1) for details about each parameter. See the following sample file:
  
  ```
  apiVersion: "cluster.k8s.io/v1alpha1"
  kind: Cluster
  metadata:
    name: <cluster-name>
    labels:
      cloud-provider: gke
  spec:
    clusterNetwork:
      services:
        cidrBlocks: ["172.32.0.0/16"]
      pods:
        cidrBlocks: ["192.168.0.0/16"]
      serviceDomain: "cluster.local"
    providerSpec:
      value:
        apiVersion: "gke/v1alpha1"
        kind: "GKEClusterProviderSpec"
        spec:
          secretName: <cloud-access-secret-name>
          projectID: <your-project-ID>
          zone: "us-central1-a"
          clusterVersion: "1.12.8-gke.10"
          numNodes: 3
          machineType: "n1-standard-1"
          diskSize: "100G"
          diskType: "pd-standard"
  ```
  {: codeblock}

7. Run the following command to apply the cluster object:

  ```
  kubectl apply -f <directory>/cluster.yaml -n <namespace>
  ```
  {: codeblock}

8. Depending on your specifications, it can take up to 30 minutes to create a cluster. Run the following command to see the status:

  ```
  kubectl describe cluster.cluster.k8s.io/<cluster-name> -n <namespace>
  ```
  {: codeblock}

  You see `CreateClusterSuccessful` in the `Event` list when the cluster is created.

### YAML Parameters and descriptions
{: #table_1}

Table 1: The following table lists the parameters and descriptions that are available in the YAML file:

|Parameter|Description|Default value|
|---|---|---|
|apiVersion|Red Hat Advanced Cluster Management for Kubernetes api; do not edit|cluster.k8s.io/v1alpha1|
|kind|Resource type; do not edit|Cluster|
|name|Required; your cluster name|gke-cluster|
|labels:cloud-provider|Required; name of your cloud provider; do not edit|gke|
|spec:clusterNetwork|Cluster network information||
|services:cidrBlocks|Required; just a placeholder; do not edit|["172.32.0.0/16"]|
|pods:cidrBlocks|Required; just a placeholder; do not edit|["192.168.0.0/16"]|
|servicesDomian|Required; just a placeholder; do not edit|cluster.local|
|providerSpec:value|Cloud provider specific information||
|value:apiVersion|Version of cloud provider api|gke/v1alpha1|
|value:kind|Cloud provider specific resource type|GKEClusterProviderSpec|
|spec:zone|Required; Compute zone (example: `us-central1-a`) for the cluster; Use `gcloud compute zones list` to list all Google Compute Engine zones in a project|none|
|spec:clusterVersion|The Kubernetes version to use for the master and nodes; `gcloud container get-server-config` displays all Kubernetes versions|The default Kubernetes version is available using the command: `gcloud container get-server-config`|
|numNodes|Optional; number of nodes to be created in each of the cluster zones|3|
|spec:machineType|The type of machine to use for nodes. Defaults to n1-standard-1. Use `gcloud compute machine-types list` displays all machine types|n1-standard-1|
|spec:diskSize|Optional; size for node VM boot disks|100GB|
|spec:diskType|Optional; type of the node VM boot disk; diskType must be pd-standard or pd-ssd|pd-standard|
|spec:projectID|Required to interact with GCP resources, you must provide project ID for every request|none|
|spec:secretName|Required; the same as the name value in apikey.yaml|none|
{: caption="Table 1. YAML file parameters and descriptions" caption-side="top"}

## Accessing your cluster
{: #access}

After you installed your cluster, you can access your cluster by using the `kubeconfig` file or cluster portal.

1. Run the following command to get the secret:

  ```
  kubectl get secret -n <namespace>
  ```
  {: codeblock}

  See the following example output:

  ```
  NAME                      TYPE                                  DATA   AGE
  <cluster-name>-<cluster-id>  Opaque                                3      4m41s
  ```
  {: pre}

2. Generate the kubeconfig to access the cluster that you created. Run the following command:

  ```
  kubectl get secrets/<cluster-name>-<cluster-id> -o 'go-template={{index .data "kubeconfig"}}' | base64 --decode > <directory>/kubeconfig
  ```
  {: codeblock}

3. Run the following command to access your cluster by endpoint:

  ```
  kubectl describe cluster.cluster.k8s.io/<cluster-name> -n <namespace>
  ```
  {: codeblock}

  URL example: `https://<Cluster Master Host>:<Cluster Master API Port>`

4. Set the `KUBECONFIG` environment variable with the following command:

  ```
  export KUBECONFIG=<directory>/kubeconfig
  ```
  {: codeblock}

## Deleting your cluster
{: #delete}

1. Run the following command to get your cluster:

  ```
  kubectl get cluster.cluster.k8s.io/<cluster-name>
  ```
  {: codeblock}

2. Run the following command to delete the cluster:

  ```
  kubectl delete cluster.cluster.k8s.io/<cluster-name>
  ```
  {: codeblock}

  For more information about the delete command options, run `kubectl delete --help`.

View your cluster in the Red Hat Advanced Cluster Management for Kubernetes console. To scale your cluster, see [Scaling your cluster](scale_mcm.md).

## Updating your `kubeconfig` file
{: #update}

When the `access-token` in `kubeconfig` expires, you need to manually update the `kubeconfig` file so that you can access the cluster.

1. [Install Google Cloud SDK](https://cloud.google.com/sdk/install){: new_window}.

2. Authorize Google Cloud SDK tools. Choose one of the following authorization types:

  * User account type

    ```
    gcloud auth login
    ```
    {: codeblock}

  * [Service account](https://developers.google.com/identity/protocols/OAuth2ServiceAccount#creatinganaccount){: new_window}.

    ```
    gcloud auth activate-service-account --key-file [KEY_FILE]
    ```
    {: codeblock}

3. Configure Google Cloud SDK tools with the following command:

  ```
  gcloud config set project [PROJECT_ID]
  gcloud config set compute/zone [COMPUTE_ZONE]
  ```
  {: codeblock}

4. Generate a `kubeconfig` file by running the following command:

  ```
  gcloud container clusters get-credentials [CLUSTER_NAME]
  ```
  {: codeblock}

5. Access your cluster to fetch `access-token` with the following command:

  ```
  kubectl --kubeconfig ~/.kube/config cluster-info
  ```
  {: codeblock}

6. Access your `kubeconfig` with the following command:

  ```
  cp ~/.kube/config ./kubeconfig
  kubectl --kubeconfig ./kubeconfig cluster-info
  ```
  {: codeblock}
