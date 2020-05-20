# Policy overview

Use the Red Hat Advanced Cluster Management for Kubernetes security policy framework to create custom policy controllers and other policies. Kubernetes CustomResourceDefinition (CRD) instance are used to create policies. For more information about CRDs, see [Extend the Kubernetes API with CustomResourceDefinitions](https://kubernetes.io/docs/tasks/access-kubernetes-api/custom-resources/custom-resource-definitions/).

Each Red Hat Advanced Cluster Management for Kubernetes policy can have at least one or more templates. For more details about the policy elements, view the following _Policy YAML table_ section on this page.
 
The policy requires a _PlacementPolicy_ that defines the clusters that the policy document is applied to, and a _PlacementBinding_ that binds the Red Hat Advanced Cluster Management for Kubernetes policy to the `PlacementPolicy`.

**Important**:

* You must create a `PlacementPolicy` with `PlacementRules` to apply your policies to the managed cluster, and bind the `PlacementRule` with a `PlacementBinding`.

* You can create a policy in any namespace on the hub cluster except the cluster namespace. If you create a policy in the cluster namespace, it is by deleted by Red Hat Advanced Cluster Management for Kubernetes.

* Each client and provider is responsible for ensuring that their managed cloud environment meets internal enterprise security standards for software engineering, secure engineering, resiliency, security, and regulatory compliance for workloads hosted on Kubernetes clusters. Use the governance and security capability to gain visibility and remediate configurations to meet standards.


## Policy YAML structure

When you create a policy, you must include required parameter fields and values. Depending on your policy controller, you might need to include other optional fields and values. View the following YAML structure for explained parameter fields:


```yaml
apiVersion: policy.mcm.ibm.com/v1alpha1
kind: Policy
metadata:
  name:
  annotations:
    policy.mcm.ibm.com/standards:
    policy.mcm.ibm.com/categories:
    policy.mcm.ibm.com/controls: 
spec:
  complianceType:
  namespaces:
    exclude:
    include:
  policy-templates:
    - objectDefinition:
        apiVersion:
        kind:
        metadata:
          name:
          labels:
            controller-tools.k8s.io: 
            pci-category:
        spec:
  object-template:
  - complianceType:
    objectDefinition:
      apiVersion:
      kind:
      metadata:
        name:
      spec:
        containers:
        - name:
          image:
          ports:
          - containerPort:
  role-template:
  remediationAction:
  disabled:

---
apiVersion: mcm.ibm.com/v1alpha1
kind: PlacementBinding
metadata:
  name:
placementRef:
  name:
  kind:
  apiGroup:
subjects:
- name:
  kind: 
  apiGroup:

---
apiVersion: apps.open-cluster-management.io/v1
kind: PlacementRule
metadata:
  name:
spec:
  clusterConditions:
  - type:
  clusterLabels:
    matchLabels:
      cloud:
```

## Policy YAML table

|Field|Description|
|-- | -- |
| apiVersion | Required. Set the value to `mcm.ibm.com/v1alpha1`. <!--current place holder until this info is updated--> |
| kind | Required. Set the value to `Policy` to indicate the type of policy. |
| metadata.name | Required. The name for identifying the policy resource. |
| metadata.annotations | Optional. Used to specify a set of security details that describes the set of standards the policy is trying to validate. **Note**: You can view policy violations based on the standards and categories that you define for your policy on the _Policies_ page, from the console. |
| annotations.policy.mcm.ibm.com/standards | Optional. The name or names of security standards the policy is related to. For example, National Institute of Standards and Technology (NIST) and Payment Card Industry (PCI).|
| annotations.policy.mcm.ibm.com/categories | A security control category represent specific requirements for one or more standards. For example, a System and Information Integrity category might indicate that your policy contains a data transfer protocol to protect personal information, as required by the HIPAA and PCI standards. |
| annotations.policy.mcm.ibm.com/controls | The name of the security control that is being checked. For example, Center of Internet Security (CIS) and certificate policy controller.|
| spec | Required. <!--Add a description-->
| spec.complianceType | Reqired. Set the value to `"musthave"`|
| spec.namespace | Required. The namespaces within the hub cluster that the policy is applied to. Enter parameter values for `include`, which are the namespaces you want to apply to the policy to. `exclude` specifies the namespaces you explicitly do not want to apply the policy to.**Note**: A namespace that is specified in the object template of a policy controller, overrides the namespace in the corresponding controller policy.|
| spec.policy-template | Optional. Used to create one or more policies for third party or external security controls. |
| spec.object-template| Optional. Used to list any other Kubernetes object that must be evaluated or applied to the managed clusters. |
| spec.role-template| Optional. Used to list RBAC roles that must be evaluated or applied to the managed clusters. |
| disabled | Required. Set the value to `true` or `false`. The `disabled` parameter provides the ability to enable and disable your policies.|
| remediationAction | Optional. Specifies the remediation of your policy. The parameter values are `enforce` and `inform`. **Important**: Some policies may not support the enforce feature.|
{: caption="Table 1. Required and optional definition fields" caption-side="top"}

## Policy sample file

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
  disabled: false # or true 
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

See [Managing a security policy](create_policy.md) to create and update a policy. You can also enable and update Red Hat Advanced Cluster Management policy controllers to validate the compliance of your policies. See [Policy controllers](policy_controllers.md). See [Governance and risk](compliance_intro.md) for more policy topics.

