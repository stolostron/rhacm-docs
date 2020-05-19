# Upgrading your cluster

After you create clusters that you want to manage with Red Hat Advanced Cluster Management for Kubernetes, you can use the Red Hat Advanced Cluster Management for Kubernetes console to upgrade those clusters to the latest minor version that is available in the version channel that the managed cluster uses.

**Remember:** To upgrade to a major version, you must verify that you meet all of the prerequisites for upgrading to that version. You must update the version channel on the managed cluster before you can upgrade the cluster with the console. After you update the version channel on the managed cluster, the Red Hat Advanced Cluster Management for Kubernetes console displays the latest versions that are available for the upgrade.

**Note:** You cannot upgrade Red Hat OpenShift Kubernetes Service clusters with the Red Hat Advanced Cluster Management for Kubernetes console. 

This method of upgrading only works for Red Hat OpenShift Container Platform clusters that are in a *Ready* state. 

To upgrade your cluster, complete the following steps:

1. From the navigation menu, navigate to **Automate infrastructure** > **Clusters**. If an upgrade is available, it is shown in the *Distribution version* column.

2. Select the clusters that you want to upgrade. **Remember:** A cluster must be in *Ready* state, and must be a Red Hat OpenShift Container Platform cluster to be upgraded with the console.

3. Select **Upgrade**.

4. Select the new version of each cluster.

5. Select **Upgrade**.
