# Synchronizing available release images

The release images are updated frequently, so you might want to synchronize the list of release images to ensure that you can select the latest available versions. The release images are available in the [acm-hive-openshift-releases](https://github.com/open-cluster-management/acm-hive-openshift-releases) GitHub repository. 

There are three levels of stability of the release images:

|Category|Description|
|-- | -- |
| stable | Fully tested images that are confirmed to install and build clusters correctly. Only the last 2 stable versions are synchronized. |
| fast | Partially tested, but likely less stable than a stable version. |
| candidate | Not tested, but the most current image. Might have some bugs. |
{: caption="Table 1. Levels of release images" caption-side="top"}

Complete the following steps to refresh the list:

1. Clone the [acm-hive-openshift-releases](https://github.com/open-cluster-management/acm-hive-openshift-releases) GitHub repository.

2. Connect to your Red Hat Advanced Cluster Management for Kubernetes hub cluster. 

3. To synchronize your list of `stable` release images after you have cloned the `acm-hive-openshift-releases` repository, enter the following command to update the `stable` images: 

   ```
   make subscribe-stable
   ```
   
   **Note:** You can only run this `make` command when you are using the Linux or MacOS operating system. If you are using the Windows operating system, enter the following command:
   
   ```
   oc apply -k subscription/
   ```
  
   After running this command, the list of available `stable` release images updates with the currently available images in about one minute.
  
   * By default, only the `stable` images are listed with the previous commands. To synchronize and display the `fast` release images and the `stable images`, enter the following command:

      ```
      make subscribe-fast
      ```
   
      **Note:** You can only run this `make` command when you are using the Linux or MacOS operating system. If you are using the Windows operating system, enter the following command:

      ```
      oc apply -f subscription/subscription-fast.yaml
      ```
  
      After running the command, the list of available `fast`and `stable`, release images updates with the currently available images in about 1 minute. 
   
   * You can also synchronize the `candidate` release images with the `fast` and `stable` images by entering the following command: 
   
       ```
       make subscribe-candidate
       ```

       **Note:** You can only run this `make` command when you are using the Linux or MacOS operating system. If you are using the Windows operating system, enter the following command:

       ```
       oc apply -f subscription/subscription-candidate.yaml
       ```
  
       After running the command, the list of available `fast` and `stable` release images updates with the currently available images in about 1 minute. 
  

5. View the list of currently available release images in the Red Hat Advanced Cluster Management console when you are creating a cluster.
