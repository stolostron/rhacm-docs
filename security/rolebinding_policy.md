# Rolebinding policy

Kubernetes configuration policy controller monitors the status of your rolebinding policy. Apply a rolebinding policy to bind a policy to a namespace in your managed cluster. Learn more details about the namespace policy structure in the following sections.

## Rolebinding policy YAML structure


   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name:
     namespace:
   spec:
     complianceType:
     remediationAction:
     namespaces:
       exclude:
       include:
     object-templates:
       - complianceType:
         objectDefinition:
           kind: RoleBinding # role binding must exist
           apiVersion: rbac.authorization.k8s.io/v1
           metadata:
             name: operate-pods-rolebinding
           subjects:
           - kind: User
             name: admin # Name is case sensitive
             apiGroup:
           roleRef:
             kind: Role #this must be Role or ClusterRole
             name: operator # this must match the name of the Role or ClusterRole you wish to bind to
             apiGroup: rbac.authorization.k8s.io
       ...
   ```

## Rolebinding policy table 

|Field|Description|
|-- | -- |
| apiVersion | Required. Set the value to `policy.mcm.ibm.com/v1alpha1`. <!--current place holder until this info is updated--> |
| kind | Required. Set the value to `Policy` to indicate the type of policy. |
| metadata.name | Required. The name to identify the policy resource. |
| metadata.namespaces | Required. The namespace within the managed cluster where the policy is created. |
| spec | Required. Specifications of how compliancy violations are identified and fixed. |
| spec.complianceType | Required. Set the value to `"musthave"`|
| spec.remediationAction | Optional. Specifies the remediation of your policy. The parameter values are `enforce` and `inform`. **Important**: Some policies may not support the enforce feature.|
| spec.namespace | Required. Managed cluster namespace to which you want to apply the policy. Enter parameter values for `include`, which are the namespaces you want to apply to the policy to. `exclude` specifies the namespaces you explicitly do not want to apply the policy to. **Note**: A namespace that is specified in the object template of a policy controller, overrides the namespace in the corresponding parent policy.|
| spec.object-template| Required. Used to list any other Kubernetes object that must be evaluated or applied to the managed clusters. |
{: caption="Table 1. Required and optional definition fields" caption-side="top"}

## Rolebinding policy sample

Your role binding policy might resemble the following YAML file:

   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-rolebinding
     namespace: mcm
   spec:
     complianceType: musthave
     remediationAction: inform
     namespaces:
       exclude: ["kube-*"]
       include: ["default"]
     object-templates:
       - complianceType: musthave
         objectDefinition:
           kind: RoleBinding # role binding must exist
           apiVersion: rbac.authorization.k8s.io/v1
           metadata:
             name: operate-pods-rolebinding
           subjects:
           - kind: User
             name: admin # Name is case sensitive
             apiGroup: rbac.authorization.k8s.io
           roleRef:
             kind: Role #this must be Role or ClusterRole
             name: operator # this must match the name of the Role or ClusterRole you wish to bind to
             apiGroup: rbac.authorization.k8s.io
       ...
   ```

Learn how to managa a rolebinding policy, see [Managing rolebinding policies](create_rb_policy.md) for more details. See [Kubernetes configuration policy controller](config_policy_ctrl.md) to learn about other configuration policies. See [Manage security policies](manage_policy_overview.md) to manage other policies.
