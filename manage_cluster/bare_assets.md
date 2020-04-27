# Creating and modifying bare metal assets

Bare metal assets are virtual or physical servers that are configured to run your cloud operations. Red Hat Advanced Cluster Management for Kubernetes connects to a bare metal asset that your administrator creates, and can create clusters on it.

You must create a bare metal asset in Red Hat Advanced Cluster Management for Kubernetes to create a cluster on it. Use the following procedure to create a bare metal asset that can host a cluster that is managed by Red Hat Advanced Cluster Management for Kubernetes.

- [Prerequisites](#prerequisites)
- [Creating your bare metal asset with the Red Hat Advanced Cluster Management for Kubernetes console](#creating-your-bare-metal-asset-with-the-red-hat-advanced-cluster-management-for-kubernetes-console)
- [Removing a bare metal asset](#removing-a-bare-metal-asset)
 
## Prerequisites

You need the following prerequisites before creating a bare metal asset:

* A deployed Red Hat Advanced Cluster Management for Kubernetes hub cluster

* Access for your Red Hat Advanced Cluster Management for Kubernetes hub cluster to connect to the bare metal asset.

* A configured bare metal asset, and log in credentials with the required permissions to log in and manage it.
  **Note:** Login credentials for your bare metal asset include the following items for the asset that are provided by your administrator:
    * user name
    * password
    * Baseboard Management Controller Address
    * boot NIC MAC address

## Creating your bare metal asset with the Red Hat Advanced Cluster Management for Kubernetes console

To create a bare metal asset using the Red Hat Advanced Cluster Management for Kubernetes console, complete the following steps: 

1. From the navigation menu, navigate to **Automate infrastructure** > **Bare metal assets**.

2. On the *Bare metal assets* page, Click **Create bare metal asset**.

3. Enter a name for your asset that identifies it when you create a cluster. 

  **Tip:** You can view the `yaml` content updates as you enter the information in the console by setting the *YAML* switch to **ON**. 

4. Enter the namespace for your bare metal asset. This namespace must be the same as the namespace where you create your cluster that uses this asset.

5. Enter the Baseboard Management Conroller address. This is the controller that enables communication with the host. The following protocols are supported: 
  * IPMI
  * iDRAC
  * iRMC
  * Redfish

6. Enter the user name and password for the bare metal asset.

7. Add the boot NIC MAC address for the bare metal asset. This is the MAC address of the host's network-connected NIC that is used to provision the host on the bare metal asset. 

You can continue with [Creating a provider connection for a bare metal environment](cloud_conn_bare.md) and then [Creating an OpenShift cluster on bare metal](create_bare.md).

## Modifying a bare metal asset

If you need to modify the settings for a bare metal asset, complete the following steps:

1. In the Red Hat Advanced Cluster Management for Kubernetes console navigation, select: **Automate infrastructure** > **Bare metal assets**.

2. Select the options menu for the asset that you want to modify in the table.

3. Select **Modify**.

## Removing a bare metal asset

When a bare metal asset is no longer used for any of the clusters, you can remove it from the list of available bare metal assets. Removing unused assets both simplifies your list of available assets, and prevents the accidental selection of that asset.

To remove a bare metal asset, complete the following steps:

1. In the Red Hat Advanced Cluster Management for Kubernetes console navigation, select: **Automate infrastructure** > **Bare metal assets**.

2. Select the options menu for the asset that you want to remove in the table.

3. Select **Delete**.


