---

copyright:
  years: 2020
lastupdated: "2020-03-23"

---

# Known issues

Review the known issues for Red Hat Advanced Cluster Management for Kubernetes. Additionally, see [Red Hat Advanced Cluster Management for Kubernetes troubleshooting](../troubleshoot/mcm_troubleshoot.md) for troubleshooting topics.

  - [Cannot create a Helm release on a managed cluster](#helm_issue)
  - [Applications fail to install during Helm deployment](#load_error)
  - [ObjectBucket channels support including only one resource in each object](#194)
  - [Subscriptions that use a secret must be changed before updates to dependency resources can be detected](#611)
  - [Hub cluster resources display as `local-cluster` in console search results ](#31979)
  - [LDAP user names are case-sensitive](#25735)

## Cannot create a Helm release on a managed cluster
{: #helm_issue}
<!--moving to troubleshoot folder possibly-->
You are unable to deploy Helm charts that contain images on a managed cluster. To fix this error, you must configure `ClusterImagePolicy`. Run the following command to configure `ClusterImagePolicy`:

```
apiVersion: securityenforcement.admission.cloud.mcm.com/v1beta1
kind: ClusterImagePolicy
metadata:
  annotations:
    helm.sh/hook: post-install
    helm.sh/hook-weight: "1"
  name: mcm-default-cluster-image-policy
spec:
  repositories:
  - name: <repo_name>
```

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

