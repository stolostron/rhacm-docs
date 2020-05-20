# Pod nginx policy

Kubernetes configuration policy controller monitors the status of you pod nginx policies. Apply the pod policy to define the container rules for your pods. A nginx pod must exist in your cluster.

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
 <!--this is just a place holder until i revise the parameters, focusing on the format right now-->
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

## Pod nginx policy sample

Your pod policy nginx policy might resemble the following YAML file:

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

Learn how to manage a pod nginx policy, see [Managing a pod nginx policy](create_nginx_policy.md) for more details. View other configuration policies that are monitored by the configuration controller, see [Kubernetes configuration policy controller](config_policy_ctrl.md). See [Manage security policies](manage_policy_overview.md) to manage other policies.
