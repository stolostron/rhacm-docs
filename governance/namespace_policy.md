# Namespace policy

## Namespace policy YAML structure

   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-namespace-1
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
           kind:
           apiVersion:
           metadata:
             name:
        ...
   ```

## Namespace policy table

## Namespace policy sample

Apply the namespace policy to define specific rules for your namespace. Your namespace policy might resemble the following YAML file:
  
   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-namespace-1
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
           kind: Namespace # must have namespace 'prod'
           apiVersion: v1
           metadata:
             name: prod
        ...
   ```
   
### Applying the namespace policy

Complete the following steps to apply the memory usage policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Governance and risk**. 
3. Click **Create policy**. 
4. Select **Namespace** from the _Specifications_ field.