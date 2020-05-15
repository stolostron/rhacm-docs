# Maintaining a custom list of release images while disconnected

In some cases, you need to maintain a custom list of release images when the hub cluster has no Internet connection. You can create your own custom list of release images that are available when creating a cluster. Complete the following steps to manage your available release images while disconnected:

1. While you are on a connected system, navigate to the [acm-hive-openshift-releases GitHub repository](https://github.com/open-cluster-management/acm-hive-openshift-releases).

2. Copy the `clusterImageSets` directory to a system that can access the disconnected Red Hat Advanced Cluster Management for Kubernetes hub cluster.

3. Update the `./subscription/channel.yaml` file by changing the `spec: pathname` to access your the directory that you copied, instead of `open-cluster-management`. This step specifies where the hub cluster retrieves the release images. Your updated content should look similar to the following example: 

  ```
  spec:
    type: local
    pathname: c:/<copied_directory>
  ```
  
  Replace <copied_directory> with the path to your forked repository.

4. Add the `yaml` files for the images that you want available when you create a cluster by using the Red Hat Advanced Cluster Management for Kubernetes console to the `./clusterImageSets/stable/*` or `./clusterImageSets/fast/*` directory. **Tip:** You can retrieve the available `yaml` files from the main repository by merging changes into your forked repository.

5. Commit and merge your changes to your forked repository.

6. To synchronize your list of stable release images, enter the following command:

  ```
  oc apply -k subscription/
  ```
  
  After running this command, the list of available stable release images updates with the currently available images in about 1 minute.
  
7. By default, only the stable images are listed. To synchronize and display the fast release images, enter the following command:

  ```
  oc apply -f subscription/subscription-fast.yaml
  ```
  
  After running this command, the list of available fast release images updates with the currently available images in about 1 minute.  

8. View the list of currently available release images in the Advanced Cluster Management for Kubernetes console when you are creating a cluster.
