---

copyright:
  years: 2020
lastupdated: "2020-03-26"

---

# Creating an OpenShift cluster on Google Cloud Platform

Follow the procedure to create a Red Hat OpenShift Container Platform cluster on Google Cloud Platform (GCP). For more information about Google Cloud Platform, see [Google Cloud Platform](https://cloud.google.com/docs/overview).
{:shortdesc}

  - [Prerequisites](#prereq)
  - [Creating your cluster with the console](#create_gui)
  - [Accessing your cluster](#access)
  - [Deleting your cluster](#delete)

## Prerequisites
{: #prereq}

You must have the following prerequisites before creating a cluster on GCP:

* A deployed Red Hat Advanced Cluster Management for Kubernetes hub cluster

* Internet access for your Red Hat Advanced Cluster Management for Kubernetes hub cluster so it can create the Kubernetes cluster on GCP

* GCP cloud connection. See [Setting up a cloud connection for Google Cloud Platform](cloud_conn_gke.md) for more information.

* A configured domain in GCP. See [Setting up a custom domain](https://cloud.google.com/endpoints/docs/openapi/dev-portal-setup-custom-domain) for instructions on how to configure a domain. 

* GCP login credentials, which include user name and password.

* A Red Hat OpenShift image pull secret. See [Using image pull secrets](https://docs.openshift.com/container-platform/4.3/openshift_images/managing_images/using-image-pull-secrets.html).

## Creating your cluster with the Red Hat Advanced Cluster Management for Kubernetes console
{: #create_gui}

To create clusters from the Red Hat Advanced Cluster Management for Kubernetes console, complete the following steps: 

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. On the _Clusters_ page, Click **Add Cluster**.

3. Select **Create a cluster**. 
   
  **Note:** This procedure is for creating a cluster. If you have an existing cluster that you want to import, see [Importing a target managed cluster to the hub cluster](import.md) for those steps.
  
4. Enter a name for your cluster. This name is used in the hostname of the cluster.

  **Tip:** You can view the `yaml` content updates as you enter the information in the console by setting the *YAML* switch to **ON**. 

5. Enter the base domain information that you configured for your Azure account. See [Setting up a custom domain](https://cloud.google.com/endpoints/docs/openapi/dev-portal-setup-custom-domain) for more information. This name is used in the hostname of the cluster.

6. Select **Google Cloud** for the infrastructure platform. See [Supported managed cloud providers](cloud_providers.md) to learn more about other available cloud providers.

7. Select your cloud connection from the available connections on the list. If you do not have one configured, or want to configure a new one, see [Creating a cloud connection on Google Cloud Platform](conn_cloud_gke.md).
   
8. Configure the *Node pools* for your cluster. 

  The node pools define the location and size of the nodes that are used for your cluster. 

  The *Region* specifies where the nodes are located geographically. A closer region might provide faster performance, but a more distant region might be more distributed. 

  * Master pool: There are three Master nodes that are created for your cluster in the master pool. The master nodes share the management of the cluster activity. You can select multiple zones within the region for a more distributed group of master nodes. You can change the type and size of your instance after it is created, but you can also specify it in this section. The default values are *n1-standard-1  - n1-standard-1 1 vCPU - General Purpose* with 500 GiB of root storage. 

  * Worker pools: You can create one or more worker nodes in a worker pool to run the container workloads for the cluster. They can be in a single worker pool, or distributed across multiple worker pools.  

9. **Optional:** Configure the cluster networking options.

10. **Optional:** Configure a label for the cluster.

11. Click **Create**. When you create the cluster, it is automatically managed by Red Hat Advanced Cluster Management for Kubernetes. You can view your cluster details after the create and import process is complete.

## Accessing your cluster 
{: #access}

To access a cluster that is managed by Red Hat Advanced Cluster Management for Kubernetes, complete the following steps:

1. From the Red Hat Advanced Cluster Management for Kubernetes navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. Select the name of the cluster that you created or want to access. The cluster details are displayed.

3. Select **Reveal credentials** to view the user name and password for the cluster. Note these values to use when you log in to the cluster. 

4. Select **Console URL** to link to the cluster.

5. Log in to the cluster by using the user ID and password that you found in step 3. 

6. Select the *Options* menu for the cluster that you want to access.

7. Select **Launch to cluster**. 

  **Tip:** If you already know the log in credentials, you can access the cluster by selecting the *Options* menu for the cluster, and selecting **Launch to cluster**.

## Removing a cluster from management
{: #delete}

When you remove a Red Hat OpenShift Cloud Platform cluster from management that was created with Red Hat Advanced Cluster Management for Kubernetes, you can either *detach* it or *destroy* it.  

Detaching a cluster removes it from management, but does not completely delete it. You can import it again, if you decide that you want to bring it back under management. This is only an option when the cluster is in a *Ready* state, and when the cluster was created by the Red Hat Advanced Cluster Management for Kubernetes. You cannot detach a cluster that was imported.

Destroying a cluster removes it from management and deletes the components of the cluster. This is permanent, and it cannot be brought back under management after deletion.   

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. Select the option menu beside the cluster that you want to delete.

3. Select **Destroy cluster** or **Detach cluster**. 

  **Tip:** You can detach or destroy multiple clusters by selecting the check boxes of the clusters that you want to detach or destroy. Then select **Detach** or **Destroy**.
