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
 
* [Installation known issues](#installation-known-issues)
* [Web console known issues](#web-console-known-issues)
* [Cluster management known issues](#cluster-management-known-issues)
* [Application management known issues](#application-management-known-issues) 
* [Security known issues](#security-known-issues)

## Installation known issues

### Host adoption failed
<!--1.0.0:1220-->

Bare metal hosts are not supported. An error message appears when you try to validate the host adoption. 

### Upgrading an IBM Red Hat OpenShift Kubernetes Service managed cluster is not supported
<!--1.0.0:2131-->

You cannot upgrade an IBM Red Hat OpenShift Kubernetes Service managed cluster by using the Red Hat Advanced Cluster Management for Kubernetes interface.

### Importing certain versions of IBM Red Hat OpenShift Kubernetes Service clusters is not supported
<!--1.0.0:2179-->

You cannot import IBM Red Hat OpenShift Kubernetes Service version 3.11 clusters. Later versions of IBM OpenShift Kubernetes Service are supported.

### Certificate manager must not exist during an installation
<!--1.0.0:678-->

Certificate manager must not exist on a cluster when you install Red Hat Advanced Cluster Management for Kubernetes.

When certificate manager already exists on the cluster, Red Hat Advanced Cluster Management for Kubernetes installation fails. 

To resolve this issue, verify if the certificate manager is present in your cluster by running the following command: 

   ```
   kubectl get crd | grep certificates.certmanager
   ```
   
### CIS policy controller is not installed
<!--1.0.0:1087-->

The CIS policy controller is disabled by default when you install Red Hat Advanced Cluster Management for Kubernetes, If you create a CIS policy, you might receive the following message:

   ```
   CIS policy controller is not installed
   ```

You must enable the CIS policy controller. For more information, see _Enable the CIS controller_ in [Managing CIS policies](../security/create_cis_pol.md) to update the policy.

### All users with access to the Red Hat Advanced Cluster Management component namespaces are automatically granted cluster administrator access
<!--1.0.0:2135-->

The Red Hat Advanced Cluster Management components are installed in a single namespace. A `ServiceAccount` with a `ClusterRoleBinding` automatically gives cluster administrator privileges to Red Hat Advanced Cluster Management and to any ID with access to the namespace. For security, do not give anyone access to this namespace who does not already have cluster administrator access. 

The `multicluster-endpoint`, which is the agent on the managed cluster, also requires cluster administrator privileges. The `multicluster-endpoint` is deployed into the `multicluster-endpoint` namespace. For security, do not give anyone access to the `multicluster-endpoint` namespace who does not already have cluster administrator access.

## Web console known issues

### LDAP user names are case-sensitive
<!--1.0.0:before 1.0.0.1-->

LDAP user names are case-sensitive. You must use the name exactly the way it is configured in your LDAP directory.

### Console features might not display in Firefox earlier versions
<!--1.0.0:before 1.0.0.1-->

The product supports Mozilla Firefox 74.0 or the latest version that is available for Linux, macOS, and Windows. Upgrade to the latest version for the best console compatibility. 

### Unable to search using values with empty spaces
<!--1.0.0:1726-->

From the console and Visual Web Terminal, users are unable to search for values that contain an empty space. 

### At logout user kubeadmin gets extra browser tab with blank page
<!--1.0.0:2191--> 

When you are logged in as `kubeadmin` and you click the **Log out** option in the drop-down menu, the console returns to the login screen, but a browser tab opens with a `/logout` URL. The page is blank and you can close the tab without impact to your console.

### Console documentation links in technical preview might be incorrect
<!--1.0.0:816-->

For technical preview, documentation links were removed from the console, but a few might still be exposed. Any links to the documentation for preview are temporarily not updated with the correct links.

### Search is unavailable or missing data for a brief period
<!--1.0.0:1918-->

The memory used by the search data store grows slowly over time and causes pods to restart, when the limit is reached. Search becomes unavailable or the data is out of sync with the managed clusters. The memory leak accelerates when more managed clusters are added. 

You might encounter the following issues:

* Search becomes unavailable or data is out of sync for a brief period.
* Search is unable to display some cluster status.

To mitigate this problem, you can increase the memory limit in the `search-pod-xxxxx-redisgraph` deployment to reduce the frequency of pod restarts. Complete the following steps to update the deployment:

* Run the following command to increase the memory limit in the `search-pod-xxxxx-redisgraph` deployment from the command line interface (CLI):

   ```
   oc patch deployment search-prod-xxxxx-redisgraph -n open-cluster-management -p '{"spec": {"template": {"spec": {"containers":[{"name":"redisgraph","resources": {"limits": {"memory": "4Gi"}}}]}}}}'
   ```

* Update your `search-pod-xxxxx-redisgraph` deployment from the console:

  1. Log in to the Red Hat Advanced Cluster Management for Kubernetes cluster.
  2. Navigate to the _Search_ page and enter `search-prod-xxxxx-redisgraph` deployment. 
  3. Update the `containers.resources.limit.memory` parameter and increase the memory value.
  
**Note**: Your maximum memory is restricted by either your quota, policies, or physical limits of the nodes on your cluster.

### Visual Web Terminal command (oc logs) incomplete or frozen log output
<!--1.0.0:2343-->

The `oc logs` command in Visual Web Terminal attempts to display a total log output for the specified pod and container if the user does not specify a `--tail=` line limit as a parameter. 

A large amount of log data limits the terminal response time as data is retrieved and displayed. If the amount of data is large enough, Visual Web Terminal can appear to be frozen or blocked. To get the output quickly, leave or close the Visual Web Terminal to delete the session, then reopen.

To avoid this known issue, either always specify a reasonable value on the `--tail=` flag for the `oc logs` command, or use `kubectl logs`, which defaults to the last 30 lines unless you specify a different `--tail` value.

## Cluster management known issues

### etcd-operator does not reconcile the cluster
<!--1.0.0:2010-->

When you upgrade your OpenShift Container Platform cluster and the etcd persistence is not enabled, the `etcd-operator` does not reconcile you managed clusters. As a result, your managed clusters are removed and you lose most data. 

## Application management known issues

### Application not deployed after an updated placement rule
<!--1.0.0:1449-->

If applications are not deploying after an update to a placement rule, verify that the `endpoint-appmgr` pod is running. The `endpoint-appmgr` is the subscription container that needs to run on endpoint clusters.

You can run `oc get pods -n multicluster-endpoint` to verify.

You can also search for `kind:pod cluster:yourcluster` in the console and see if the `endpoint-appmgr` is running.

If you cannot verify, attempt to import the cluster again and verify again.

### Subscription operator does not create an SCC
<!--1.0.0:1764-->

Learn about Red Hat Openshift Container Platform SCC at [Managing Security Context Constraints (SCC)](https://docs.openshift.com/container-platform/4.3/authentication/managing-security-context-constraints.html#security-context-constraints-about_configuring-internal-oauth), which is an additional configuration required on the managed cluster. 

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
   
### Helm release name is not exact on Topology view
<!--1.0.0:1593-->

The _Application Topology_ view from the _Topology_ menu displays only a summary of the application content. To view complete and accurate content of the application, complete the following procedure:

1. Navigate to the _Applications_ menu.
2. Select your application. 
3. You can view a complete topology and summary cards for your selected application.

### Application channels require unique namespaces
<!--1.0.0:2311-->

Creating more than one channel in the same namespace can cause errors with the hub cluster. 

For instance, namespace `charts-v1` is used by the installer as a Helm type channel, so do not create any additional channels in `charts-v1`. Ensure that you create your channel in a unique namespace. 

For technical preview, all channels need an individual namespace, except GitHub channels, which can share a namespace with another GitHub channel. See the process for [Creating and managing channels](../manage_applications/managing_channels.md) for more information.

### Application route does not list in the Search page for cluster
<!--1.0.0:1908-->

If none of the targeted managed clusters for a deployed application is a Red Hat OpenShift cluster, the Route resource is not created, even if the _Application Topology_ displays the object. Since the object is not deployed, it does not display during a Search. 

This is the case for all Kubernetes resources that are platform-specific, such as the Route resource. The Application defines these resources, but they are created on the managed clusters only if they match the resource platform.

## Security known issues

### Certificate policies fail to report status
<!--1.0.0:2302-->

You can create and apply multiple certificate policies on a single managed cluster, but each policy must have a different parameter value for the `namespaceSelector`. When mulitiple policies on the same managed cluster use the same `namespaceSelector` value, only one of the policies work as expected.

For more information, see [Certificate policy controller](../security/cert_policy_ctrl.md).

### Any authenticated user can import clusters
<!--1.0.0:2312-->

Any authenticated user of OpenShift Container Platform can provision projects and have administrator privileges to the project and its associated namespace. As the administrator of a namespace, you can generate commands to import clusters into Red Hat Advanced Cluster Management for Kubernetes. To run the generated commands and import the cluster, you must have cluster administrator privileges on the managed cluster. For more information, view the Role-based access control table in the [Security](../security/security_intro.md) topic.
