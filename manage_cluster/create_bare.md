---

copyright:
  years: 2019, 2020
lastupdated: "2020-04-01"

---

# Creating an OpenShift cluster on bare metal

You can use the Red Hat Advanced Cluster Management for Kubernetes console to create a Red Hat OpenShift Container Platform cluster in a bare metal environment. 
{:shortdesc}

  - [Prerequisites](#prereq)
  - [Creating your cluster with the Red Hat Advanced Cluster Management for Kubernetes console](#create_gui)
  - [Accessing your cluster](#access)
  - [Deleting your cluster](#delete)
 
## Prerequisites
{: #prereq}

You must have the following prerequisites before creating a cluster in a bare metal environment:

* A deployed Red Hat Advanced Cluster Management for Kubernetes hub cluster

* Internet access for your Red Hat Advanced Cluster Management for Kubernetes hub cluster so it can create the Kubernetes cluster in the bare metal environment

* Bare metal cloud connection. See [Creating a cloud connection for a bare metal environment](cloud_conn_bare.md) for more information.

* Login credentials for your bare metal environment, which include user name, password, and Baseboard Management Controller Address.

* A Red Hat OpenShift image pull secret. See [Using image pull secrets](https://docs.openshift.com/container-platform/4.3/openshift_images/managing_images/using-image-pull-secrets.html).

## Creating your cluster with the Red Hat Advanced Cluster Management for Kubernetes console
{: #create_gui}

To create clusters from the Red Hat Advanced Cluster Management for Kubernetes console, complete the following steps: 

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. On the Clusters page, Click **Add Cluster**.

3. Select **Create a cluster**. 
   
  **Note:** This procedure is for creating a cluster. If you have an existing cluster that you want to import, see [Importing a target managed cluster to the hub cluster](import.md) for those steps.
  
4. Enter a name for your cluster. This name is used in the hostname of the cluster.

  **Tip:** You can view the `yaml` content updates as you enter the information in the console by setting the *YAML* switch to **ON**. 

5. Enter the base domain information that you configured in your bare metal environment. This name is used in the hostname of the cluster.

6. Select **Bare Metal** for the infrastructure platform. See [Supported managed cloud providers](cloud_providers.md) to learn more about other available cloud providers.

7. Select your cloud connection from the available connections on the list. If you do not have one configured, or want to configure a new one, see [Creating a cloud connection for a bare metal environment](cloud_conn_bare.md).
   
8. Select your hosts from the list of hosts that are associated with your Cloud connection. Select a minimum of three assets that are on the same bridge networks as the hypervisor. 

9. **Optional:** Configure the cluster networking options.

10. **Optional:** Configure a label for the cluster.

11. **Optional:** Update the advanced settings, if you want to change the setting for including a configmap. 

11. Click **Create**. When you create the cluster, it is automatically managed by Red Hat Advanced Cluster Management for Kubernetes. You can view your cluster details after the create and import process is complete.

## Accessing your cluster 
{: #access}

To access a cluster that is managed by Red Hat Advanced Cluster Management for Kubernetes, complete the following steps:

1. From the Red Hat Advanced Cluster Management for Kubernetes navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. Select the *Options* menu for the cluster that you want to access.

3. Select **Launch to cluster**. 

  **Tip:** You can also access the cluster by selecting the name of the cluster on the *Clusters* page to access its details. The cluster URL is provided in the details. 

## Removing a cluster from management
{: #delete}

When you remove a Red Hat OpenShift Cloud Platform cluster from management that was created with Red Hat Advanced Cluster Management for Kubernetes, you can either *detach* it or *destroy* it.  

Detaching a cluster removes it from management, but does not completely delete it. You can import it again, if you decide that you want to bring it back under management. This is only an option when the cluster is in a *Ready* state, and when the cluster was created by the Red Hat Advanced Cluster Management for Kubernetes. You cannot detach a cluster that was imported.

Destroying a cluster removes it from management and deletes the components of the cluster. This is permanent, and it cannot be brought back under management after deletion.   

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. Select the option menu beside the cluster that you want to delete.

3. Select **Destroy cluster** or **Detach cluster**. 

  **Tip:** You can detach or destroy multiple clusters by selecting the check boxes of the clusters that you want to detach or destroy. Then select **Detach** or **Destroy**.
