# Role policy

Apply a role policy to set rules and permissions for specific roles in your cluster. See [Role-based access control (RBAC)](../governance/security.md) for more information on roles.

## Role policy YAML structure

```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-role
     namespace: mcm
   spec:
     complianceType:
     remediationAction:
     namespaces:
       exclude:
       include:
     role-templates:
       - apiVersion: roletemplate.mcm.ibm.com/v1alpha1 # role must follow defined permissions
         metadata:
           namespace: 
           name:
         selector:
           matchLabels:
             dev:
         complianceType:
         rules:
           - complianceType:
             policyRule:
               apiGroups:
               resources:
               verbs:
          - complianceType:
            policyRule:
              apiGroups:
              resources:
              verbs:
         ...
   ```
## Role policy table

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

## Role policy sample

Apply a role policy to set rules and permissions for specific roles in your cluster. For more information on roles, see [Role-based access control (RBAC)](../governance/security.md). Your role policy might resemble the following YAML file:

   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-role
     namespace: mcm
   spec:
     complianceType: musthave
     remediationAction: inform
     namespaces:
       exclude: ["kube-*"]
       include: ["default"]
     role-templates:
       - apiVersion: roletemplate.mcm.ibm.com/v1alpha1 # role must follow defined permissions
         metadata:
           namespace: "" # will be inferred
           name: operator-role-policy 
         selector:
           matchLabels:
             dev: "true"
         complianceType: musthave # at this level, it means the role must exist with the rules that it must have the following
         rules:
           - complianceType: musthave # at this level, it means if the role exists the rule is a musthave
             policyRule:
               apiGroups: ["extensions", "apps"]
               resources: ["deployments"]
               verbs: ["get", "list", "watch", "create", "delete","patch"]
          - complianceType: "mustnothave" # at this level, it means if the role exists the rule is a mustnothave
            policyRule:
              apiGroups: ["core"]
              resources: ["secrets"]
              verbs: ["get", "list", "watch","delete", "create", "update", "patch"]
         ...
   ```
   
<!--this section will be moved to the task oriented file create_role.md-->

### Applying a role policy

Complete the following steps to apply the role policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console
2. From the navigation menu, click **Govern risk**. 
3. Click **Create policy**. 
4. Select **Role** from the _Specifications_ field.
