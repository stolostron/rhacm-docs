#Troubleshooting an offline cluster

## Symptom: Cluster status is offline

After you complete the procedure for creating a cluster, you cannot access it from the Red Hat Advanced Cluster Management console, and it shows a status of `offline`.

## Resolving the problem: Cluster status is offline

1. Determine if the managed cluster is available. You can check this in the _Clusters_ area of the Red Hat Advanced Cluster Management console. 

   If it is not available, try rerestarting the managed cluster.

2. Look for network or connectivity issues in the log of the `endpoint-connmgr` pod. 

   If there are errors for connectivity problems, fix the connectivity issues and restart the `endpoint-connmgr` pod.

3. Verify that the `klusterlet` is working correctly by checking the log for the `endpoint-workmgr` pod.

   If the `klusterlet` is not working correctly, restart the `endpoint-workmgr` pod. 
