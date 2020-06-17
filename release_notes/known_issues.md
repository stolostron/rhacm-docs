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

### The etcd-operator might not install correctly
<!--1.0.1:no issue-->

When installing Red Hat Advanced Cluster Management on Red Hat OpenShift Container Platform version 4.4.8, or later, the `etcd-operator` might not install in the correct default channel. When this happens, the `etcd-operator` pods do not start. 

These solutions only work when the `etcdcluster` subscription is installed in `clusterwide` mode. You can determine if it is in `clusterwide` mode when the `etcdcluster` subscription is using the `clusterwide-alpha` channel. 

To work around this issue, complete one of the following procedures:

* Run the following command to add the required annotation to the cluster resource: 

   ```
   oc annotate etcdcluster etcd-cluster etcd.database.coreos.com/scope=clusterwide
   ```
   
* Add the following annotations to the cluster resource: 

   ```
   apiVersion: "etcd.database.coreos.com/v1beta2"
   kind: "EtcdCluster"
   metadata:
     name: "example-etcd-cluster"
     ## Adding this annotation make this cluster managed by clusterwide operators
     ## namespaced operators ignore it
     # annotations:
     #   etcd.database.coreos.com/scope: clusterwide
   spec:
     size: 3
     version: "3.2.13"
   ```

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

### A saved search in the console might display incorrect value in Visual Web Terminal
<!--1.0.0:1726-->

If you save your search query and use `savedsearches`, you might see incorrect results in the Visual Web Terminal. The result from the _Search_ page is correct.

### At logout user kubeadmin gets extra browser tab with blank page
<!--1.0.0:2191--> 

When you are logged in as `kubeadmin` and you click the **Log out** option in the drop-down menu, the console returns to the login screen, but a browser tab opens with a `/logout` URL. The page is blank and you can close the tab without impact to your console.

### Console documentation links temporarily removed
<!--1.0.0:816 -- fixed for 2.0 -->

For version 1.0 and fix pack version 1.0.1, documentation links were temporarily removed from the console.

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

## Cluster management known issues

### etcd-operator does not reconcile the cluster
<!--1.0.0:2010-->

When you upgrade your OpenShift Container Platform cluster and the etcd persistence is not enabled, the `etcd-operator` does not reconcile you managed clusters. As a result, your managed clusters are removed and you lose most data. 

### Unsupported value when generating a new import cluster command causes imports to fail
<!--1.0.0:2747-->

When you enter an unsupported value into the `yaml` content before creating your import command, it causes the import command that you are creating and future import commands to fail with the following error:

   ```
   Failed creating cluster resource for import,:secrets "<your_cluster_name>-import" not found. 
   ```

   You can fix this issue by identifying which `endpointconfig` is causing the problem and manually changing the unsupported value to a supported value. 

   1. Check the rcm-controller’s log to try to determine which `endpointconfig` is causing the problem. It is often something like `"yes"` used as a value when `true` is the supported value. An example of the log entry follows:
   
      ```
      E0611 19:28:03.137671       1 reflector.go:123] pkg/mod/k8s.io/client-go@v0.0.0-20191016111102-bec269661e48/tools/cache/reflector.go:96: Failed to list *v1alpha1.EndpointConfig: v1alpha1.EndpointConfigList.Items: []v1alpha1.EndpointConfig: v1alpha1.EndpointConfig.Spec: v1beta1.EndpointSpec.CISControllerConfig: v1beta1.EndpointCISControllerSpec.Enabled: ReadBool: expect t or f, but found ", error found in #10 byte of ...|enabled":"yes"},"clu|..., bigger context ...|ler":{"enabled":true},"cisController":{"enabled":"yes"},"clusterLabels":{"cloud":"auto-detect","vend|...
      ```
      
      In this example, the `cisController` value should be `true`, but is `"yes"`. 
      
   2. Determine which `endpointconfig` contains the issue. by entering the following command:
   
      ```
      oc get endpointconfig --all-namespaces -o yaml | grep -B40 "yes"  | grep 'name: ' | tail -n1
      ```
      
      This command finds the name of the `endpointconfig` that contains the value of `"yes"`.
      
      A result that is similar to the following content is displayed: 
      
      ```
      name: mycluster1
      ```
   
   3. Replace the value `"yes"` with the value `true` by editing the file with a command similar to the following:
   
      ```
      oc edit -n mycluster1 mycluster1 
      ```

   **Notice:** If you have this problem in one of your imported clusters, you cannot import another cluster successfully until you fix it. Even if you import a different cluster, the import fails until the problem is fixed.   
   
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

For product version 1.0, all channels need an individual namespace, except GitHub channels, which can share a namespace with another GitHub channel. See the process for [Creating and managing channels](../manage_applications/managing_channels.md) for more information.

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

## Internal error 500 during login to the console
<!--1.0.1:2414-->	

When Red Hat Advanced Cluster Management for Kubernetes is installed and the OpenShift Container Platform is customized with a custom ingress certificate, a `500 Internal Error` message appears. You are unable to access the console because the OpenShift Container Platform certificate is not included in the Red Hat Advanced Cluster Management for Kuberentes management ingress. Add the OpenShift Container Platform certificate by completing the following steps: 

1. Edit the management ingress deployment:	

   1. Update the `oauth-proxy` container arguments. Run the following command to edit the management ingress deployment:	

      ```	
      oc edit deployment management-ingress -n open-cluster-management	
      ```	

      * Add the following lines to the `oauth-proxy` arguments:	

        ```	
        - --openshift-ca=/etc/tls/ocp/tls.crt	
        - --openshift-ca=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt	
        ```   	

      Your `oauth-proxy` might resemble the following content:	

      ```	
      containers:	
      - args:	
        - --provider=openshift	
        - --upstream=https://localhost:8443	
        - --upstream-ca=/etc/tls/ca/tls.crt	
        - --https-address=:443	
        - --client-id=multicloudingress	
        - --client-secret=multicloudingresssecret	
        - --pass-user-bearer-token=true	
        - --pass-access-token=true	
        - --scope=user:full	
        - --openshift-delegate-urls={"/": {"resource": "projects", "verb": "list"}}	
        - --skip-provider-button=true	
        - --cookie-secure=true	
        - --cookie-expire=12h0m0s	
        - --cookie-refresh=8h0m0s	
        - --tls-cert=/etc/tls/private/tls.crt	
        - --tls-key=/etc/tls/private/tls.key	
        - --cookie-secret=AAECAwQFBgcICQoLDA0OFw==	
        - --openshift-ca=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt	
        - --openshift-ca=/etc/tls/ocp/tls.crt	
      ```	

   2. Add the following parameter value for the volume mount:	

      ```	
      - mountPath: /etc/tls/ocp	
        name: ocp-tls-secret	
      ```	

      Your updated deployment might resemble the following content:	

      ```	
      volumeMounts:	
           - mountPath: /etc/tls/private	
             name: tls-secret	
           - mountPath: /etc/tls/ca	
             name: ca-tls-secret	
           - mountPath: /etc/tls/ocp	
             name: ocp-tls-secret	
      ```	

   3. Add the volume to the deployment: 	

      ```	
      - name: ocp-tls-secret	
        secret:	
          defaultMode: 420	
          secretName: ocp-byo-ca	
      ```	

   4. Optional. Modify the volume for the deployment to reference the customized OpenShift Container Platform certificate:	

      ```	
      - name: tls-secret	
        secret:	
          defaultMode: 420	
          secretName: byo-ingress-tls-secret	
      ```	

      View the following sample of the updated `management-ingress` deployment:	

      ```	
      volumes:	
      - name: tls-secret	
        secret:	
          defaultMode: 420	
          secretName: byo-ingress-tls-secret	
      - name: ocp-tls-secret	
        secret:	
          defaultMode: 420	
          secretName: ocp-byo-ca	
      - name: ca-tls-secret	
        secret:	
          defaultMode: 420	
          secretName: multicloud-ca-cert	
      ```	

    5. Save your deployment.	

2. Optional. Create a secret named `byo-ingress-tls-secret` to contain the OpenShift ingress certificate if you completed the previous step, 1.4. Ensure that the secret is contained in the namespace where Red Hat Advanced Cluster Management for Kubernetes is installed.	

   * Run the following command to create a `byo-ingress-tls-secret`:	

      ```	
      oc create secret tls byo-ingress-tls-secret \	
      --cert=</path/to/cert.crt> \	
      --key=</path/to/cert.key> \	
      -n <namespace>	
      ```	

3. Create a secret named `ocp-byo-ca` to contain the OpenShift Container Platform ingress Ceritificate Authority (CA) used to sign the new certificate. Ensure that the secret is contained in the namespace where Red Hat Advanced Cluster Management for Kubernetes is installed.	

   1. Create the YAML file for the `ocp-byo-ca`. Your content might resemble the following file:	

      ```	
      apiVersion: v1	
      data:	
        tls.crt: <base64 encoded CA certificate>	
        tls.key: ""	
      kind: Secret	
      metadata:	
        name: ocp-byo-ca	
      type: kubernetes.io/tls	
      ```	

      1. Encode the CA certificate by running the following command: 	

         ```	
         cat ca.crt | base64	
         ```	
         `ca.crt` is your CA file.	

      2. Customize the `tls.crt` entry with the encoded value in the yaml file.  	


   2. Save your content in `ocp-ca.yaml` and create the secret. Run the following command:	

      ```	
      oc create -f ocp-ca.yaml	
      ```	
  


 
 
 
        
  


