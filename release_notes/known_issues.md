# Known issues

<!-- 
Please follow this format:

Title of known issue, be sure to match header and make title, header unique

Hidden comment: Release: #issue
Known issue with workaround if:

- Doesn't work the way it should
- Straightforward to describe
- Good to know before getting started
- Quick workaround, of any
- Applies to most, if not all, users
- Something that is likely to be fixed next release (never preannounce)  

Or consider a troubleshooting topic. 
-->

Review the known issues for Red Hat Advanced Cluster Management for Kubernetes. 

  - [Certificate manager must not exist during an installation](#certificate-manager-must-not-exist-during-an-installation)
  - [LDAP user names are case-sensitive](#ldap-user-names-are-case-sensitive)
  - [CIS policy controller is not installed](#cis-policy-controller-is-not-installed)
  - [Console features might not display in Firefox earlier versions](#console-features-might-not-display-in-firefox-earlier-versions)
  - [Host adoption failed](#host-adoption-failed)
  - [Application not deployed after an updated placement rule](#application-not-deployed-after-an-updated-placement-rule)
  - [Subscription operator does not create a Security Context Constraint (SCC)](#subscription-operator-does-not-create-an-scc)
  - [Unable to search using values with empty spaces](#unable-to-search-using-values-with-empty-spaces)
  - [At logout, user `kubeadmin` gets extra browser tab with blank page](#at-logout-user-kubeadmin-gets-extra-browser-tab-with-blank-page)
  - [_etcd-operator_ does not reconcile the cluster](#etcd-operator-does-not-reconcile-the-cluster)
  - [Helm release name is not exact on Topology view](#helm-release-name-is-not-exact-on-topology-view)
  - [Upgrading an IBM Red Hat OpenShift Kubernetes Service managed cluster is not supported](#upgrading-an-ibm-red-hat-openshift-kubernetes-service-managed-cluster-is-not-supported) 
  - [Importing certain versions of IBM Red Hat OpenShift Kubernetes Service clusters is not supported](#importing-certain-versions-of-ibm-red-hat-openshift-kubernetes-service-clusters-is-not-supported)
   - [Console documentation links in technical preview might be incorrect](#console-documentation-links-in-technical-preview-might-be-incorrect)
   - [Application channels require unique namespaces](#application-channels-require-unique-namespaces)
 
## Certificate manager must not exist during an installation
<!--1.0.0:issue#-->

Certificate manager must not exist on a cluster when you install Red Hat Advanced Cluster Management for Kubernetes.

When certificate manager already exists on the cluster, Red Hat Advanced Cluster Management for Kubernetes installation fails. 

To resolve this issue, verify if the certificate manager is present in your cluster by running the following command: 

   ```
   kubectl get crd | grep certificates.certmanager
   ```

## LDAP user names are case-sensitive
<!--1.0.0:issue#-->

LDAP user names are case-sensitive. You must use the name exactly the way it is configured in your LDAP directory.

## CIS policy controller is not installed
<!--1.0.0:issue#-->

The CIS policy controller is disabled by default when you install Red Hat Advanced Cluster Management for Kubernetes, If you create a CIS policy, you might receive the following message:

   ```
   CIS policy controller is not installed
   ```

You must enable the CIS policy controller. For more information, see _Enable the CIS controller_ on the [CIS policy controller page](../security/create_cis_pol.md) to update the policy.

## Console features might not display in Firefox earlier versions
<!--1.0.0:issue#-->

The product supports Mozilla Firefox 74.0 or the latest version that is available for Linux, macOS, and Windows. Upgrade to the latest version for the best console compatibility. 

## Host adoption failed
<!--1.0.0:issue#-->

Bare metal hosts are not supported. An error message appears when you try to validate the host adoption. 

## Application not deployed after an updated placement rule
<!--1.0.0:issue#-->

If applications are not deploying after an update to a placement rule, verify that the `endpoint-appmgr` pod is running. The `endpoint-appmgr` is the subscription container that needs to run on endpoint clusters.

You can run `oc get pods -n multicluster-endpoint` to verify.

You can also search for `kind:pod cluster:yourcluster` in the console and see if the `endpoint-appmgr` is running.

If you cannot verify, attempt to import the cluster again and verify again.

## Subscription operator does not create an SCC
<!--1.0.0:issue#-->

Learn about Red Hat Openshift Container Platform SCC at [Managing Security Context Constraints (SCC)](ht1.0.0s://docs.openshift.com/container-platform/4.3/authentication/managing-security-context-constraints.html#security-context-constraints-about_configuring-internal-oauth), which is an additional configuration required on the managed cluster. 

Different deployments have different security context and different service accounts. The subscription operator cannot create an SCC automatically. Administrators control permissions for pods. A Security Context Constraints (SCC) CR is required to enable appropriate permissions for the relative service accounts to create pods in the non-default namespace:

To manually create an SCC CR in your namespace, complete the following:

1. Find the service account that is defined in the deployments. For example, see the following `nginx` deployments:

```
nginx-ingress-52edb
nginx-ingress-52edb-backend
```

2. Create an SCC CR in your namespace to assign the required permissions to the service account or accounts. See the following example where `kind: SecurityContextConstraints` is added:

```
apiVersion: security.openshift.io/v1
defaultAddCapabilities:
kind: SecurityContextConstraints
metadata:
  name: ingress-nginx
  namespace: ns-sub-1
priority: null
readOnlyRootFilesystem: false
requiredDropCapabilities: 
fsGroup:
  type: RunAsAny
runAsUser:
  type: RunAsAny
seLinuxContext:
  type: RunAsAny
users:
- system:serviceaccount:my-operator:nginx-ingress-52edb
- system:serviceaccount:my-operator:nginx-ingress-52edb-backend
```

## Unable to search using values with empty spaces
<!--1.0.0:issue#-->

From the console and Visual Web Terminal, users are unable to search for values that contain an empty space. 

## At logout user kubeadmin gets extra browser tab with blank page
<!--1.0.0:issue#--> 

When you are logged in as `kubeadmin` and you click the **Log out** option in the drop-down menu, the console returns to the login screen, but a browser tab opens with a `/logout` URL. The page is blank and you can close the tab without impact to your console.

## _etcd-operator_ does not reconcile the cluster
<!--1.0.0:issue#-->

When you upgrade your OpenShift Container Platform cluster and the etcd persistence is not enabled, the `etcd-operator` does not reconcile you managed clusters. As a result, your managed clusters are removed and you lose most data. 

## Helm release name is not exact on Topology view
<!--1.0.0:1593-->

The _Application Topology_ view from the _Topology_ menu displays only a summary of the application content. To view complete and accurate content of the application, complete the following procedure:

1. Navigate to the _Applications_ menu.
2. Select your application. 
3. You can view a complete topology and summary cards for your selected application.

## Upgrading an IBM Red Hat OpenShift Kubernetes Service managed cluster is not supported
<!--1.0.0:2131-->

You cannot upgrade an IBM Red Hat OpenShift Kubernetes Service managed cluster by using the Red Hat Advanced Cluster Management for Kubernetes interface.

## Importing certain versions of IBM Red Hat OpenShift Kubernetes Service clusters is not supported
<!--1.0.0:2179-->

You cannot import IBM Red Hat OpenShift Kubernetes Service version 3.11 clusters. Later versions of IBM OpenShift Kubernetes Service are supported.

## Console documentation links in technical preview might be incorrect
<!--1.0.0:816-->

For technical preview, documentation links were removed from the console, but a few might still be exposed. Any links to the documentation for preview are temporarily not updated with the correct links.

## Application channels require unique namespaces
<!--1.0.0:2311-->

Creating a channel in the same namespace can cause errors with the hub cluster. For instance, a namespace that is created for both the channel and the hub cluster, such as namepace `charts-v1` will cause errors. Ensure that you create your channel in a unique namespace. All channels need an individual namespace, except GitHub channels, which can share a namespace with another channel. See the process for Managing channles(../manage_applications/managing_channels.md) for more information.
