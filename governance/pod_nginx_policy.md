# Pod nginx policy


## Pod nginx policy YAML structure

  ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-pod
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
           kind: Pod # nginx pod must exist
           metadata:
             name:
           spec:
             containers:
             - image:
               name:
               ports:
               - containerPort:
        ...
   ```
## Pod nginx plicy table


## Pod nginx policy sample

Apply the pod policy to define the container rules for your pods. A nginx pod must exist in your cluster. Your pod policy nginx policy might resemble the following YAML file:

   ```yaml
   apiVersion: policy.mcm.ibm.com/v1alpha1
   kind: Policy
   metadata:
     name: policy-pod
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
           kind: Pod # nginx pod must exist
           metadata:
             name: nginx-pod
           spec:
             containers:
             - image: nginx:1.7.9
               name: nginx
               ports:
               - containerPort: 80
        ...
   ```

### Applying the pod policy

Complete the following steps to apply the pod policy from the console:

1. Log in to your Red Hat Advanced Cluster Management for Kubernetes console
2. From the navigation menu, click **Govern risk**. 
3. Click **Create policy**. 
4. Select **Pod** from the _Specifications_ field.

<!--rough draft will update this page, currently a place holder, applying will be moved-->