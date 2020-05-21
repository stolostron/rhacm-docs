# Creating and modifying bare metal assets

Bare metal assets are virtual or physical servers that are configured to run your cloud operations. Red Hat Advanced Cluster Management for Kubernetes connects to a bare metal asset that your administrator creates, and can create clusters on it.

You must create a bare metal asset in Red Hat Advanced Cluster Management for Kubernetes to create a cluster on it. Use the following procedure to create a bare metal asset that can host a cluster that is managed by Red Hat Advanced Cluster Management for Kubernetes.

## Prerequisites {#bma-prerequisites}

You need the following prerequisites before creating a bare metal asset:

* A deployed Red Hat Advanced Cluster Management for Kubernetes hub cluster

* Access for your Red Hat Advanced Cluster Management for Kubernetes hub cluster to connect to the bare metal asset.

* A configured bare metal asset, and log in credentials with the required permissions to log in and manage it.
  **Note:** Login credentials for your bare metal asset include the following items for the asset that are provided by your administrator:

   * user name
   * password
   * Baseboard Management Controller Address
   * boot NIC MAC address

## Creating a bare metal asset with the console {#creating-a-bare-metal-asset-with-the-console}

To create a bare metal asset using the Red Hat Advanced Cluster Management for Kubernetes console, complete the following steps: 

1. From the navigation menu, navigate to **Automate infrastructure** > **Bare metal assets**.

2. On the *Bare metal assets* page, Click **Create bare metal asset**.

3. Enter a name for your asset that identifies it when you create a cluster. 

  **Tip:** You can view the `yaml` content updates as you enter the information in the console by setting the *YAML* switch to **ON**. 

4. Enter the namespace where you want to create the bare metal asset. Users who have access to this namespace can associate this asset to the cluster when creating a cluster.

5. Enter the Baseboard Management Conroller address. This is the controller that enables communication with the host. The following protocols are supported: 
   * IPMI, see [IPMI 2.0 Specification](https://www.intel.com/content/www/us/en/products/docs/servers/ipmi/ipmi-second-gen-interface-spec-v2-rev1-1.html) for more information.
   * iDRAC, see [Support for Integrated Dell Remote Access Controller 9 (iDRAC9)](https://www.dell.com/support/article/en-us/sln311300/support-for-integrated-dell-remote-access-controller-9-idrac9?lang=en) for more information.
   * iRMC, see [Data Sheet: FUJITSU Software ServerView Suite integrated Remote Management Controller - iRMC S5](https://sp.ts.fujitsu.com/dmsp/Publications/public/ds-irmc-s5-en.pdf) for more information.
   * Redfish, see [Redfish specification](https://www.dmtf.org/sites/default/files/standards/documents/DSP0266_1.8.0.pdf) for more information.

6. Enter the user name and password for the bare metal asset.

7. Add the boot NIC MAC address for the bare metal asset. This is the MAC address of the host's network-connected NIC that is used to provision the host on the bare metal asset. 

You can continue with [Creating a provider connection for bare metal](prov_conn_bare.md) and then [Creating a cluster on bare metal](create_bare.md).

## Modifying a bare metal asset {#modifying-a-bare-metal-asset}

If you need to modify the settings for a bare metal asset, complete the following steps:

1. In the Red Hat Advanced Cluster Management for Kubernetes console navigation, select: **Automate infrastructure** > **Bare metal assets**.

2. Select the options menu for the asset that you want to modify in the table.

3. Select **Modify**.

## Removing a bare metal asset {#removing-a-bare-metal-asset}

When a bare metal asset is no longer used for any of the clusters, you can remove it from the list of available bare metal assets. Removing unused assets both simplifies your list of available assets, and prevents the accidental selection of that asset.

To remove a bare metal asset, complete the following steps:

1. In the Red Hat Advanced Cluster Management for Kubernetes console navigation, select: **Automate infrastructure** > **Bare metal assets**.

2. Select the options menu for the asset that you want to remove in the table.

3. Select **Delete**.


