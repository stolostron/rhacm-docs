# Creating an OpenShift cluster on bare metal

You can use the Red Hat Advanced Cluster Management for Kubernetes console to create a Red Hat OpenShift Container Platform cluster in a bare metal environment. 

  - [Prerequisites](#prerequisites)
  - [Creating your cluster with the Red Hat Advanced Cluster Management for Kubernetes console](#creating-your-cluster-with-the-red-hat-advanced-cluster-management-for-kubernetes-console)
  - [Accessing your cluster](#accessing-your-cluster)
  - [Removing a cluster from management](#removing-a-cluster-from-management)
 
## Prerequisites

You need the following prerequisites before creating a cluster in a bare metal environment:

* A deployed Red Hat Advanced Cluster Management for Kubernetes hub cluster

* Internet access for your Red Hat Advanced Cluster Management for Kubernetes hub cluster so it can create the Kubernetes cluster in the bare metal environment

* Bare metal provider connection; see [Creating a provider connection for a bare metal environment](prov_conn_bare.md) for more information

* Login credentials for your bare metal environment, which include user name, password, and Baseboard Management Controller Address

* A Red Hat OpenShift image pull secret; see [Using image pull secrets](https://docs.openshift.com/container-platform/4.3/openshift_images/managing_images/using-image-pull-secrets.html)

## Creating your cluster with the Red Hat Advanced Cluster Management for Kubernetes console

To create clusters from the Red Hat Advanced Cluster Management for Kubernetes console, complete the following steps: 

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. On the Clusters page, Click **Add Cluster**.

3. Select **Create a cluster**. 
   
  **Note:** This procedure is for creating a cluster. If you have an existing cluster that you want to import, see [Importing a target managed cluster to the hub cluster](import.md) for those steps.
  
4. Enter a name for your cluster. This name is used in the hostname of the cluster.

  **Tip:** You can view the `yaml` content updates as you enter the information in the console by setting the *YAML* switch to **ON**. 

5. Enter the base domain information that you configured in your bare metal environment. This name is used in the hostname of the cluster.

6. Select **Bare Metal** for the infrastructure platform.

7. Specify a **Release image** that you want to use for the cluster. This identifies the version of the Red Hat OpenShift Container Platform image that is used to create the cluster. If the version that you want to use is available, you can select the image from the list of images. If the image that you want to use is not a standard image, you can enter the path to the image that you want to use.

8. Select your provider connection from the available connections on the list. If you do not have one configured, or want to configure a new one, see [Creating a provider connection for a bare metal environment](prov_conn_bare.md).
   
9. Select your hosts from the list of hosts that are associated with your provider connection. Select a minimum of three assets that are on the same bridge networks as the hypervisor. 

10. **Optional:** Configure the cluster networking options.

11. **Optional:** Configure a label for the cluster.

12. **Optional:** Update the advanced settings, if you want to change the setting for including a configmap. 

13. Click **Create**. When you create the cluster, it is automatically managed by Red Hat Advanced Cluster Management for Kubernetes. You can view your cluster details after the create and import process is complete.

## Accessing your cluster 

To access a cluster that is managed by Red Hat Advanced Cluster Management for Kubernetes, complete the following steps:

1. From the Red Hat Advanced Cluster Management for Kubernetes navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. Select the name of the cluster that you created or want to access. The cluster details are displayed.

3. Select **Reveal credentials** to view the user name and password for the cluster. Note these values to use when you log in to the cluster. 

4. Select **Console URL** to link to the cluster.

5. Log in to the cluster by using the user ID and password that you found in step 3. 

6. Select the *Actions* menu for the cluster that you want to access.

7. Select **Launch to cluster**. 

  **Tip:** If you already know the log in credentials, you can access the cluster by selecting the *Actions* menu for the cluster, and selecting **Launch to cluster**.

## Removing a cluster from management

When you remove a Red Hat OpenShift Container Platform cluster from management that was created with Red Hat Advanced Cluster Management for Kubernetes, you can either *detach* it or *destroy* it.  

Detaching a cluster removes it from management, but does not completely delete it. You can import it again, if you decide that you want to bring it back under management. This is only an option when the cluster is in a *Ready* state, and when the cluster was created by the Red Hat Advanced Cluster Management for Kubernetes. You cannot detach a cluster that was imported.

Destroying a cluster removes it from management and deletes the components of the cluster. This is permanent, and it cannot be brought back under management after deletion.   

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**.

2. Select the option menu beside the cluster that you want to delete.

3. Select **Destroy cluster** or **Detach cluster**. 

  **Tip:** You can detach or destroy multiple clusters by selecting the check boxes of the clusters that you want to detach or destroy. Then select **Detach** or **Destroy**.
