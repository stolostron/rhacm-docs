# Role policy

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
              apiGroups:
              resources:
              verbs:
         ...
   ```
## Role policy table


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

### Applying a role policy

Complete the following steps to apply the role policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console
2. From the navigation menu, click **Govern risk**. 
3. Click **Create policy**. 
4. Select **Role** from the _Specifications_ field.