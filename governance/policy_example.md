# Red Hat Advanced Cluster Management for Kubernetes policy example

Each Red Hat Advanced Cluster Management for Kubernetes policy can have at least one or multiple templates. For more details about the policy elements, see [Red Hat Advanced Cluster Management for Kubernetes policy overview](../governance/policy_overview.md).
 
The policy requires a _PlacementPolicy_ that defines the clusters that the policy document is applied to, and a _PlacementBinding_ that binds the Red Hat Advanced Cluster Management for Kubernetes policy to the `PlacementPolicy`. View the example placement policy and placement binding: 

   * Example placement policy that selects clusters based on a label:
      
      ```yaml
      apiVersion: mcm.ibm.com/v1alpha1
      kind: PlacementPolicy
      metadata:
        name: placement1
        namespace: mcm
      spec:
        clusterLabels:
          matchLabels:
            cloud: IBM
      ```
 
   * Example placement binding that binds the placement policy and the policy document:
     
     ```yaml
     apiVersion: mcm.ibm.com/v1alpha1
     kind: PlacementBinding
     metadata:
       name: binding1
       namespace: mcm
     placementRef:
       name: placement1
       kind: PlacementPolicy
       apiGroup: mcm.ibm.com
     subjects:
     - name: policy1
       kind: Policy
       apiGroup: policy.mcm.ibm.com
     ```

  **Important**: The `PlacementPolicy` and `PlacementBinding` can be included in the same `.yaml` file or separate `.yaml` files.

## Policy example

```yaml
apiVersion: policy.mcm.ibm.com/v1alpha1
kind: Policy
metadata:
  name: policy1
  annotations:
    policy.mcm.ibm.com/standards: NIST
    policy.mcm.ibm.com/categories: SystemAndInformationIntegrity, RBAC
    policy.mcm.ibm.com/controls: DifferentControl
  namespace: mcm
spec:
  remediationAction: "enforce" # enforce or inform
  disabled: "false" # or true 
  complianceType: "musthave" # used as default, when missing in a particular sub-template
  namespaces:
    include: ["default"]
    exclude: ["kube*"]
  role-templates:
    - apiVersion: roletemplate.mcm.ibm.com/v1alpha1
      metadata:
        namespace: "" # will be inferred
        name: operator-role
      selector:
        matchLabels:
          dev: "true"
      complianceType: "musthave" # at this level, it means the role must exist with the rules that it must have below
      rules:
        - complianceType: "mustnothave" # at this level, it means if the role exists the rule is a mustnothave  
          policyRule:
            apiGroups: ["core"]
            resources: ["secrets"]
            verbs: ["get", "list", "watch","delete", "create", "update", "patch"]
        - complianceType: "musthave" # at this level, it means if the role exists the rule is a musthave
          policyRule:
            apiGroups: ["core"]
            resources: ["pods"]
            verbs: ["get", "list", "watch"]
  object-templates:
    - complianceType: "musthave"
      objectDefinition:
        kind: RoleBinding
        apiVersion: rbac.authorization.k8s.io/v1
        metadata:
          name: operate-pods-rolebinding
          namespace: default
        subjects:
        - kind: User
          name: admin # Name is case sensitive
          apiGroup: rbac.authorization.k8s.io
        roleRef:
          kind: Role #this must be Role or ClusterRole
          name: operator # this must match the name of the Role or ClusterRole you wish to bind to
          apiGroup: rbac.authorization.k8s.io
    - complianceType: "musthave"
      objectDefinition:
        apiVersion: policy/v1beta1
        kind: PodSecurityPolicy
        metadata:
          name: restricted-mcm
          annotations:
            seccomp.security.alpha.kubernetes.io/allowedProfileNames: '*'
        spec:
          privileged: false # no priviliedged pods
          allowPrivilegeEscalation: false 
          allowedCapabilities:
          - '*'
          volumes:
          - '*'
          hostNetwork: true
          hostPorts:
          - min: 1000 # ports < 1000 are reserved 
            max: 65535
          hostIPC: false
          hostPID: false
          runAsUser:
            rule: 'RunAsAny'
          seLinux:
            rule: 'RunAsAny'
          supplementalGroups:
            rule: 'RunAsAny'
          fsGroup:
            rule: 'RunAsAny'
    - complianceType: "musthave"
      objectDefinition:
        kind: NetworkPolicy
        apiVersion: networking.k8s.io/v1
        metadata:
          namespace: default
          name: deny-from-other-namespaces
        spec:
          podSelector:
            matchLabels:
          ingress:
          - from:
            - podSelector: {} # accept ingress from all pods within this namespace only
    - complianceType: "musthave"
      objectDefinition:
        apiVersion: v1    
        kind: LimitRange  
        metadata:  
          name: mem-limit-range  
        spec:  
          limits:  
          - default:  
              memory: 512Mi  
            defaultRequest:  
              memory: 256Mi  
            type: Container
               
```

See [Red Hat Advanced Cluster Management for Kubernetes Governance and risk](compliance_intro.md) for more policy topics.
