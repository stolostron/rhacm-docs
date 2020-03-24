---

copyright:
  years: 2020
lastupdated: "2020-03-23"

---

# Known issues

Review the known issues for Red Hat Advanced Cluster Management for Kubernetes. Additionally, see [Red Hat Advanced Cluster Management for Kubernetes troubleshooting](../troubleshoot/mcm_troubleshoot.md) for troubleshooting topics.

  - [Applications fail to install during Helm deployment](#load_error)
  - [ObjectBucket channels support including only one resource in each object](#194)
  - [Subscriptions that use a secret must be changed before updates to dependency resources can be detected](#611)
  - [Hub cluster resources display as `local-cluster` in console search results ](#31979)
  - [LDAP user names are case-sensitive](#25735)
  - [Pods are not reachable from the NGINX ingress controller in multitenant isolation mode](#34414)
  - [CIS policy controller is not installed](#1087)
  

## Applications fail to install during Helm deployment
{: #load_error}

Applications fail to install during deployment when the ClusterImagePolicy is not configured.

**Note:** Be sure to configure ClusterImagePolicy. View the _Cannot create a Helm release on a remote cluster_ section for information about configuring the policy.

To fix this error, reinstall your application by following the tasks:

1. Verify the status of your application by running the following command:

   ```
   helm list --tls
   ```

2. To delete your application, run the following command:

   ```
   helm delete releaseName --purge
   ```

3. Edit and locate the `ClusterImagePolicy` to push your images to your application. Run the following command:

   ```
   kubectl get clusterimagepolicy
   ```

4. Edit the ClusterImagePolicy by running the following command:

   ```
   kubectl edit clusterimagepolicy <policyname>
   ```

5. Reinstall your application. Run the following command:

   ```
   helm install chartName
   ```

For more details, see the [Helm community issue](https://github.com/helm/helm/issues/3353).

## ObjectBucket channels support including only one resource in each object
{: #194}
<!--not sure if this should be removed-->
When you are including resources into the object store, do not include multiple resources in a single object. Object stores are used to store Kubernetes resource YAML files as objects. These files define the Kubernetes resource without wrapping the resource. To include these objects in a channel, each file can define only a single Kubernetes resource.

## Subscriptions that use a secret must be changed before updates to dependency resources can be detected
{: #611}

For a subscription that uses a secret to access a channel, the secret that exists on the Hub cluster. If the secret is updated, the subscription is not able to detect and retrieve the changes for the secret by default. This behavior can result in the secret becoming out of sync between the subscription and the actual secret resource. When changes are then made for the dependency resources for the subscribed channel, such as ConfigMaps or secrets, the subscription does not able to detect the changes by default.

To synchronize the subscription with the updated resources, you must edit the subscription. To update a subscription, you can add a label to the subscription, such as with the following command:

```
kubectl label subscription <subscription-name> -n <subscription-namespace> <label-name>=<any-content>
```

When the subscription is changed, the subscription controller is triggered to synchronize with the referenced secret and the subscribed channel resources.

## Hub cluster resources display as `local-cluster` in console search results
{: #31979}

Search returns and lists each cluster with the resource that you search. For resources in the _hub_ cluster, the cluster name is displayed as _local-cluster_.

## LDAP user names are case-sensitive
{: #25735}

LDAP user names are case-sensitive. You must use the name exactly the way it is configured in your LDAP directory.

## Pods are not reachable from the NGINX ingress controller in multitenant isolation mode
{: #34414}

In OpenShift clusters with multitenant isolation mode, each project is isolated by default. Network traffic is not allowed between pods or services in different projects. 

To resolve the issue, disable network isolation in the `kube-system` project.

- For OpenShift Version 3.11, complete the following steps:

  1. Set the `kube-system` NETID to `0`. 
    ```
    oc adm pod-network make-projects-global kube-system
    ```
    
  2. Verify that the `kube-system` NETID is set to `0`.
    ```
    oc get netnamespaces kube-system
    ```
    
- For OpenShift Version 4.2, complete the following steps:

  1. Get the `network-operator` pod name.
    ```
    oc get pods -n openshift-network-operator | grep network-operator
    ```
    
  2. Get the default multitenant network settings information.
    ```
    oc exec -n openshift-network-operator -it <network-operator-pod-name> cat /bindata/network/openshift-sdn/004-multitenant.yaml > 004-multitenant.yaml
    ```
    
  3. Edit the `004-multitenant.yaml` file and set the `kube-system` NETID to `0`.
    ```
      apiVersion: network.openshift.io/v1
      kind: NetNamespace
      metadata:
        name: kube-system
      netid: 0
      netname: kube-system
    ```
    
  4. Generate a configmap by using the updated `004-multitenant.yaml` file.  
    ```
    oc create configmap 004-multitenant -n openshift-network-operator --from-file=./004-multitenant.yaml
    ```
    
  5. Open the `network-operator` deployment for editing.
    ```
    oc edit deploy -n openshift-network-operator network-operator
    ```

  6. Add the following content in the `volumes` section.
    ```
      volumes:
      - configMap:
          name: 004-multitenant
        name: 004-multitenant
    ```
    
  7. Add the following content in the `volumeMounts` section.
    ```
      volumeMounts:
      - mountPath: /bindata/network/openshift-sdn/004-multitenant.yaml
        subPath: 004-multitenant.yaml
        name: 004-multitenant
        readOnly: true
    ```
    
  8. Wait for the `network-operator` deployment to restart. 
  
  9. Check the `kube-system` NETID. The NETID must be `0`.
    ```
    oc get netnamespaces kube-system 
    ```

## CIS policy controller is not installed
{: #1087}

The CIS policy controller is disabled by default when you install Red Hat Advanced Cluster Management for Kubernetes, If you create a CIS policy, you might receive the following message:

   ```
   CIS policy controller is not installed
   ```

You must enable the CIS policy controller. For more information, see _Enable the CIS controller_ on the [CIS policy controller page](../compliance/cis_policy_ctrl.md#cisc).

