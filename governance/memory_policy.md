# Memory usage policy 

## Memory usage policy YAML structure

Apply the limit range policy to limit or restrict your memory and compute usage. For more information, see _Limit Ranges_ in the [Kubernetes documentation](https://kubernetes.io/docs/concepts/policy/limit-range/). Your memory usage policy might resemble the following YAML file:

   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-limitrange
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
           apiVersion:
           kind:
           metadata:
             name:
           spec:
             limits:
             - default:
                 memory:
               defaultRequest:
                 memory:
               type: 
           ...
   ```

## Memory policy table



## Memory policy sample

   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-limitrange
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
           apiVersion: v1
           kind: LimitRange # limit memory usage
           metadata:
             name: mem-limit-range
           spec:
             limits:
             - default:
                 memory: 512Mi
               defaultRequest:
                 memory: 256Mi
               type: Container
           ...
   ```

### Applying the memory usage policy

Complete the following steps to apply the memory usage policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console.
2. From the navigation menu, click **Governance and risk**. 
3. Click **Create policy**. 
4. Select **Limitrange** from the _Specifications_ field.


## Memory usage policy table

Add table. <!--This is a very rough draft will come back and update. Applying the policy should be removed from here because it is a task; consider moving this section to the managing policies part or create a updating policies topic --> 