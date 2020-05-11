# Security context constraints (SCC) policy

## SCC policy YAML structure

<!--uremove parameter values-->
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

## SCC policy table

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

### Appliying the SCC policy

Complete the following steps to apply the SCC policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Govern risk**. 
3. Click **Create policy**. 
4. Select **SecurityContextConstraintPolicy** from the _Specifications_ field. 

<!--this section will be removed bc its a task-->