# Rolebinding policy

## Rolebinding policy YAML structure


   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-rolebinding
     namespace: mcm
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
             apiGroup: rbac.authorization.k8s.io
           roleRef:
             kind: Role #this must be Role or ClusterRole
             name: operator # this must match the name of the Role or ClusterRole you wish to bind to
             apiGroup: rbac.authorization.k8s.io
       ...
   ```

## Rolebinding policy table 

## Rolebinding policy sample

Apply a role binding policy to bind a policy to a namespace in your cluster. Your role binding policy might resemble the following YAML file:

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
   
### Apply a rolebinding policy

Complete the following steps to apply the role binding policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console
2. From the navigation menu, click **Govern risk**. 
3. Click **Create policy**. 
4. Select **Rolebinding** from the _Specifications_ field.