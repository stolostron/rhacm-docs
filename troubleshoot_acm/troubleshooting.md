# Troubleshooting

**Important**: Install the Kubernetes CLI to run the troubleshooting commands. For more information, see _Install and Set Up kubectl_ in the [Kubernetes documentation](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-macos).

View the list of troubleshoot topics for Red Hat Advanced Cluster Management for Kubernetes:

* [Troubleshooting cert-manager-webhook](trouble_cert_webhook.md)
* [Troubleshooting clusters](#troubleshooting-clusters)
* [Troubleshooting installation](#troubleshooting-installation)

## Troubleshooting clusters

Use this section to troubleshoot issues when working with clusters.

### Cluster appears in console with *Pending import* status

#### Symptom {#symptom-2}

After importing a cluster by using the Red Hat Advanced Cluster Management console, the cluster appears in the console with a status of *Pending import*.

#### Identifying the problem {#identifying-the-problem-2}

1. Run the following command on the managed cluster to view the Kubernetes pod name that is having the issue:

  ```
  kubectl get pod -n multicluster-endpoint | grep connmgr
  ```

2. Run the following command on the managed cluster to find the log entry for the error:

  ```
  kubectl logs <connmgr_pod>
  ```
  Replace <connmgr_pod> with the pod name that you identified in step 1.

3. Search the returned results for text that indicates there was a networking connectivity problem. Examples include: `no route to host` or `unable to resolve`.

#### Resolving the problem {#resolving-the-problem-2}

1. Retrieve the port number that is having the problem by entering the following command on the hub cluster:

  ```
  oc get infrastructure cluster -o yaml | grep apiServerURL
  ```

2. Ensure that the hostname from the managed cluster can be resolved, and that outbound connectivity to the host and port is occurring.

  If the communication cannot be established by the managed cluster, the cluster import is not complete. The cluster status for the managed cluster is *Pending import*.

### Cluster appears in console with *Unknown* status

#### Symptom {#symptom-3}

After creating a new cluster by using the Red Hat Advanced Cluster Management for Kubernetes console, the cluster shows a status of _Unknown_ in the console.

#### Identifying the problem {#identifying-the-problem-3}

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

#### Resolving the problem {#resolving-the-problem-3}

After you identify the errors in the logs, complete the steps in the procedure that best match your errors:

##### Log error

  ```
  No subnets provided for zones
  ```

##### Resolution

  Select different zones within the region. One or more of the zones that you selected is not supported. Omit the zone which does not provide the support, or select a different region.

## Troubleshooting installation

Use this section to troubleshoot issues when installing Red Hat Advanced Cluster Management for Kubernetes.

### Symptom {#symptom-4}

Installation process fails to start the `multiclusterhub-operator` after running the `start.sh` script.

### Identifying the problem {#identifying-the-problem-4}

The installation output shows that the installation timed out during the `Wait for multiclusterhub-operator to reach running state (4 min)` step.

### Resolving the problem {#resolving-the-problem-4}

The following workarounds might help resolve this issue:

* An incorrect snapshot format was entered. The correct format is `1.0.0-SNAPSHOT-2020-04-01-02-43-31`. The previous snapshot value that was entered becomes the default value. If it was entered incorrectly, then the correct value must be entered manually during a new installation attempt.

  Run the installation again with the correct snapshot value to resolve this problem.

* An incorrect pull-secret was used. Make sure you selected the *Kubernetes Secret* when you generated the pull secret from Quay. If it is a different format, the output displays the following error when applying the prerequisites:

  ```
  Failed to read Resources YAML file [pull-secret.yaml] encounters a format error.
  ```

  Repeat the steps to create your pull secret, and download the *Kubernetes Secret* to resolve this issue.
