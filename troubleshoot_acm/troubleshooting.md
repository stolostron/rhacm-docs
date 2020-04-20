# Troubleshooting 

**Important**: Install the Kubernetes CLI to run the troubleshooting commands. For more information, see _Install and Set Up kubectl_ in the [Kubernetes documentation](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-macos).

View the list of troubleshoot topics for Red Hat Advanced Cluster Management for Kubernetes: 

* [Troubleshooting cert-manager-webhook](#troubleshooting-cert-manager-webhook)
* [Troubleshooting clusters](#troubleshooting-clusters)
* [Troubleshooting installation](#troubleshooting-installation)


## Troubleshooting cert-manager-webhook

Cert-manager is deployed with a webhook to support RBAC and provide extra validation when `cert-manager` resources are created.

### Symptom

You might see one of the following errors.
```
error: unable to retrieve the complete list of server APIs: admission.certmanager.io/v1beta1: Unauthorized
```

```
failed calling webhook "certificates.admission.certmanager.io": the server is currently unable to handle the request
```

### Resolving the problem

1. Check the following items.
    - Run the following command to see whether the `webhook` and `cainjector` pods are available.

      ```
      # Get the pod names and status
      kubectl get pods -n cert-manager | grep webhook
      ```

    - If the pods are not available, run the following command on each pod and note the errors.
      ```
      kubectl describe <pod name> -n cert-manager
      ```

    - If the pods are missing volume mounts or secrets, check the `cert-manager` namespace for messages that resemble the following.
      ```
      Unable to mount volumes for pod "cert-manager-webhook-ibm-cert-manager-webhook-998687778-4tmlz_cert-manager(52d4e997-ce58-11e9-94c3-06ad18c6690e)": timeout expired waiting for volumes to attach or mount for pod "cert-manager"/"cert-manager-webhook-ibm-cert-manager-webhook-998687778-4tmlz". list of unmounted volumes=[certs]. list of unattached volumes=[certs default-token-8gsfx]
      ```

      ```
      MountVolume.SetUp failed for volume "certs" : secrets "cert-manager-webhook-ibm-cert-manager-webhook-webhook-tls" not found
      ```

    - Does the namespace have the label `certmanager.io/disable-validation=true` on it?

      ```
      # View the cert-manager namespace
      kubectl describe namespace cert-manager
      ```

      The resulting output is similar to the following example. Notice the label.

      ```
      $ kubectl describe namespace cert-manager
       Name:         cert-manager
       Labels:       certmanager.k8s.io/disable-validation=true
                 icp=system
       Annotations:  mcm.ibm.com/accountID: id-mycluster-account
                 mcm.ibm.com/type: System
       Status:       Active
       No resource quota.

       Resource Limits
       Type       Resource  Min  Max   Default Request  Default Limit  Max Limit/Request Ratio
       ----       --------  ---  ---   ---------------  -------------  -----------------------
       Container  cpu       0    800m  300m             800m           -
       Container  memory    0    1Gi   300Mi            1Gi            -
      ```
      {: codeblock}

    - If the label is not on the namespace, add the label and restart the `cert-manager` webhook pods.
      ```
      # Add the label
      kubectl label namespace cert-manager certmanager.io/disable-validation=true
      ```

      ```
      kubectl delete <pod name> -n cert-manager
      ```

    - If the label does exist on the namespace, check the normal `cert-manager` pods and `cert-manager` logs. Are the pods up and running? Are there any errors in the logs?

      ```
      # Get the pod names and statuses
      kubectl get pods -n cert-manager

      # Logs
      kubectl logs -n cert-manager <pod name>
      ```

2. If step 1 does not apply, and everything is up and running, then restart the webhook pods.
   ```
   kubectl delete <pod name> -n cert-manager
   ```

3. If you still face errors, then check the Kubernetes apiserver.
    - Is the apiserver active?
    - Are requests sent by the apiserver?
    - Is the `ValidatingAdmissionWebhook` enabled?
         - For non-Red Hat Advanced Cluster Management for Kubernetes environments, check to see whether you specified `--enable-admission-plugins=` in `kube_apiserver_extra_args` in your `config.yaml`. If you did not, then no need to worry. If you did, make sure `ValidatingAdmissionWebhook` is present in the list.
         - For OpenShift environments, check the `master-config.yaml`. If `admissionConfig.pluginConfig` does not contain `ValidatingAdmissionWebhook`, you must add it.

4. As a last resort, uninstall the webhook to disable it.
   ```
   helm delete cert-manager-webhook --purge --tls
   ```

   **NOTE**: If you uninstall the webhook, you lose the functions that the webhook provides, which is validating the cert-manager resources and preventing non-cluster administrators from using `ClusterIssuers` to issue their certificates.
   
## Troubleshooting clusters

Use this section to troubleshoot issues when working with clusters.

### Symptom

After importing a cluster by using the Red Hat Advanced Cluster Management console, the cluster appears in the console with a status of *Pending import*.

### Identifying the problem

1. Run the following command on the managed cluster to view the Kubernetes pod name that is having the issue:

  ```
  kubectl get pod -n multicluster-endpoint | grep connmgr
  ```

2. Run the following command on the managed cluster to find the log entry for the error:

  ```
  kubectl logs <connmgr_pod>
  ```
  Replace *<connmgr_pod>* with the pod name that you identified in step 1.

3. Search the returned results for text that indicates there was a networking connectivity problem. Examples include: `no route to host` or `unable to resolve`.

### Resolving the problem

1. Retrieve the port number that is having the problem by entering the following command on the hub cluster:

  ```
  oc get infrastructure cluster -o yaml | grep apiServerURL
  ```

2. Ensure that the hostname from the managed cluster can be resolved, and that outbound connectivity to the host and port is occurring.

  If the communication cannot be established by the managed cluster, the cluster import is not complete. The cluster status for the managed cluster is *Pending import".

## Troubleshooting installation

Use this section to troubleshoot issues when installing Red Hat Advanced Cluster Management for Kubernetes.

### Symptom

Installation process fails to start the `multiclusterhub-operator` after running the `start.sh` script.

### Identifying the problem

The installation output shows that the installation timed out during the `Wait for multiclusterhub-operator to reach running state (4 min)` step.

### Resolving the problem

The following workarounds might help resolve this issue:

* An incorrect snapshot format was entered. The correct format is `1.0.0-SNAPSHOT-2020-04-01-02-43-31`. The previous snapshot value that was entered becomes the default value. If it was entered incorrectly, then the correct value must be entered manually during a new installation attempt.

  Run the installation again with the correct snapshot value to resolve this problem.
  
* An incorrect pull-secret was used. Make sure you selected the *Kubernetes Secret* when you generated the pull secret from Quay. If it is a different format, the output displays the following error when applying the prerequisites:

  ```
  Failed to read Resources YAML file [pull-secret.yaml] encounters a format error.
  ```
  
  Repeat the steps to create your pull secret, and download the *Kubernetes Secret* to resolve this issue.
