# Synchronizing available release images

The release images are updated frequently, so you might want to synchronize the list of release images to ensure that you can select the latest available versions. The release images are available in the [acm-hive-openshift-releases](https://github.com/open-cluster-management/acm-hive-openshift-releases) GitHub repository. Complete the following steps to refresh the list:

1. Connect to your Red Hat Advanced Cluster Management for Kubernetes hub cluster. 

2. To synchronize your list of stable release images, enter the following command:

  ```
  oc apply -k subscription/
  ```
    
  After running this command, the list of available stable release images updates with the currently available images in about 1 minute.
  
3. By default, only the stable images are listed. To synchronize and display the fast release images, enter the following command:

  ```
  oc apply -f subscription/subscription-fast.yaml
  ```
  
  After running this command, the list of available fast release images updates with the currently available images in about 1 minute.
  
4. View the list of currently available release images in the Red Hat Advanced Cluster Management console when you are creating a cluster.
