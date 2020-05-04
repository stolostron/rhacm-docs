# Uninstalling

When you uninstall Red Hat Advanced Cluster Management for Kubernetes, there are two different levels of the process. 

The first level is a custom resource removal. It is the most basic type of unistallation that removes the custom resource of the MultiClusterHub instance, but leaves other required components. This level of uninstallation is helpful if you plan another installation that uses the same settings and components of the one that you are removing. Your time to install the next version is reduced when you have all of the other components already installed. 

The second level is a complete uninstallation. This adds the removal of other required components and settings to the items that are removed. When you continue with this step, it removes all of the components and subscriptions that were not removed with the custom resource removal.

## Removing a MultiClusterHub instance by using commands  

1. Enter the following command to remove the MultiClusterHub custom resource:

```
oc delete multiclusterhub
```

  **Tip:** If you plan to reinstall a new version and want to keep your other information, you can skip the rest of the steps in this procedure and reinstall.  

2. Enter the following command to remove all of the related components and subscriptions:

```
oc delete multiclusterhub --all
```

3. Enter the following command to remove all sub-resources:

```
oc delete multiclusterhub --sub --all
```

## Deleting both components by using the console

When you use the Red Hat OpenShift Container Platform console to uninstall, you remove the operator. Complete the following steps to unistall by using the console:

1. In the Red Hat OpenShift Container Platform console navigation, select **Operators** > **Installed Operators**.

2. Select the *Options* menu for the MultiClusterHub operator. 

3. Select **Delete MultiClusterHub**.

  **Tip:** If you plan to reinstall a new version and want to keep your other information, you can skip the rest of the steps in this procedure and reinstall.  

4. Navigate to **Installed Operators**. 

5. Remove the other operators and sub-operators that are required for Red Hat Advanced Cluster Mangement for Kubernetes by selecting the *Options* menu and selecting **Delete**.

