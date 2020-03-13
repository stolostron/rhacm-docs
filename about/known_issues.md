---

copyright:
  years: 2019, 2020
lastupdated: "2020-03-11"

---

{:new_window: target="_blank"}
{:shortdesc: .shortdesc}
{:screen: .screen}
{:codeblock: .codeblock}
{:pre: .pre}
{:child: .link .ulchildlink}
{:childlinks: .ullinks}

# Known issues

Review the known issues for Red Hat Advanced Cluster Management for Kubernetes. Additionally, see [Red Hat Advanced Cluster Management for Kubernetes troubleshooting](../troubleshoot/mcm_troubleshoot.md) for troubleshooting topics.
{:shortdesc}

  - [Menu and logo on the console header changes](#1527)
  - [Cannot create a Helm release on a managed cluster](#helm_issue)
  - [Applications fail to install during Helm deployment](#load_error)
  - [Missing data in Grafana for OpenShift Container Platform ](#31754)
  - [Subscription status remains healthy when deployable source is deleted](#29445)
  - [ObjectBucket channels support including only one resource in each object](#194)
  - [Subscriptions that use a secret must be changed before updates to dependency resources can be detected](#611)
  - [Permission issue with Docker Version 18.03 with Ubuntu 16.04 LTS](#31947)
  - [Hub cluster resources display as `local-cluster` in console search results ](#31979)
  - [Visual Web Terminal fails when returning over 200 KB of data](#34145)
  - [Enabling Red Hat Advanced Cluster Management for Kubernetes for the installed monitoring release](#1051)
  - [LDAP user names are case-sensitive](#25735)
  - [Pods are not reachable from the NGINX ingress controller in multitenant isolation mode](#34414)
  
## Menu and logo on the console header changes
{: #1527}

When you navigate to certain pages in the Red Hat Advanced Cluster Management for Kubernetes console, the menu items might shorten and the logo in the header might change from Red Hat Advanced Cluster Management for Kubernetes to Red Hat Advanced Cluster Management for Kubernetes.

To return to the Red Hat Advanced Cluster Management for Kubernetes context, click the button in your browser to go back until you see the Red Hat Advanced Cluster Management for Kubernetes logo in the header, or replace the location of the browser with the following URL:

```
https://HOST:port/multicloud 
```
{: codeblock}

## Cannot create a Helm release on a managed cluster
{: #helm_issue}

You are unable to deploy Helm charts that contain images on a managed cluster. To fix this error, you must configure `ClusterImagePolicy`. Run the following command to configure `ClusterImagePolicy`:

```
apiVersion: securityenforcement.admission.cloud.ibm.com/v1beta1
kind: ClusterImagePolicy
metadata:
  annotations:
    helm.sh/hook: post-install
    helm.sh/hook-weight: "1"
  name: ibmcloud-default-cluster-image-policy
spec:
  repositories:
  - name: <repo_name>
```
{: codeblock}

## Applications fail to install during Helm deployment
{: #load_error}

Applications fail to install during deployment when the ClusterImagePolicy is not configured.

**Note:** Be sure to configure ClusterImagePolicy. View the _Cannot create a Helm release on a remote cluster_ section for information about configuring the policy.

To fix this error, reinstall your application by following the tasks:

1. Verify the status of your application by running the following command:

   ```
   helm list --tls
   ```
   {: codeblock}

2. To delete your application, run the following command:

   ```
   helm delete releaseName --purge
   ```
   {: codeblock}

3. Edit and locate the `ClusterImagePolicy` to push your images to your application. Run the following command:

   ```
   kubectl get clusterimagepolicy
   ```
   {: codeblock}

4. Edit the ClusterImagePolicy by running the following command:

   ```
   kubectl edit clusterimagepolicy <policyname>
   ```
   {: codeblock}

5. Reinstall your application. Run the following command:

   ```
   helm install chartName
   ```
   {: codeblock}

For more details, see the [Helm community issue ![Opens in a new tab](../images/icons/launch-glyph.svg "Opens in a new tab")]( https://github.com/helm/helm/issues/3353){: new_window}.

## Missing data in Grafana for OpenShift Container Platform 
{: #31754}

If any of your managed clusters are OpenShift Container Platform clusters, data for the clusters can be missing within the Grafana dashboard for cluster monitoring.

## Subscription status remains healthy when deployable source is deleted
{: #29445}

If a deployable that was deployed to a managed cluster through a subscription is deleted from the source location where it was stored, the deployable is not removed from the managed cluster. For instance, if a Helm release is deleted from the Helm repository, the Helm release is not removed from the managed cluster and continues to work. The deleted deployable remains on the managed cluster until the associated subscription is deleted or updated to replace the deployable.

## ObjectBucket channels support including only one resource in each object
{: #194}

When you are including resources into the object store, do not include multiple resources in a single object. Object stores are used to store Kubernetes resource YAML files as objects. These files define the Kubernetes resource without wrapping the resource. To include these objects in a channel, each file can define only a single Kubernetes resource.

## Subscriptions that use a secret must be changed before updates to dependency resources can be detected
{: #611}

For a subscription that uses a secret to access a channel, the secret that exists on the Hub cluster. If the secret is updated, the subscription is not able to detect and retrieve the changes for the secret by default. This behavior can result in the secret becoming out of sync between the subscription and the actual secret resource. When changes are then made for the dependency resources for the subscribed channel, such as ConfigMaps or secrets, the subscription does not able to detect the changes by default.

To synchronize the subscription with the updated resources, you must edit the subscription. To update a subscription, you can add a label to the subscription, such as with the following command:

```
kubectl label subscription <subscription-name> -n <subscription-namespace> <label-name>=<any-content>
```
{: codeblock}

When the subscription is changed, the subscription controller is triggered to synchronize with the referenced secret and the subscribed channel resources.

## Permission issue with Docker Version 18.03 with Ubuntu 16.04 LTS
{: #31947}

If you use Docker Version 18.03 or higher with Ubuntu 16.04 LTS, containers that run as non-root might have permission issues. This issue appears to be due to a problem between the overlay storage driver and the kernel.

## Hub cluster resources display as `local-cluster` in console search results
{: #31979}

Search returns and lists each cluster with the resource that you search. For resources in the _hub_ cluster, the cluster name is displayed as _local-cluster_.

## Visual Web Terminal fails when returning over 200 KB of data
{: #34145}

The limit for the returned content of a command that is issued with the Visual Web Terminal is 200 KB. If the returned information exceeds 200 KB, an error is displayed. The workaround is to enter the command using a terminal window that is outside of the Visual Web Terminal.

## Enabling Red Hat Advanced Cluster Management for Kubernetes for the installed monitoring release
{: #1051}

The monitoring chart includes a `standalone` installation option that specifies whether monitoring is available on the Red Hat Advanced Cluster Management for Kubernetes hub cluster. Valid values are for `standalone` are `true` or `false`. If the value is set to `true`, certain monitoring service features that are needed for the Red Hat Advanced Cluster Management for Kubernetes hub cluster, are unavailable. For example, the Grafana dashboard list does not include the {site.data.keyword.mcm_notm}} dashboard that is needed to view metrics for your managed clusters.

Use the following Helm command to check the value of the `standalone` option.

```
helm get values monitoring --tls|grep standalone
```
{: pre}

If `standalone` is set as `true`, set it to `false` to enable monitoring service features for the hub cluster.

1. From the console, access the `monitoring release page` and click **Upgrade**.
2. In the window, provide the following fields:
   - Select `mgmt-charts` in the `Confirm Repository of Chart` section.
   - Select `1.7.1` in the `Version` section.
   - Select `Reuse values` in the `Using previous configured values` section. 
   - In the `Parameters` section, clear the checkbox for `Standalone deployment`. 
3. Click **Upgrade** to start the upgrade process. After the upgrade completes, the monitoring service features are enabled for the Red Hat Advanced Cluster Management for Kubernetes hub cluster.


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
    {: codeblock}
    
  2. Verify that the `kube-system` NETID is set to `0`.
    ```
    oc get netnamespaces kube-system
    ```
    {: codeblock}
    
- For OpenShift Version 4.2, complete the following steps:

  1. Get the `network-operator` pod name.
    ```
    oc get pods -n openshift-network-operator | grep network-operator
    ```
    {: codeblock}
    
  2. Get the default multitenant network settings information.
    ```
    oc exec -n openshift-network-operator -it <network-operator-pod-name> cat /bindata/network/openshift-sdn/004-multitenant.yaml > 004-multitenant.yaml
    ```
    {: codeblock}
    
  3. Edit the `004-multitenant.yaml` file and set the `kube-system` NETID to `0`.
    ```
      apiVersion: network.openshift.io/v1
      kind: NetNamespace
      metadata:
        name: kube-system
      netid: 0
      netname: kube-system
    ```
    {: codeblock}
    
  4. Generate a configmap by using the updated `004-multitenant.yaml` file.  
    ```
    oc create configmap 004-multitenant -n openshift-network-operator --from-file=./004-multitenant.yaml
    ```
    {: codeblock}
    
  5. Open the `network-operator` deployment for editing.
    ```
    oc edit deploy -n openshift-network-operator network-operator
    ```
    {: codeblock}

  6. Add the following content in the `volumes` section.
    ```
      volumes:
      - configMap:
          name: 004-multitenant
        name: 004-multitenant
    ```
    {: codeblock}
    
  7. Add the following content in the `volumeMounts` section.
    ```
      volumeMounts:
      - mountPath: /bindata/network/openshift-sdn/004-multitenant.yaml
        subPath: 004-multitenant.yaml
        name: 004-multitenant
        readOnly: true
    ``` 
    {: codeblock}
    
  8. Wait for the `network-operator` deployment to restart. 
  
  9. Check the `kube-system` NETID. The NETID must be `0`.
    ```
    oc get netnamespaces kube-system 
    ```
    {: codeblock}

