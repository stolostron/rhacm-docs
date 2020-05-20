# Security context constraints (SCC) policy

Apply a Security context constraints (SCC) policy to control permissions for pods by defining conditions in the policy. For more information see, [Managing Security Context Constraints (SCC)](https://docs.openshift.com/container-platform/4.3/authentication/managing-security-context-constraints.html#security-context-constraints-about_configuring-internal-oauth).

## SCC policy YAML structure

```yaml
apiVersion: policy.mcm.ibm.com/v1alpha1
kind: Policy
metadata:
  name: policy-scc
  namespace: open-cluster-management-policies
  annotations:
    policy.mcm.ibm.com/standards:
    policy.mcm.ibm.com/categories:
    policy.mcm.ibm.com/controls:
spec:
  complianceType:
  remediationAction:
  disabled:
  namespaces:
    exclude:
    include:
  object-templates:
    - complianceType:
      objectDefinition:
        apiVersion:
        kind: SecurityContextConstraints # restricted scc
        metadata:
          annotations:
            kubernetes.io/description:
          name: sample-restricted-scc
        allowHostDirVolumePlugin:
        allowHostIPC:
        allowHostNetwork:
        allowHostPID:
        allowHostPorts:
        allowPrivilegeEscalation:
        allowPrivilegedContainer:
        allowedCapabilities:
        defaultAddCapabilities:
        fsGroup:
         type:
        groups:
        - system:
        priority:
        readOnlyRootFilesystem:
        requiredDropCapabilities:
        runAsUser:
          type:
        seLinuxContext:
          type:
        supplementalGroups:
          type:
        users:
        volumes:
   ---
   apiVersion:
   kind: PlacementBinding
   metadata:
     name: binding-policy-scc
     namespace:
   placementRef:
     name: placement-policy-scc
     kind: PlacementRule
     apiGroup:
   subjects:
   - name:
     kind:
     apiGroup:
   ---
   apiVersion: mcm.ibm.com/v1alpha1
   kind: PlacementBinding
   metadata:
     name: policy-scc-production-clusters
     namespace: open-cluster-management-policies
   placementRef:
     name: production-clusters
     kind: PlacementRule
     apiGroup: apps.open-cluster-management.io
   subjects:
   - name: policy-scc
     kind: Policy
     apiGroup: policy.mcm.ibm.com
   ---
   apiVersion:
   kind: PlacementRule
   metadata:
     name: placement-policy-scc
     namespace:
   spec:
     clusterConditions:
     - type:
     clusterSelector:
       matchExpressions:
  ```

## SCC policy table

<!--place holder until i revise with the correct parameters-->

|Field|Description|
|-- | -- |
| apiVersion | Required. Set the value to `policy.mcm.ibm.com/v1alpha1`. <!--current place holder until this info is updated--> |
| kind | Required. Set the value to `Policy` to indicate the type of policy. |
| metadata.name | Required. The name for identifying the policy resource. |
| metadata.namespaces | Optional. |
| spec.namespace | Required. The namespaces within the hub cluster that the policy is applied to. Enter parameter values for `include`, which are the namespaces you want to apply to the policy to. `exclude` specifies the namespaces you explicitly do not want to apply the policy to. **Note**: A namespace that is specified in the object template of a policy controller, overrides the namespace in the corresponding parent policy.|
| remediationAction | Optional. Specifies the remediation of your policy. The parameter values are `enforce` and `inform`. **Important**: Some policies may not support the enforce feature.|
| disabled | Required. Set the value to `true` or `false`. The `disabled` parameter provides the ability to enable and disable your policies.|
| spec.complianceType | Required. Set the value to `"musthave"`|
| spec.object-template| Optional. Used to list any other Kubernetes object that must be evaluated or applied to the managed clusters. |
{: caption="Table 1. Required and optional definition fields" caption-side="top"}

## SCC policy sample

Apply a Security context constraints (SCC) policy to control permissions for pods by defining conditions in the policy. For more information see, [Managing Security Context Constraints (SCC)](https://docs.openshift.com/container-platform/4.3/authentication/managing-security-context-constraints.html#security-context-constraints-about_configuring-internal-oauth).  Your SCC policy might resemble the following YAML file:


   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-scc
     namespace: open-cluster-management-policies
     annotations:
       policy.mcm.ibm.com/standards: NIST-CSF
       policy.mcm.ibm.com/categories: PR.PT Protective Technology
       policy.mcm.ibm.com/controls: PR.PT-3 Least Functionality
   spec:
     complianceType: musthave
     remediationAction: inform
     disabled: false
     namespaces:
       exclude: ["kube-*"]
       include: ["default"]
     object-templates:
       - complianceType: musthave
         objectDefinition:
           apiVersion: security.openshift.io/v1
           kind: SecurityContextConstraints # restricted scc
           metadata:
             annotations:
               kubernetes.io/description: restricted denies access to all host features and requires pods to be run with a UID, and SELinux context that are allocated to the namespace.  This is the most restrictive SCC and it is used by default for authenticated users.
             name: sample-restricted-scc
           allowHostDirVolumePlugin: false
           allowHostIPC: false
           allowHostNetwork: false
           allowHostPID: false
           allowHostPorts: false
           allowPrivilegeEscalation: true
           allowPrivilegedContainer: false
           allowedCapabilities: []
           defaultAddCapabilities: []
           fsGroup:
             type: MustRunAs
           groups:
           - system:authenticated
           priority: null
           readOnlyRootFilesystem: false
           requiredDropCapabilities:
           - KILL
           - MKNOD
           - SETUID
           - SETGID
           runAsUser:
             type: MustRunAsRange
           seLinuxContext:
             type: MustRunAs
           supplementalGroups:
             type: RunAsAny
           users: []
           volumes:
           - configMap
           - downwardAPI
           - emptyDir
           - persistentVolumeClaim
           - projected
           - secret
   ---
   apiVersion: mcm.ibm.com/v1alpha1
   kind: PlacementBinding
   metadata:
     name: binding-policy-scc
     namespace: open-cluster-management-policies
   placementRef:
     name: placement-policy-scc
     kind: PlacementRule
     apiGroup: apps.open-cluster-management.io
   subjects:
   - name: policy-scc
     kind: Policy
     apiGroup: policy.mcm.ibm.com
   ---
   apiVersion: mcm.ibm.com/v1alpha1
   kind: PlacementBinding
   metadata:
     name: policy-scc-production-clusters
     namespace: open-cluster-management-policies
   placementRef:
     name: production-clusters
     kind: PlacementRule
     apiGroup: apps.open-cluster-management.io
   subjects:
   - name: policy-scc
     kind: Policy
     apiGroup: policy.mcm.ibm.com
   ---
   apiVersion: apps.open-cluster-management.io/v1
   kind: PlacementRule
   metadata:
     name: placement-policy-scc
     namespace: open-cluster-management-policies
   spec:
     clusterConditions:
     - type: OK
     clusterSelector:
       matchExpressions: []
  ```

<!--the following section will be moved to another file where the task will be explained. create_scc.md-->

### Appliying the SCC policy

Complete the following steps to apply the SCC policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Govern risk**. 
3. Click **Create policy**. 
4. Select **SecurityContextConstraintPolicy** from the _Specifications_ field. 

<!--this section will be removed bc its a task-->
