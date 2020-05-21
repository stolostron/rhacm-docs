# Maintaining a custom list of release images when connected

You might want to ensure that you use the same release image for all of your clusters. To simplify, you can create your own custom list of release images that are available when creating a cluster. Complete the following steps to manage your available release images:

1. Fork the [acm-hive-openshift-releases GitHub repository](https://github.com/open-cluster-management/acm-hive-openshift-releases).

2. Update the `./subscription/channel.yaml` file by changing the `spec: pathname` to access your the GitHub name for your forked repository, instead of `open-cluster-management`. This step specifies where the hub cluster retrieves the release images. Your updated content should look similar to the following example: 

   ```
   spec:
     type: GitHub
     pathname: https://github.com/<forked_content>/acm-hive-openshift-releases.git
   ```
  
   Replace _forked_content_ with the path to your forked repository.

3. Add the `yaml` files for the images that you want available when you create a cluster by using the Red Hat Advanced Cluster Management for Kubernetes console to the _./clusterImageSets/stable/*_ or _./clusterImageSets/fast/*_ directory. **Tip:** You can retrieve the available `yaml` files from the main repository by merging changes into your forked repository.

4. Commit and merge your changes to your forked repository.

5. To synchronize your list of stable release images, enter the following command:

   ```
   oc apply -k subscription/
   ```
  
   After running this command, the list of available stable release images updates with the currently available images in about one minute.
  
6. By default, only the stable images are listed. To synchronize and display the fast release images, enter the following command:

   ```
   oc apply -f subscription/subscription-fast.yaml
   ```
  
   After running this command, the list of available fast release images updates with the currently available images in about 1 minute.  

7. By default, Red Hat Advanced Cluster Management pre-loads a few ClusterImageSets. Use the following commands to list what is available and remove the defaults if desired.

   ```
   oc get clusterImageSets
   oc delete clusterImageSet <clusterImageSet_NAME>
   ```

8. View the list of currently available release images in the Red Hat Advanced Cluster Management console when you are creating a cluster.
