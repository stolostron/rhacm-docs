# Troubleshooting cluster in console with unknown status

If you receive _Unknown_ status continually on the console of your cluster, follow the procedure to troubleshoot the problem.

## Symptom: Cluster in console with unknown status

After creating a new cluster by using the Red Hat Advanced Cluster Management for Kubernetes console, the cluster shows a status of _Unknown_ in the console.

## Identifying the problem: Cluster in console with unknown status

* Procedure 1

  1. Run the following command on the hub cluster to view the names of the Kubernetes pods that were created in the new cluster's namespace:

     ```
     oc get pod -n <new_cluster_name>
     ```

	 Replace *new_cluster_name* with the name of the cluster that you created.

  2. If no pod that contains the string `provision` in its name is listed, continue with Procedure 2. If there is a pod with `provision` in its title, run the following command on the hub cluster to view the logs of that pod:

     ```
     oc logs <new_cluster_name*provision*pod_name> -n <new_cluster_name> -c hive
     ```

	 Replace *new_cluster_name*provision*pod_name* with the name of the cluster that you created, followed by the pod name that contains `provision`.

  3. Search for errors in the logs that might explain the cause of the problem.

* Procedure 2

  If there is not a pod with `provision` in its name, the problem occurred earlier in the process.

  1. Run the following command on the hub cluster:

     ```
     oc describe clusterdeployments -n <new_cluster_name>
     ```

     Replace *new_cluster_name* with the name of the cluster that you created.

  2. See if there is additional information about the problem in the _Status.Conditions.Message_ and _Status.Conditions.Reason_ entries of the resource.

## Resolving the problem: Cluster in console with unknown status

After you identify the errors in the logs, complete the steps in the procedure that best match your errors. See log error:

   ```
   No subnets provided for zones
   ```

## Resolution: Cluster in console with unknown status

  Select different zones within the region. One or more of the zones that you selected is not supported. Omit the zone which does not provide the support, or select a different region.
